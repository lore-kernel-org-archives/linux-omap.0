From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 41/50] staging: omap-thermal: document _omap_bandgap_read_threshold function
Date: Fri, 15 Mar 2013 09:00:29 -0400
Message-ID: <1363352438-15935-42-git-send-email-eduardo.valentin@ti.com>
References: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

Add documentation of the function for reading alert thresholds

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/omap-thermal/omap-bandgap.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/omap-thermal/omap-bandgap.c b/drivers/staging/omap-thermal/omap-bandgap.c
index 4cacfc1..aa90539 100644
--- a/drivers/staging/omap-thermal/omap-bandgap.c
+++ b/drivers/staging/omap-thermal/omap-bandgap.c
@@ -510,6 +510,18 @@ exit:
 	return ret;
 }
 
+/**
+ * _omap_bandgap_read_threshold() - helper to read TALERT t_cold or t_hot
+ * @bg_ptr: struct omap_bandgap pointer
+ * @id: bandgap sensor id
+ * @val: value (mCelsius) of a threshold
+ * @hot: desired threshold to be read. true if threshold hot, false if
+ *       threshold cold
+ *
+ * It will fetch the required thresholds (hot and cold) for TALERT signal.
+ * This function can be used to read t_hot or t_cold, depending on @hot value.
+ * Call this function only if bandgap features HAS(TALERT).
+ */
 int _omap_bandgap_read_threshold(struct omap_bandgap *bg_ptr, int id,
 				 int *val, bool hot)
 {
-- 
1.7.7.1.488.ge8e1c
