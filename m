From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: DSS porting problems
Date: Fri, 05 Jun 2009 05:39:20 -0600
Message-ID: <4A2903E8.7090406@mlbassoc.com>
References: <4A283AF8.5010301@mlbassoc.com> <1244190255.3940.14.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:2194 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbZFELjU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 07:39:20 -0400
In-Reply-To: <1244190255.3940.14.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tomi Valkeinen wrote:
> On Thu, 2009-06-04 at 23:22 +0200, ext Gary Thomas wrote:
>> I'm porting my platform (3530, very similar to LDP) to your tree.
>>   http://www.bat.org/~tomba/git/linux-omap-dss.git
>> Since you have complete support for the 3430SDP, I started with
>> that board file.  I've added my own display (larger Hitachi
>> screen that is 800x600).  I've run into a few problems:
>>
>> * All output to the main frame buffer (/dev/fb0) seems to go to
>> the very last line of the display.
> 
> Difficult to say anything about this. The problem could be in the board
> file configuration, or in the panel driver. 
> 

So the question remains - how do I debug this?  I have a straight
forward LCD panel, much like what's on LDP or Beagle (the two I
know about), just a different model with larger size.  I cloned
the panel description from the sharp_ls and changed the dimensions.

>> * The documentation (Documentation/arm/OMAP/DSS) does not seem
>> to match what's in sysfs.  In particular, there are no "horizontal"
>> or "vertical" fields in the displayN tree.  This makes the examples
>> of how to clone, etc, not work.
> 
> Thanks, I pushed a fix for the documentation.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
