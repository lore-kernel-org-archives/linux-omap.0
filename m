From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: [PATCH] da8xx: De-constify members in the platform config.
Date: Wed, 31 Oct 2012 17:56:29 +0200
Message-ID: <1351698989-4049-1-git-send-email-panto@antoniou-consulting.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Pantelis Antoniou <panto@antoniou-consulting.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

There's no need for this to be const. It interferes with
creating the platform data dynamically.

Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
---
 include/video/da8xx-fb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/video/da8xx-fb.h b/include/video/da8xx-fb.h
index 5a0e4f9..a512d6b 100644
--- a/include/video/da8xx-fb.h
+++ b/include/video/da8xx-fb.h
@@ -35,9 +35,9 @@ struct display_panel {
 };
 
 struct da8xx_lcdc_platform_data {
-	const char manu_name[10];
+	char manu_name[10];
 	void *controller_data;
-	const char type[25];
+	char type[25];
 	void (*panel_power_ctrl)(int);
 };
 
-- 
1.7.12
