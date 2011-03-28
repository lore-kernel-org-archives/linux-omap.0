From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: rx51: "omapfb: no driver for display"
Date: Mon, 28 Mar 2011 09:01:29 +0300
Message-ID: <1301292089.2359.21.camel@deskari>
References: <20110327023901.GB20163@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:51700 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751051Ab1C1GBg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Mar 2011 02:01:36 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1068932ewy.19
        for <linux-omap@vger.kernel.org>; Sun, 27 Mar 2011 23:01:32 -0700 (PDT)
In-Reply-To: <20110327023901.GB20163@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: linux-omap@vger.kernel.org

On Sun, 2011-03-27 at 04:39 +0200, Sebastian Reichel wrote:
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
> [    0.950714] omapdss CORE: bus_match. dev display0/panel-acx565akm, drv panel-acx565akm
> [    0.950775] omapdss CORE: driver_probe: dev display0/panel-acx565akm, drv panel-acx565akm
> [    0.950805] omapdss SDI: SDI init
> [    1.004455] omapdss CORE: save context
> [    1.059173] omapdss CORE: save context
> [    1.113830] omapdss CORE: save context
> [    1.129608] acx565akm spi1.2: omapfb: acx565akm rev 8b LCD detected
> [    1.130065] omapdss CORE: probe done for device display0
> [    1.130096] omapdss CORE: bus_match. dev display1/venc, drv panel-acx565akm
> [    1.303741] OMAPFB: omapfb_init
> [    1.303894] OMAPFB: omapfb_probe
> [    1.303924] omapfb omapfb: no driver for display
> [    1.304016] omapfb omapfb: failed to setup omapfb
> 
> You can find the full dmesg and the full kernel config at [0] and
> [1]. Can you tell me the reason for the "no driver for display"
> message? I thought acx565akm has been registered as display driver
> directly before.

You also need VENC driver for the tv-out: CONFIG_OMAP2_DSS_VENC

Granted, DSS could handle this case a bit better, by continuing but
refusing to let the user enable the tv-out...

 Tomi


