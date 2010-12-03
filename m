From: Felipe Balbi <balbi@ti.com>
Subject: Re: [GIT PULL] FOR TESTING ONLY
Date: Fri, 3 Dec 2010 14:44:53 +0200
Message-ID: <20101203124453.GC2633@legolas.emea.dhcp.ti.com>
References: <20101202114805.GT5429@legolas.emea.dhcp.ti.com>
 <20101202222736.GZ17222@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:59822 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758499Ab0LCMpC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Dec 2010 07:45:02 -0500
Received: by ewy6 with SMTP id 6so5183116ewy.12
        for <linux-omap@vger.kernel.org>; Fri, 03 Dec 2010 04:45:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101202222736.GZ17222@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Thu, Dec 02, 2010 at 02:27:36PM -0800, Tony Lindgren wrote:
>Hi,
>
>* Felipe Balbi <balbi@ti.com> [101202 03:38]:
>> Hi Tony,
>>
>> I have a gigantic amount of patches on musb starting to move it to a
>> place where we can build am35x.c, omap2430.c and tusb6010.c together and
>> have a working binary.
>>
>> There are a few changes still needed (as per comments Mike's comments on
>> linux-usb) but it's working fine on my pandaboard. Mike's comments are
>> mostly cosmetic (appending _musb suffix to function names and adding
>> const to a struct, for example).
>>
>> If you could merge them into linux-omap so we can put the hwmod and
>> pm_runtime patches on top, I'd be glad.
>>
>> Keep in mind that branch still might get rebased, so get ready to merge
>> -s ours :-p
>
>Great, yeah I'll merge them into linux-omap master branch for testing
>probably later on today.

Cool, I just made the updates Mike asked and it's now all good again
:-p

I'm hoping Greg will still accept these patches on monday for merge
window, cross your fingers :-p

for 2.6.39 I'll get them all to build together. Not quite there yet.
TUSB6010 messed up the whole code with ifdefs, I need to check how to do
that one properly.

-- 
balbi
