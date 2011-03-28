From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: rx51: "omapfb: no driver for display"
Date: Mon, 28 Mar 2011 10:17:23 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404E21D58C2@dbde02.ent.ti.com>
References: <20110327023901.GB20163@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50984 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818Ab1C1Erq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Mar 2011 00:47:46 -0400
In-Reply-To: <20110327023901.GB20163@earth.universe>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Sebastian Reichel
> Sent: Sunday, March 27, 2011 8:09 AM
> To: linux-omap@vger.kernel.org
> Subject: rx51: "omapfb: no driver for display"
> 
> Hi,
> 
> I've got problems getting a working tty with the mainline 2.6.38
> kernel on my Nokia N900. Here is the related output from dmesg:
> 
> $ grep -E "(omapdss|omapfb|acx565akm)" dmesg
> [    0.890899] omapdss CORE: clk ick, rate 83000000
> [    0.890930] omapdss CORE: clk dss1_fck, rate 96000000
> [    0.890991] omapdss CORE: clk dss2_fck, rate 19200000
> [    0.891021] omapdss CORE: clk tv_fck, rate 54000000
> [    0.891052] omapdss CORE: clk video_fck, rate 96000000
> [    0.891143] omapdss CORE: initial ctx id 0
> [    0.950469] omapdss CORE: save context
> [    0.950714] omapdss CORE: bus_match. dev display0/panel-acx565akm, drv
> panel-acx565akm
> [    0.950775] omapdss CORE: driver_probe: dev display0/panel-acx565akm,
> drv panel-acx565akm
> [    0.950805] omapdss SDI: SDI init
> [    1.004455] omapdss CORE: save context
> [    1.059173] omapdss CORE: save context
> [    1.113830] omapdss CORE: save context
> [    1.129608] acx565akm spi1.2: omapfb: acx565akm rev 8b LCD detected
> [    1.130065] omapdss CORE: probe done for device display0
> [    1.130096] omapdss CORE: bus_match. dev display1/venc, drv panel-
> acx565akm
> [    1.303741] OMAPFB: omapfb_init
> [    1.303894] OMAPFB: omapfb_probe
> [    1.303924] omapfb omapfb: no driver for display
> [    1.304016] omapfb omapfb: failed to setup omapfb
> 
[Hiremath, Vaibhav] it looks like you do not have all display's connected/selected in you board hook up file.

Please refer to the file board-rx51-video.c, where you can find number of displays registered for rx51 platform.

In case of rx51, you have 2 registered displays, lcd and TV.

Thanks,
Vaibhav

> You can find the full dmesg and the full kernel config at [0] and
> [1]. Can you tell me the reason for the "no driver for display"
> message? I thought acx565akm has been registered as display driver
> directly before.
> 
> [0] http://pkg-n900.alioth.debian.org/kernel/2.6.38/config-2.6.38-1-omap
> [1] http://pkg-n900.alioth.debian.org/kernel/2.6.38/dmesg
> 
> -- Sebastian
