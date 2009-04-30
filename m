From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: Overo broken with current top of tree
Date: Thu, 30 Apr 2009 12:31:47 +0300
Message-ID: <6ed0b2680904300231y2afa25a7ge192eb3333d7353b@mail.gmail.com>
References: <5e088bd90904290903q1e13afb6g2df13364a7ec0ddf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:39923 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbZD3Jbu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Apr 2009 05:31:50 -0400
Received: by fxm2 with SMTP id 2so1692406fxm.37
        for <linux-omap@vger.kernel.org>; Thu, 30 Apr 2009 02:31:48 -0700 (PDT)
In-Reply-To: <5e088bd90904290903q1e13afb6g2df13364a7ec0ddf@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Brownell <david-b@pacbell.net>, Mark Brown <broonie@sirena.org.uk>

On Wed, Apr 29, 2009 at 7:03 PM, Steve Sakoman <sakoman@gmail.com> wrote:
> I tried an Overo build from the current top of tree and ran into a
> number of twl4030 platform data errors:
>
> twl4030: PIH (irq 7) chaining IRQs 368..375
> twl4030: power (irq 373) chaining IRQs 376..383
> twl4030_gpio: use which platform_data?
> twl4030: gpio (irq 368) chaining IRQs 384..401
> mmci-omap-hs.0: use which platform_data?
> mmci-omap-hs.1: use which platform_data?
> twl4030_usb: use which platform_data?
> twl4030_reg.6: use which platform_data?
> regulator: VMMC1: 1850 <--> 3150 mV normal standby
> twl4030_reg.17: use which platform_data?
> set_machine_constraints: invalid 'VUSB1V5' voltage constraints
> twl4030_reg twl4030_reg.17: can't register VUSB1V5, -22
> twl4030_reg: probe of twl4030_reg.17 failed with error -22
> twl4030_reg.18: use which platform_data?
> set_machine_constraints: invalid 'VUSB1V8' voltage constraints
> twl4030_reg twl4030_reg.18: can't register VUSB1V8, -22
> twl4030_reg: probe of twl4030_reg.18 failed with error -22
> twl4030_reg.19: use which platform_data?
> set_machine_constraints: invalid 'VUSB3V1' voltage constraints
> twl4030_reg twl4030_reg.19: can't register VUSB3V1, -22
> twl4030_reg: probe of twl4030_reg.19 failed with error -22
> i2c_omap i2c_omap.3: bus 3 rev3.12 at 400 kHz
> SCSI subsystem initialized
> twl4030_usb twl4030_usb: ldo init failed
>
> Before I go digging, have there been any recent changes in 4030 init
> that require me to update the Overo board file?

I get the same on pandora, although it continues booting fine after
that. Maybe regulator folks will comment about regulator errors.
