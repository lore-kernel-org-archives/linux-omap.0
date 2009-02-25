From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: Re: [patch 2.6.29-rc5-omap-git] mach-omap2/mmc-twl4030: fix for vmmc
 = 0
Date: Wed, 25 Feb 2009 11:45:07 +0200
Message-ID: <49A51323.1030701@nokia.com>
References: <200902231014.26352.david-b@pacbell.net> <49A3DEA8.1050909@nokia.com> <200902241213.06500.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:62428 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761180AbZBYJpj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2009 04:45:39 -0500
In-Reply-To: <200902241213.06500.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

David Brownell wrote:
> On Tuesday 24 February 2009, Adrian Hunter wrote:
>> David Brownell wrote:
>>> From: David Brownell <dbrownell@users.sourceforge.net>
>>>
>>> Resolve longstanding issue noted by Adrian Hunter:  confusion
>>> between settting VSEL=0 (which is 1.8V on MMC1) and poweroff.
>>>
>>> Also, leave VSEL alone if we're just powering the regulator off.
>>>
>>> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
>>> ---
>> Looks fine to me, but I wonder if you know why the regulator is
>> turned on (DEV_GRP) and then the voltage is selected (DEDICATED).
> 
> History, I'd guess.  I seem to remember some sequencing
> constraint, but couldn't find it when last I sought it
> out in the reference manual.

What about section 5.5.1 item 6?

>> Wouldn't it make more sense the other way around?
> 
> I had the same thought.  Eventually I'd like this code
> to mostly wither away ... using the regulator framework
> for the hsmmc driver will eliminate most of the remaining
> bits of twl4030-specific code.  So I'd just leave it be
> for the moment.
> 
> 
>> Doesn't the new regulator framework do it that way?
> 
> No; setting voltage and enabling are distinct operations.

Perhaps, but there are features like regulator constraints,
or the Virtual regulator that do set the voltage and then
enable.

