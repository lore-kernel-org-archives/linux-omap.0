From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCHv3 0/2] ARM: dts: Add initial support for IGEP AQUILA
Date: Tue, 10 Sep 2013 16:55:47 +0200
Message-ID: <1378824949-18792-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:40399 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab3IJO5K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Sep 2013 10:57:10 -0400
Received: by mail-ea0-f174.google.com with SMTP id z15so3924916ead.5
        for <linux-omap@vger.kernel.org>; Tue, 10 Sep 2013 07:57:02 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>

Hi all,

These two patches introduces initial support for the IGEP AM335x-based
platforms. The first patch add support for IGEP COM AQUILA products, and the
second patch add support for the development board.

These patches apply on top of bcousson/for_3.12/dts repository.

Changes since v2:
  * Make it compatible with "isee,am335x-base0033", "isee,am335x-igep0033",
    "ti,am33xx" since these boards are manufactured by ISEE not TI. (Javier)
Changes since v1:
  * Use &node to reference the nodes already defined in dtsi files. (Javier)

Best regards,

Enric Balletbo i Serra (2):
  ARM: dts: AM33XX: Add support for IGEP COM AQUILA
  ARM: dts: AM33XX: Add support for IGEP AQUILA EXPANSION board.

 arch/arm/boot/dts/Makefile             |   1 +
 arch/arm/boot/dts/am335x-base0033.dts  |  16 ++
 arch/arm/boot/dts/am335x-igep0033.dtsi | 265 +++++++++++++++++++++++++++++++++
 3 files changed, 282 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-base0033.dts
 create mode 100644 arch/arm/boot/dts/am335x-igep0033.dtsi

-- 
1.8.1.2

