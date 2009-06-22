From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/12] OMAP3: SRAM size fix for HS/EMU devices
Date: Mon, 22 Jun 2009 14:46:23 +0300
Message-ID: <20090622114623.28477.53574.stgit@localhost>
References: <20090622113422.28477.27052.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61149 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755075AbZFVLqX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 07:46:23 -0400
In-Reply-To: <20090622113422.28477.27052.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Tero Kristo <tero.kristo@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

SRAM size fix for HS/EMU devices

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/sram.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index a5b9bcd..1c18de9 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -133,7 +133,12 @@ void __init omap_detect_sram(void)
 			if (cpu_is_omap34xx()) {
 				omap_sram_base = OMAP3_SRAM_PUB_VA;
 				omap_sram_start = OMAP3_SRAM_PUB_PA;
-				omap_sram_size = 0x8000; /* 32K */
+				if ((omap_type() == OMAP2_DEVICE_TYPE_EMU) ||
+				    (omap_type() == OMAP2_DEVICE_TYPE_SEC)) {
+					omap_sram_size = 0x7000; /* 28K */
+				} else {
+					omap_sram_size = 0x8000; /* 32K */
+				}
 			} else {
 				omap_sram_base = OMAP2_SRAM_PUB_VA;
 				omap_sram_start = OMAP2_SRAM_PUB_PA;

