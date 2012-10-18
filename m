From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH 0/2] ARM: OMAP4+: Clk registration update
Date: Thu, 18 Oct 2012 19:38:15 +0300
Message-ID: <1350578297-22572-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46078 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753324Ab2JRQik (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 12:38:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Mike Turquette <mturquette@linaro.org>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grygorii Strashko <grygorii.strashko@ti.com>

Currently we use CK_446X etc to differentiate which clk needs to be registered on which SoC.
The following patch series removes that requirement, instead SoC and SoC variants are
detected on the fly and only the required clocks are registered in the system.
This will help to remove the CK_XYZ macros from the system.

Please comment if this is an acceptable approach - at a first glance,
it seems to pave way to be capable of being replaced potentially by DT data as well.

Grygorii Strashko (2):
  ARM: OMAP2+: clock: Add omap2_clks_register API
  ARM: OMAP4: clock: use omap4_clks_register API

 arch/arm/mach-omap2/clock.c          |   36 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock.h          |    3 +++
 arch/arm/mach-omap2/clock44xx_data.c |   40 ++++++++++++++++++----------------
 3 files changed, 60 insertions(+), 19 deletions(-)

-- 
1.7.9.5

