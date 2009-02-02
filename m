From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: new PM branch available
Date: Mon, 02 Feb 2009 12:06:00 -0800
Message-ID: <87skmwbo47.fsf@deeprootsystems.com>
References: <87iqoij2me.fsf@deeprootsystems.com>
	<20090202174532.GJ4954@codecarver.research.nokia.com>
	<87wsc8bp79.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:64236 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbZBBUGF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Feb 2009 15:06:05 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1633228rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 02 Feb 2009 12:06:03 -0800 (PST)
In-Reply-To: <87wsc8bp79.fsf@deeprootsystems.com> (Kevin Hilman's message of "Mon\, 02 Feb 2009 11\:42\:34 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Hi Peter,
>
> "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:
>
>> Hi Kevin,
>>
>>> Hello,
>>> 
>>> The latest PM branch is now available[1].
>>> 
>>> I've done basic testing of retention and off-mode (suspend and dynamic
>>> idle) on Beagle and custom HW.  My SDP has something still keeping
>>> CORE active that others have not seen, but I have yet to debug.  Any
>>> other reports from SDP testing would be appreciated.
>>> 
>>> Notable changes/updates
>>> - rebased on latest clock updates and fixes from Paul
>>> - clockfw pre- and post- notifiers
>>> - DVFS for VDD2
>>> 
>>
>> I tried it on a beagleboard last night, but couldn't get even static
>> retention to work. Some domains (core, per, dss) stay on, but even mpu
>> and neon don't go to retention. They only go to inactive. 
>
> A first guess: this sounds like CONFIG_OMAP_RESET_CLOCKS=y is missing
> from your .config.
>
> The MPU/NEON going active but not RET is an indication to me that some
> fclk is active so that the fclk check in omap3_can_sleep() fails, so a
> WFI is never attempted.  That's shy
>
> Personally, I'm thinking we should totally drop this fclk check.  I see
> no reason not to attempt a WFI, even if there are active fclks.
>
>> So could you send your .config file ? 
>
> Attached.
>
>> Which rootfs are you using, I'm using debian, so maybe something
>> keeps the CPU busy. Are you using NAND or MMC to store your rootfs ?
>
> I'm using rootfs on MMC and have tested with busybox-only, debian and
> OE rootfs.  With debian and OE, I usually boot a minimal rootfs,
> before a full userland comes up.  With debian, I changed my
> /etc/init.d/rcS to start initlevel 1 instead of 'S'.
>
>> Which beagle HW rev do you have ? I'm testing on a B5 board.
>
> I have a rev B4.
>
>> And which u-boot are you using ?
>
> I'm using the u-boot from Steve Sakoman's tree[1].  That helped a lot
> in my initial Beagle testing, but I think the kernel should reset the
> IVA and D2D now which is the domains that I was having problems with
> before, so I think that the out of the box u-boot should work fine.
>
> Kevin
>
> [1] http://elinux.org/BeagleBoard#U-Boot


One other thing... to fix the noise about unbalanced IRQs upon GPIO
resume, you also need my patch posted to l-o recently:

[PATCH omap-fixes] OMAP2/3: GPIO: remove recursion in IRQ wakeup path

Kevin
