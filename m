From: Sebastien Guiriec <s-guiriec@ti.com>
Subject: [PATCH 0/3] ARM: OMAP4: Enable AESS IP.
Date: Fri, 4 Jan 2013 14:02:03 +0100
Message-ID: <1357304526-21557-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40803 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513Ab3ADNCP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jan 2013 08:02:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, Tero Kristo <t-kristo@ti.com>, Jon Hunter <jon-hunter@ti.com>

This patch serie extends the the hwmod HWMOD_EXT_OPT_MAIN_CLK flag for the
AESS IP. This IP has additional register for Auto Gatting configuration. As
it is used only for Audio the driver is not always loaded. We can reuse the
same flag as McPDM to work around the HW problem due to bad reset value of
AESS Auto gatting configuration register. 

If we try to setup and reset AESS during boot time without this serie the
next clocks will still remain enable.

omapconf abe cfg:
|--------------------------------------------------------------|
| ABE        Clock Domain Configuration                        |
|--------------------------------|-----------------------------|
| Clock State Transition control | HW-Auto                     |
| Clock State                    |                             |
|   ABE_24M_FCLK                 | GATED                       |
|   ABE_ALWON_32K_CLK            | GATED                       |
|   ABE_SYSCLK                   | GATED                       |
|   24M_FCLK                     | GATED                       |
|   ABE_ICLK2                    | RUNNING                     |
|   DPLL_ABE_X2_CLK              | RUNNING                     |
|   PAD_CLKS                     | GATED                       |
|   SLIMBUS_CLK                  | GATED                       |
| OPP Divider                    | ABE_CLK = DPLL_ABE_X2_CLK/1 |
|--------------------------------------------------------------|

Sebastien Guiriec (3):
  ARM: OMAP2+: hwmod: rename flag to prevent hwmod code from touching
    IP block during init
  ARM: OMAP4: hwmod data: do not enable or reset the AESS during kernel
    init
  OMAP4: hwmod data: Enable AESS hwmod device

 arch/arm/mach-omap2/omap_hwmod.c           |    2 +-
 arch/arm/mach-omap2/omap_hwmod.h           |   10 ++++++++--
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   16 ++++++++++++----
 3 files changed, 21 insertions(+), 7 deletions(-)

-- 
1.7.10.4

