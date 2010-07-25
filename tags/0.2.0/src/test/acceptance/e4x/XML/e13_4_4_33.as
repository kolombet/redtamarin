/* -*- Mode: java; tab-width: 8; indent-tabs-mode: nil; c-basic-offset: 4 -*-
 *
 * ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Rhino code, released
 * May 6, 1999.
 *
 * The Initial Developer of the Original Code is
 * Netscape Communications Corporation.
 * Portions created by the Initial Developer are Copyright (C) 1997-2000
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Igor Bukanov
 *   Ethan Hugg
 *   Milen Nankov
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

START("13.4.4.33 - XML setChildren()");

//TEST(1, true, XML.prototype.hasOwnProperty("setChildren"));

x1 =
<alpha>
    <bravo>one</bravo>
</alpha>;

correct = 
<alpha>
    <charlie>two</charlie>
</alpha>;

x1.setChildren(<charlie>two</charlie>);

TEST(2, correct, x1);

// Replace the entire contents of Jim's employee element
emps =
<employees>
    <employee id="0"><name>Jim</name><age>25</age></employee>
    <employee id="1"><name>Joe</name><age>20</age></employee>
</employees>;

correct =
<employees>
    <employee id="0"><name>John</name><age>35</age></employee>
    <employee id="1"><name>Joe</name><age>20</age></employee>
</employees>;

emps.employee.(name == "Jim").setChildren(<name>John</name> + <age>35</age>);

TEST(3, correct, emps);

XML.prettyPrinting = false;
var xmlDoc = "<employee id='1'><firstname>John</firstname><lastname>Walton</lastname><age>25</age></employee>"
var xmlList = new XMLList ("<firstname>Paul</firstname><lastname>Betlem</lastname><age>35</age>");

// propertyName as a string
AddTestCase( "MYXML = new XML(xmlDoc), MYXML.setChildren(xmlList)", 
	"<employee id=\"1\"><firstname>Paul</firstname><lastname>Betlem</lastname><age>35</age></employee>", 
            (MYXML = new XML(xmlDoc), MYXML.setChildren(xmlList).toString()));

AddTestCase( "MYXML = new XML(xmlDoc), MYXML.setChildren(new XML (\"<firstname>Fred</firstname>\"))", 
	"<employee id=\"1\"><firstname>Fred</firstname></employee>", 
            (MYXML = new XML(xmlDoc), MYXML.setChildren(new XML ("<firstname>Fred</firstname>")).toString()));

AddTestCase( "MYXML = new XML(xmlDoc), MYXML.setChildren('simple string')", 
	"simple string", 
             (MYXML = new XML(xmlDoc), MYXML.setChildren("simple string").toString()));


END();