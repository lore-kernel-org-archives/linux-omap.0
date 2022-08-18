Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F193C00140
	for <linux-omap@archiver.kernel.org>; Thu, 18 Aug 2022 13:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245450AbiHRN6W (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 18 Aug 2022 09:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245467AbiHRN6H (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 18 Aug 2022 09:58:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F11B7756;
        Thu, 18 Aug 2022 06:58:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4AE4616F8;
        Thu, 18 Aug 2022 13:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8E1C433C1;
        Thu, 18 Aug 2022 13:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660831086;
        bh=AdTKGhR3ZoSq3QjtGA2FJAdfGi00v8hiRPln1cuwBGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HKIinNsrHytow9Dx2L2W+cW4VJxiYbHQ3FsnCJxNa5P/g03TAe/3LVDUXhMVyw5RC
         QTga7hlm4tduUdWJTAOVSnHDzGDWHJ8uHztAxmHYmBtmhKdmsSSEiYCp8IYqfCcQyV
         vpsgH6lZFVIxwdRVtf5hnCyXrF7uFKESO6zqRgQJX7eq9bXQp6YETRWfdO1jJhi5Ur
         cXIDZQWZJSUIfuSTXZ+eWm3eBfgIfAFdNLhusxedfD/hL4gw5/jhPGm3yCXuERVCIA
         KHX8xAwa5G+4fYG0VoBKN3tVDU05aVar+Y9dbBfnJ0YUCA+ZXPoyMzhRgAua9wzPeL
         zoobriewRCBDw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Tony Lindgren <tony@atomide.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Joel Stanley <joel@jms.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        William Zhang <william.zhang@broadcom.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Michael Walle <michael@walle.cc>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Adam Ford <aford173@gmail.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH 04/11] ARM: defconfig: drop CONFIG_SERIAL_OMAP references
Date:   Thu, 18 Aug 2022 15:57:13 +0200
Message-Id: <20220818135737.3143895-3-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220818135737.3143895-1-arnd@kernel.org>
References: <20220818135522.3143514-1-arnd@kernel.org>
 <20220818135737.3143895-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This driver is mutually exclusive with the new 8250_OMAP
driver, so 'make defconfig' turns it off already. Drop
the reference now.

Fixes: 077e1cde78c3 ("ARM: omap2plus_defconfig: Enable 8250_OMAP")
Fixes: f98d45145e6a ("ARM: multi_v7_defconfig: Enable 8250-omap serial driver and use it by default")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/multi_v7_defconfig  | 2 --
 arch/arm/configs/omap2plus_defconfig | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index ecf743b3409d..4cfe795981c8 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -377,8 +377,6 @@ CONFIG_SERIAL_MSM=y
 CONFIG_SERIAL_MSM_CONSOLE=y
 CONFIG_SERIAL_VT8500=y
 CONFIG_SERIAL_VT8500_CONSOLE=y
-CONFIG_SERIAL_OMAP=y
-CONFIG_SERIAL_OMAP_CONSOLE=y
 CONFIG_SERIAL_BCM63XX=y
 CONFIG_SERIAL_BCM63XX_CONSOLE=y
 CONFIG_SERIAL_XILINX_PS_UART=y
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index e273365838cb..89cda0877c52 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -419,8 +419,6 @@ CONFIG_SERIAL_8250_DETECT_IRQ=y
 CONFIG_SERIAL_8250_RSA=y
 CONFIG_SERIAL_8250_OMAP=y
 CONFIG_SERIAL_OF_PLATFORM=y
-CONFIG_SERIAL_OMAP=y
-CONFIG_SERIAL_OMAP_CONSOLE=y
 CONFIG_SERIAL_DEV_BUS=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_SPI=y
-- 
2.29.2

