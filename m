From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [RESEND #2] [PATCH v2] LEDS: Add output invertion option to backlight
 trigger
Date: Thu, 06 Jan 2011 13:19:12 -0800
Message-ID: <4D2631D0.8030701@oracle.com>
References: <201012091441.51846.jkrzyszt@tis.icnet.pl>	<20110106130440.cfd77c8e.akpm@linux-foundation.org>	<20110106130856.22b92a8b.randy.dunlap@oracle.com> <20110106131659.cedf8500.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:28327 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074Ab1AFVUH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 16:20:07 -0500
In-Reply-To: <20110106131659.cedf8500.akpm@linux-foundation.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Richard Purdie <rpurdie@rpsys.net>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-kernel@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>

On 01/06/11 13:16, Andrew Morton wrote:
> On Thu, 6 Jan 2011 13:08:56 -0800
> Randy Dunlap <randy.dunlap@oracle.com> wrote:
> 
>> On Thu, 6 Jan 2011 13:04:40 -0800 Andrew Morton wrote:
>>
>>> On Thu, 9 Dec 2010 14:41:50 +0100
>>> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:
>>>
>>>> +static DEVICE_ATTR(invert, 0644, bl_trig_invert_show, bl_trig_invert_store);
>>>
>>> This new sysfs file should be documented.  Where would be an
>>> appropriate place for that?  Documentation/leds-class.txt doesn't
>>> mention a sysfs API at all.  
>>> --
>>
>> in Documentation/ABI/, where all sysfs interface info lives.
>>
> 
> Spose so.  Documentation/ABI/stable/sysfs-class-backlight does have
> some stuff in it.
> 
> Personally I tend to regard Documentation/ABI/ as fairly useless
> incomprehensible stuff, maintained to keep Greg happy ;) It'd be better
> to have a nice little well-maintained document for a subsystem such as
> this which actually explains its operation in a useful-to-humans way. 
> Rather than just mechanically filling out forms.
> 
> But a Documentation/ABI update is a heck of a lot better than nothing.

Yes, I was giving you the "where it currently lives", not "what is best."
I agree with you.

-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
