From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/2] OMAP2+: TWL: make conversion routines static
Date: Mon,  3 Jan 2011 12:58:29 -0600
Message-ID: <1294081110-23695-2-git-send-email-nm@ti.com>
References: <1294081110-23695-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51353 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752511Ab1ACS6q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Jan 2011 13:58:46 -0500
In-Reply-To: <1294081110-23695-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony <tony@atomide.com>
Cc: l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>

The uv_to_vsel, vsel_to_uv functions don't need to be exposed to the
world as they are used as function pointers. make them static.

Fixes sparse warnings:
arch/arm/mach-omap2/omap_twl.c:63:15: warning: symbol 'twl4030_vsel_to_uv' was not declared. Should it be static?
arch/arm/mach-omap2/omap_twl.c:68:4: warning: symbol 'twl4030_uv_to_vsel' was not declared. Should it be static?
arch/arm/mach-omap2/omap_twl.c:73:15: warning: symbol 'twl6030_vsel_to_uv' was not declared. Should it be static?
arch/arm/mach-omap2/omap_twl.c:105:4: warning: symbol 'twl6030_uv_to_vsel' was not declared. Should it be static?

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap_twl.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 15f8c6c..65ab4e3 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -60,17 +60,17 @@ static u8 smps_offset;
 
 #define REG_SMPS_OFFSET         0xE0
 
-unsigned long twl4030_vsel_to_uv(const u8 vsel)
+static unsigned long twl4030_vsel_to_uv(const u8 vsel)
 {
 	return (((vsel * 125) + 6000)) * 100;
 }
 
-u8 twl4030_uv_to_vsel(unsigned long uv)
+static u8 twl4030_uv_to_vsel(unsigned long uv)
 {
 	return DIV_ROUND_UP(uv - 600000, 12500);
 }
 
-unsigned long twl6030_vsel_to_uv(const u8 vsel)
+static unsigned long twl6030_vsel_to_uv(const u8 vsel)
 {
 	/*
 	 * In TWL6030 depending on the value of SMPS_OFFSET
@@ -102,7 +102,7 @@ unsigned long twl6030_vsel_to_uv(const u8 vsel)
 		return ((((vsel - 1) * 125) + 6000)) * 100;
 }
 
-u8 twl6030_uv_to_vsel(unsigned long uv)
+static u8 twl6030_uv_to_vsel(unsigned long uv)
 {
 	/*
 	 * In TWL6030 depending on the value of SMPS_OFFSET
-- 
1.6.3.3

