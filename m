From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: dts: omap4-panda-common: Fix pin muxing for
 wl12xx
Date: Thu, 21 Nov 2013 08:58:23 -0800
Message-ID: <20131121165823.GM10317@atomide.com>
References: <1385041804-19115-1-git-send-email-balajitk@ti.com>
 <1385041804-19115-2-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63680 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177Ab3KUQ61 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Nov 2013 11:58:27 -0500
Content-Disposition: inline
In-Reply-To: <1385041804-19115-2-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: bcousson@baylibre.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Balaji T K <balajitk@ti.com> [131121 05:51]:
> pin mux wl12xx_gpio and wl12xx_pins should be part of omap4_pmx_core
> and not omap4_pmx_wkup. So, move wl12xx_* to omap4_pmx_core.
> 
> Fix the following error message:
> pinctrl-single 4a31e040.pinmux: mux offset out of range: 0x38 (0x38)
> pinctrl-single 4a31e040.pinmux: could not add functions for pinmux_wl12xx_pins 56x
> 
> SDIO card is not detected after moving pin mux to omap4_pmx_core since
> sdmmc5_clk pull is disabled. Enable Pull up on sdmmc5_clk to detect SDIO card.

Cool, does this fix the issue with the WLAN not coming up after a warm reset
on panda?

Regards,

Tony
