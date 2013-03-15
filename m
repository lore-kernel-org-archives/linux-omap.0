From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 37/50] staging: omap-thermal: update omap_bandgap_set_continous_mode documentation
Date: Fri, 15 Mar 2013 09:00:25 -0400
Message-ID: <1363352438-15935-38-git-send-email-eduardo.valentin@ti.com>
References: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

Simple update on function documentation.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/omap-thermal/omap-bandgap.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/omap-thermal/omap-bandgap.c b/drivers/staging/omap-thermal/omap-bandgap.c
index e325269..d893931 100644
--- a/drivers/staging/omap-thermal/omap-bandgap.c
+++ b/drivers/staging/omap-thermal/omap-bandgap.c
@@ -730,10 +730,13 @@ omap_bandgap_force_single_read(struct omap_bandgap *bg_ptr, int id)
 }
 
 /**
- * enable_continuous_mode() - One time enabling of continuous conversion mode
- * @bg_ptr - pointer to scm instance
+ * omap_bandgap_set_continous_mode() - One time enabling of continuous mode
+ * @bg_ptr: pointer to struct omap_bandgap
  *
- * Call this function only if HAS(MODE_CONFIG) is set
+ * Call this function only if HAS(MODE_CONFIG) is set. As this driver may
+ * be used for junction temperature monitoring, it is desirable that the
+ * sensors are operational all the time, so that alerts are generated
+ * properly.
  */
 static int omap_bandgap_set_continuous_mode(struct omap_bandgap *bg_ptr)
 {
-- 
1.7.7.1.488.ge8e1c
