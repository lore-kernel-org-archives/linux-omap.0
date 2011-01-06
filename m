From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: More LDP stuff
Date: Thu, 6 Jan 2011 22:10:03 +0530
Message-ID: <e65ceaf93735be6697c31d52325112d2@mail.gmail.com>
References: <20110106153653.GD1198@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:60238 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752867Ab1AFQkF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 11:40:05 -0500
Received: by mail-yi0-f41.google.com with SMTP id 25so4783894yia.0
        for <linux-omap@vger.kernel.org>; Thu, 06 Jan 2011 08:40:04 -0800 (PST)
In-Reply-To: <20110106153653.GD1198@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Russell King - ARM Linux
> Sent: Thursday, January 06, 2011 9:07 PM
> To: linux-omap@vger.kernel.org
> Subject: More LDP stuff
>
> During boot, apart from the watchdog issue, I'm also seeing:
>
> Clocking rate (Crystal/Core/MPU): 26.0/266/500 MHz
> Reprogramming SDRC clock to 266000000 Hz
> dpll3_m2_clk rate change failed: -22
>
> Is that something to be concerned about?
>
DDR is not getting reconfigured and needs to rely on bootloder
settings. Should be ok because DVFS is not yet supported yet.


> ads7846 spi1.0: unable to get regulator: -19
>
> Is something missing from the ldp support code to declare this
> regulator?
Am not sure what is connected to SPI on LDP. But mostly
not an important peripheral.

>
> mmcblk0: retrying using single block read
> (repeated many times)
>
> Is the OMAP HSMMC driver really unable to handle multi-block read
> requests, or is something missing on the LDP to make it work?
Not sure.

Regards
Santosh
