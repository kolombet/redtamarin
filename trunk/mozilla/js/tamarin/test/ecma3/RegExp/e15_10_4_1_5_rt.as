/* ***** BEGIN LICENSE BLOCK *****
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
 * The Original Code is mozilla.org code.
 *
 * The Initial Developer of the Original Code is Netscape
 * Communications Corporation.  Portions created by Netscape are
 * Copyright (C) 1998 Netscape Communications Corporation. All
 * Rights Reserved.
 *
 * Contributor(s):
 *   pschwartau@netscape.com
 *   Adobe AS3 Team
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

/*
* Date: 26 November 2000
*
*
*SUMMARY: Passing a RegExp object to a RegExp() constructor.
*This test arose from Bugzilla bug 61266. The ECMA3 section is:
*
*  15.10.4.1 new RegExp(pattern, flags)
*
*  If pattern is an object R whose [[Class]] property is "RegExp" and
*  flags is undefined, then let P be the pattern used to construct R
*  and let F be the flags used to construct R. If pattern is an object R
*  whose [[Class]] property is "RegExp" and flags is not undefined,
*  then throw a TypeError exception. Otherwise, let P be the empty string
*  if pattern is undefined and ToString(pattern) otherwise, and let F be
*  the empty string if flags is undefined and ToString(flags) otherwise.
*
*
*The current test will check the second scenario outlined above:
*
*   "pattern" is itself a RegExp object R
*   "flags" is NOT undefined
*
* This should throw an exception ... we test for this.
*
*/
//-------------------------------------------------------------------------------------------------

var SECTION = "e15_10_4_1_5_rt";
var VERSION = "";
var TITLE   = "Negative test: Passing (RegExp object, flag) to RegExp() constructor";
var bug = "61266";

startTest();
writeHeaderToLog(SECTION + " " + TITLE);
var testcases = getTestCases();
test();

function getTestCases() {
	var array = new Array();
	var item = 0;

	var statprefix = 'Passing RegExp object on pattern ';
	var statsuffix =  '; passing flag ';
	var cnSUCCESS = 'Got expected exception -';
	var cnFAILURE = 'Expected an exception to be thrown, but none was -';
	var singlequote = "'";
	var i = -1; var j = -1; var s = ''; var f = '';
	var obj1 = null; var obj2 = null;
	var patterns = new Array();
	var flags = new Array();
	var thisError = "no error";

	// various regular expressions to try -
	patterns[0] = '';
	patterns[1] = 'abc';
	patterns[2] = '(.*)(3-1)\s\w';
	patterns[3] = '(.*)(...)\\s\\w';
	patterns[4] = '[^A-Za-z0-9_]';
	patterns[5] = '[^\f\n\r\t\v](123.5)([4 - 8]$)';

	// various flags to try -
	flags[0] = 'i';
	flags[1] = 'g';
	flags[2] = 'm';


	for (i in patterns)
	{
	  s = patterns[i];

	  for (j in flags)
	  {
	    f = flags[j];
	    msg = getStatus(s, f);
	    expect = cnSUCCESS;
	    actual = "";
	    obj1 = new RegExp(s, f);
	    try{
		    obj2 = new RegExp(obj1, f);   // this should cause an exception
		    actual = cnFAILURE;
	    }catch(e:Error){
	        actual = cnSUCCESS;
	    }finally{
	    	array[item++] = new TestCase(SECTION, msg, expect, actual);
	    }
	  }
	}


	function getStatus(regexp, flag)
	{
	  return (statprefix  +  quote(regexp) +  statsuffix  +   flag);
	}


	function quote(text)
	{
	  return (singlequote  +  text  + singlequote);
	}

	return array;
}
