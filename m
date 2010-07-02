From: Grazvydas Ignotas <notasas@gmail.com>
Subject: multipath mux question
Date: Sat, 3 Jul 2010 00:28:01 +0300
Message-ID: <AANLkTikb2w3is46Gw-r22F9n2Ockx5rzOWHGo49cnQ8G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45160 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868Ab0GBV2D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 17:28:03 -0400
Received: by gwj21 with SMTP id 21so83948gwj.19
        for <linux-omap@vger.kernel.org>; Fri, 02 Jul 2010 14:28:01 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Hi,

on OMAP3 CBB package GPIO126 can be muxed on 2 pins: mmc1_dat4 and
cam_strobe. On pandora mmc1_dat4 is connected to mmc1 write protect,
this makes omap2_mmc_mux() call omap_mux_init_gpio() on GPIO126, which
muxes both pins and warns:
mux: Multiple gpio paths for gpio126

This results in unusable GPIO. I wonder how should I handle this,
perhaps overriding mux by calling omap_mux_init_signal() after
omap2_hsmmc_init() call? Or maybe omap_mux_init_gpio() should be
patched not to set up GPIOs if it encounters multiple paths?
