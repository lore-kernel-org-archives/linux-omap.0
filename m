From: Archit Taneja <archit@ti.com>
Subject: [PATCH 2/3] OMAPDSS: DISPC: Fix FIR coefficients
Date: Tue, 21 Feb 2012 19:36:31 +0530
Message-ID: <1329833192-16529-3-git-send-email-archit@ti.com>
References: <1329833192-16529-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49300 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755440Ab2BUOGz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Feb 2012 09:06:55 -0500
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id q1LE6tp7004912
	for <linux-omap@vger.kernel.org>; Tue, 21 Feb 2012 08:06:55 -0600
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id q1LE6t9J025625
	for <linux-omap@vger.kernel.org>; Tue, 21 Feb 2012 08:06:55 -0600 (CST)
In-Reply-To: <1329833192-16529-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: lajos@ti.com, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

From: Lajos Molnar <lajos@ti.com>

coef3_M8 had an incorrect phase with 50% more intensity. This resulted in
banding on slightly down/upscaled images. Fixed a rounding error in coef5_M9.

Also removed ARRAY_LEN macro as ARRAY_SIZE is the standard linux one.

Signed-off-by: Lajos Molnar <lajos@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc_coefs.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc_coefs.c b/drivers/video/omap2/dss/dispc_coefs.c
index 069bccb..038c15b 100644
--- a/drivers/video/omap2/dss/dispc_coefs.c
+++ b/drivers/video/omap2/dss/dispc_coefs.c
@@ -19,14 +19,13 @@
 
 #include <linux/kernel.h>
 #include <video/omapdss.h>
-#include "dispc.h"
 
-#define ARRAY_LEN(array) (sizeof(array) / sizeof(array[0]))
+#include "dispc.h"
 
 static const struct dispc_coef coef3_M8[8] = {
 	{ 0,  0, 128,  0, 0 },
 	{ 0, -4, 123,  9, 0 },
-	{ 0, -4, 108, 87, 0 },
+	{ 0, -4, 108, 24, 0 },
 	{ 0, -2,  87, 43, 0 },
 	{ 0, 64,  64,  0, 0 },
 	{ 0, 43,  87, -2, 0 },
@@ -168,7 +167,7 @@ static const struct dispc_coef coef5_M8[8] = {
 
 static const struct dispc_coef coef5_M9[8] = {
 	{  -3,  10, 114,  10,  -3 },
-	{  -6,  24, 110,   0,  -1 },
+	{  -6,  24, 111,   0,  -1 },
 	{  -8,  40, 103,  -7,   0 },
 	{ -11,  58,  91, -11,   1 },
 	{   0, -12,  76,  76, -12 },
@@ -319,7 +318,7 @@ const struct dispc_coef *dispc_ovl_get_scale_coef(int inc, int five_taps)
 	};
 
 	inc /= 128;
-	for (i = 0; i < ARRAY_LEN(coefs); ++i)
+	for (i = 0; i < ARRAY_SIZE(coefs); ++i)
 		if (inc >= coefs[i].Mmin && inc <= coefs[i].Mmax)
 			return five_taps ? coefs[i].coef_5 : coefs[i].coef_3;
 	return NULL;
-- 
1.7.5.4

