From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] ARM: OMAP3: Make I2C bus 2 configurable for BeagleBoard
Date: Fri, 4 Jul 2008 09:55:02 +0300
Message-ID: <20080704095502.a018a17a.jarkko.nikula@nokia.com>
References: <486DC2AF.4010401@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:58920 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbYGDG4W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jul 2008 02:56:22 -0400
In-Reply-To: <486DC2AF.4010401@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap@vger.kernel.org

On Fri, 04 Jul 2008 08:26:55 +0200
"ext Dirk Behme" <dirk.behme@googlemail.com> wrote:

> - Add configuration option for this
> - Use configuration option in board-omap3beagle
> - Ensure correct pin mux if I2C2 is enabled, independent of settings 
> done by bootloader
>
Why this CONFIG_I2C2_OMAP_BEAGLE in mux.c?


Jarkko

--- linux-beagle.orig/arch/arm/mach-omap2/mux.c
+++ linux-beagle/arch/arm/mach-omap2/mux.c
@@ -231,10 +231,12 @@ MUX_CFG_34XX("K21_34XX_I2C1_SCL", 0x1ba,
 		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
 MUX_CFG_34XX("J21_34XX_I2C1_SDA", 0x1bc,
 		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+#ifdef CONFIG_I2C2_OMAP_BEAGLE
 MUX_CFG_34XX("AF15_34XX_I2C2_SCL", 0x1be,
 		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
 MUX_CFG_34XX("AE15_34XX_I2C2_SDA", 0x1c0,
 		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+#endif
 MUX_CFG_34XX("AF14_34XX_I2C3_SCL", 0x1c2,
 		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
 MUX_CFG_34XX("AG14_34XX_I2C3_SDA", 0x1c4,

