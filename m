From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Subject: [PATCH 0/2] ARM: dts: Add initial support for IGEP AQUILA
Date: Wed, 19 Jun 2013 10:27:01 +0200
Message-ID: <1371630423-2481-1-git-send-email-eballetbo@iseebcn.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:47911 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932873Ab3FSI1N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jun 2013 04:27:13 -0400
Received: by mail-we0-f171.google.com with SMTP id m46so4243131wev.30
        for <linux-omap@vger.kernel.org>; Wed, 19 Jun 2013 01:27:12 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>

Hi all,

These two patches introduces initial support for the IGEP AM335x-based
platforms. The first patch add support for IGEP COM AQUILA products, and the
second patch add support for the development board.

These patches apply on top of bcousson/for_3.11/dts repository.

Best regards,

Enric Balletbo i Serra (2):
  ARM: dts: AM33XX: Add support for IGEP COM AQUILA
  ARM: dts: AM33XX: Add support for IGEP AQUILA EXPANSION board.

 arch/arm/boot/dts/Makefile             |   3 +-
 arch/arm/boot/dts/am335x-base0033.dts  |  17 +++
 arch/arm/boot/dts/am335x-igep0033.dtsi | 269 +++++++++++++++++++++++++++++++++
 3 files changed, 288 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/am335x-base0033.dts
 create mode 100644 arch/arm/boot/dts/am335x-igep0033.dtsi

-- 
1.8.1.2

