From: Kevin Hilman <khilman@ti.com>
Subject: Re: Question regarding suspend/resume
Date: Mon, 04 Apr 2011 08:12:52 -0700
Message-ID: <87aag6caob.fsf@ti.com>
References: <4D7FBD31.6050806@gmail.com> <87wrk0gn41.fsf@ti.com>
	<4D94E148.8060905@gmail.com> <8739m3auex.fsf@ti.com>
	<4D99D841.9040501@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:34217 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754269Ab1DDPM4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Apr 2011 11:12:56 -0400
Received: by mail-iy0-f177.google.com with SMTP id 39so9449068iyb.22
        for <linux-omap@vger.kernel.org>; Mon, 04 Apr 2011 08:12:55 -0700 (PDT)
In-Reply-To: <4D99D841.9040501@logicpd.com> (Peter Barada's message of "Mon,
	04 Apr 2011 10:40:01 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peter.barada@logicpd.com>
Cc: Peter Barada <peter.barada@gmail.com>, Linux OMAP list <linux-omap@vger.kernel.org>

Peter Barada <peter.barada@logicpd.com> writes:

[...]

>> What I can say based on the register dump you shared is that there is no
>> obvious driver issue going on where a clock was left on by a driver.
>>
>> More than likely what is going on is that the booloader is using a
>> device (e.g. USB, MMC) but is leaving it in a state such that that IP
>> block cannot idle, so the CORE powerdomain then does not fully idle.
>> In older kernels like this one, the linux drivers did not fully reset
>> the hardware so bootloaders could cause problems like this (the u-boot
>> on beagle has had several problems like this.)
>
> How can I determine if an IP block is not idled?  Any suggestion where
> to add code into the suspend patch to do such a check?
>

Unfortunatly, there is no easy way for OMAP3-based platforms.  There are
unfortunately several things that can be (mis)configured such that an IP
block will not properly idle.    This is one of the reasons that
omap_hwmod was introduced.  It  gives a uniform way for IP blocks to be
enabled, idled and shutdown so they are in an a known state.

>> As a first whack at things, I would focus on USB OTG and MMC, as I've
>> seen problem with both on other platforms, like Beagle.  You need to
>> ensure that both the these modules are fully reset either by the
>> bootloader when it's done using them, or by the kernel in the early boot
>> process.  Current kernels now do the latter.
>
> Hmm, where in the current kernel is this done, device driver probe
> functions or common platform init code?
>

As part of the initializion of omap_hwmod for a given IP block, the
module is reset.

Kevin
