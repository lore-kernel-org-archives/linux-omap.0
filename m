From: Steve Sakoman <sakoman@gmail.com>
Subject: Overo broken with current top of tree
Date: Wed, 29 Apr 2009 09:03:11 -0700
Message-ID: <5e088bd90904290903q1e13afb6g2df13364a7ec0ddf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:2711 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbZD2QDL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Apr 2009 12:03:11 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1081155qwd.37
        for <linux-omap@vger.kernel.org>; Wed, 29 Apr 2009 09:03:11 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I tried an Overo build from the current top of tree and ran into a
number of twl4030 platform data errors:

twl4030: PIH (irq 7) chaining IRQs 368..375
twl4030: power (irq 373) chaining IRQs 376..383
twl4030_gpio: use which platform_data?
twl4030: gpio (irq 368) chaining IRQs 384..401
mmci-omap-hs.0: use which platform_data?
mmci-omap-hs.1: use which platform_data?
twl4030_usb: use which platform_data?
twl4030_reg.6: use which platform_data?
regulator: VMMC1: 1850 <--> 3150 mV normal standby
twl4030_reg.17: use which platform_data?
set_machine_constraints: invalid 'VUSB1V5' voltage constraints
twl4030_reg twl4030_reg.17: can't register VUSB1V5, -22
twl4030_reg: probe of twl4030_reg.17 failed with error -22
twl4030_reg.18: use which platform_data?
set_machine_constraints: invalid 'VUSB1V8' voltage constraints
twl4030_reg twl4030_reg.18: can't register VUSB1V8, -22
twl4030_reg: probe of twl4030_reg.18 failed with error -22
twl4030_reg.19: use which platform_data?
set_machine_constraints: invalid 'VUSB3V1' voltage constraints
twl4030_reg twl4030_reg.19: can't register VUSB3V1, -22
twl4030_reg: probe of twl4030_reg.19 failed with error -22
i2c_omap i2c_omap.3: bus 3 rev3.12 at 400 kHz
SCSI subsystem initialized
twl4030_usb twl4030_usb: ldo init failed

Before I go digging, have there been any recent changes in 4030 init
that require me to update the Overo board file?

Steve
