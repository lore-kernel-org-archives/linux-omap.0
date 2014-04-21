From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 0/2] ARM: dts: Fix OMAP3 ISP functional clock configuration
Date: Mon, 21 Apr 2014 12:41:45 +0200
Message-ID: <1398076907-2901-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:38057 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbaDUKln (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Apr 2014 06:41:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hello,

This patch set enables rate propagation from the OMAP3 ISP functional clock to
the DPLL4 M5 clock. It copies Tomi Valkeinen's similar patch set for the OMAP
DSS functional clock from the "OMAP: OMAP3 DSS related clock patches" patch
series.

Laurent Pinchart (2):
  ARM: dts: use ti,fixed-factor-clock for dpll4_m5x2_mul_ck
  ARM: dts: set 'ti,set-rate-parent' for dpll4_m5 path

 arch/arm/boot/dts/omap36xx-clocks.dtsi | 2 +-
 arch/arm/boot/dts/omap3xxx-clocks.dtsi | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
Regards,

Laurent Pinchart

