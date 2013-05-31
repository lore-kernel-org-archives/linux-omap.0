From: Kevin Hilman <khilman@linaro.org>
Subject: [PATCH 0/3] ARM: DTS: misc. OMAP3 fixes for proper wakeup
Date: Fri, 31 May 2013 15:45:54 -0700
Message-ID: <1370040357-25794-1-git-send-email-khilman@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:48741 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755186Ab3EaWqA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 May 2013 18:46:00 -0400
Received: by mail-pd0-f172.google.com with SMTP id 10so2912794pdi.17
        for <linux-omap@vger.kernel.org>; Fri, 31 May 2013 15:46:00 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Benoit,

Here are handful of DT updates while working on getting PM functionality
working for DT boot on OMAP3.

Kevin


Kevin Hilman (3):
  ARM: DTS: OMAP3: beagle/overo: mux console UART, enable wakeup
  ARM: DTS: OMAP3: beagle: enable user button via gpio_keys, enable
    wakeup
  ARM: DTS: TWL4030: fix mux and wakeup for SYS_NIRQ line

 arch/arm/boot/dts/omap3-beagle-xm.dts | 39 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-beagle.dts    | 37 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-overo.dtsi    | 14 +++++++++++++
 arch/arm/boot/dts/twl4030.dtsi        | 17 +++++++++++++++
 4 files changed, 107 insertions(+)

-- 
1.8.2

