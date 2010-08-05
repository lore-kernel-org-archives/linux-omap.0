From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM branch updated to v2.6.35, SRF dropped
Date: Thu, 05 Aug 2010 15:29:02 -0700
Message-ID: <8739usr8wh.fsf@deeprootsystems.com>
References: <8739uu9em0.fsf@deeprootsystems.com> <4C59F6D1.8050804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:42410 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754029Ab0HEW3F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Aug 2010 18:29:05 -0400
Received: by pxi14 with SMTP id 14so2688745pxi.19
        for <linux-omap@vger.kernel.org>; Thu, 05 Aug 2010 15:29:04 -0700 (PDT)
In-Reply-To: <4C59F6D1.8050804@ti.com> (Nishanth Menon's message of "Wed, 4
	Aug 2010 18:25:05 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> Kevin Hilman had written, on 08/04/2010 05:50 PM, the following:
> [...]
>
>> I've only tested the new PM branch on a couple boards to avoid any
>> further delay getting this version out, update, so hopefully others will
>> help test.
>>
>> I've tested RET on idle & suspend, OFF in idle & suspend on:
>>
>> 3430/omap3evm: works
>>
>> 3630/Zoom3: works
>> - Known problem: console hangs on UART wakeup when  wakeups are enabled using
>>   echo enabled > /sys/devices/platform/serial8250.0/tty/ttyS0/power/wakeup
>>   but I haven't debugged this further.
>
> Just sharing results from SDP testing omap3_pm_defconfig + earlyprintk:
> SDP3430 (with denx.com u-boot, nor boot): does not boot to shell
> full Bootlog: http://pastebin.mozilla.org/761964

Does the same setup boot fine on l-o for-next, or l-o master? 

> SDP3630 (with TI u-boot, xloader, mmc boot): ret works, uart wakeup
> fails for off mode (I am guessing this is similar to Kevin's results)
> full Bootlog: http://pastebin.mozilla.org/761966

> OMAP4 Blaze (with TI u-boot, xloader, mmc boot): does not boot, hell
> lot of crashes - note, need to explicitly enable MACH_OMAP4430_SDP in
> .config
> full Bootlog: http://pastebin.mozilla.org/761968

yeah, I don't expect PM branch to work on OMAP4 until we get the OMAP4 hwmod
core upstream.

Kevin

