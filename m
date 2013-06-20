From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Subject: [PATCHv2 0/2] ARM: dts: Add initial support for IGEP AQUILA
Date: Thu, 20 Jun 2013 10:16:56 +0200
Message-ID: <1371716218-7353-1-git-send-email-eballetbo@iseebcn.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:39185 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604Ab3FTIRI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jun 2013 04:17:08 -0400
Received: by mail-we0-f175.google.com with SMTP id t59so5063552wes.6
        for <linux-omap@vger.kernel.org>; Thu, 20 Jun 2013 01:17:06 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>

Hi all,

These two patches introduces initial support for the IGEP AM335x-based
platforms. The first patch add support for IGEP COM AQUILA products, and the
second patch add support for the development board.

These patches apply on top of bcousson/for_3.11/dts repository.

Changes since v1:
  * Use &node to reference the nodes already defined in dtsi files. (Javier)

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

