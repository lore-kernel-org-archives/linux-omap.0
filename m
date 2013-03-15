From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 36/50] staging: omap-thermal: rename enable_continuous_mode
Date: Fri, 15 Mar 2013 09:00:24 -0400
Message-ID: <1363352438-15935-37-git-send-email-eduardo.valentin@ti.com>
References: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch names 'enable_continuous_mode' accordingly to the file
standard naming.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/omap-thermal/omap-bandgap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/omap-thermal/omap-bandgap.c b/drivers/staging/omap-thermal/omap-bandgap.c
index 8746187..e325269 100644
--- a/drivers/staging/omap-thermal/omap-bandgap.c
+++ b/drivers/staging/omap-thermal/omap-bandgap.c
@@ -735,7 +735,7 @@ omap_bandgap_force_single_read(struct omap_bandgap *bg_ptr, int id)
  *
  * Call this function only if HAS(MODE_CONFIG) is set
  */
-static int enable_continuous_mode(struct omap_bandgap *bg_ptr)
+static int omap_bandgap_set_continuous_mode(struct omap_bandgap *bg_ptr)
 {
 	int i;
 
@@ -973,7 +973,7 @@ int omap_bandgap_probe(struct platform_device *pdev)
 	}
 
 	if (OMAP_BANDGAP_HAS(bg_ptr, MODE_CONFIG))
-		enable_continuous_mode(bg_ptr);
+		omap_bandgap_set_continuous_mode(bg_ptr);
 
 	/* Set .250 seconds time as default counter */
 	if (OMAP_BANDGAP_HAS(bg_ptr, COUNTER))
-- 
1.7.7.1.488.ge8e1c
