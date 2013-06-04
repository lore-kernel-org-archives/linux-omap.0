From: Mike Turquette <mturquette@linaro.org>
Subject: [PATCH RFC 0/3] first pass converting omap4 clock data to DT
Date: Mon,  3 Jun 2013 23:39:15 -0700
Message-ID: <1370327958-19776-1-git-send-email-mturquette@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:42750 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359Ab3FDGjd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jun 2013 02:39:33 -0400
Received: by mail-pd0-f180.google.com with SMTP id 14so6757793pdc.11
        for <linux-omap@vger.kernel.org>; Mon, 03 Jun 2013 23:39:32 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Tero Kristo <t-kristo@ti.com>, Rajendra <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>, Mike Turquette <mturquette@linaro.org>

This is a very incomplete conversion of a handful of OMAP4 PRCM clocks
from the statically defined clock data in
arch/arm/mach-omap2/cclock44xx_data.c to a new dts file in
arch/arm/boot/dts/omap4-clocks.dtsi.

I am not a DT expert so many of the choices here may be quite disgusting
to look at, or may be on the right path.  In particular I simply include
the new omap4-clocks.dtsi from omap4.dtsi, which feels a bit kludgey.
Also this series depends on the basic clock bindings RFC I posted
earlier today[1].

I actually have an omap4-clock.dtsi file with many more clocks converted
to the mux-clock, divider-clock, fixed-clock, fixed-factor and
(unpublished) gate-clock bindings in my local repo, but it is not
currently booting.  I wanted to get this early preview out regardless.

[1] http://article.gmane.org/gmane.linux.kernel/1501216

Mike Turquette (3):
  clk: omap: introduce clock driver
  ARM: dts: omap4 clock data
  ARM: omap4: register DT clocks & remove old data

 arch/arm/boot/dts/omap4-clocks.dtsi   | 128 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi          |   2 +
 arch/arm/mach-omap2/cclock44xx_data.c |  54 ++------------
 drivers/clk/Makefile                  |   1 +
 drivers/clk/omap/Makefile             |   1 +
 drivers/clk/omap/clk.c                |  55 +++++++++++++++
 include/linux/clk/omap.h              |  24 +++++++
 7 files changed, 217 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap4-clocks.dtsi
 create mode 100644 drivers/clk/omap/Makefile
 create mode 100644 drivers/clk/omap/clk.c
 create mode 100644 include/linux/clk/omap.h

-- 
1.8.1.2

