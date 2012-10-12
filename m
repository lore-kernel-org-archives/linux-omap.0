From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Errors at boot time from OMAP4430SDP (and a whinge about serial stuff)
Date: Fri, 12 Oct 2012 11:47:03 -0700
Message-ID: <87391j1qag.fsf@deeprootsystems.com>
References: <20121012155434.GO28061@n2100.arm.linux.org.uk>
	<20121012162452.GD30339@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:43978 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758111Ab2JLSq6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Oct 2012 14:46:58 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so3084586pad.19
        for <linux-omap@vger.kernel.org>; Fri, 12 Oct 2012 11:46:58 -0700 (PDT)
In-Reply-To: <20121012162452.GD30339@atomide.com> (Tony Lindgren's message of
	"Fri, 12 Oct 2012 09:24:52 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Ohad Ben-Cohen <ohad@wizery.com>, Afzal Mohammed <afzal@ti.com>, =?utf-8?Q?P=C3=A9ter?= Ujfalusi <peter.ujfalusi@ti.com>

Tony Lindgren <tony@atomide.com> writes:

> * Russell King - ARM Linux <linux@arm.linux.org.uk> [121012 08:56]:
>> For those who don't bother looking at my kautobuild boot tests on the OMAP
>> boards I have, here's the errors which get spat out at boot time.  Note
>> that some of these I've reported in the past, and one of them is missing
>> a newline character at the end of its string.

[...]

>
>> omap_vc_i2c_init: I2C config for vdd_iva does not match other channels (0).
>> omap_vc_i2c_init: I2C config for vdd_mpu does not match other channels (0).Power Management for TI OMAP4.
>
> Kevin?

Have had a fix for this for awhile, but it's currently part of a broader
VC/VP feature set.  I thought about breaking it out as its own fix, but
since voltage scaling is currently not supported/working on OMAP4
anyways, I decided it was not urgent.

Kevin
