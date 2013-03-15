From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 32/50] staging: omap-thermal: update omap_bandgap_unmask_interrupts documentation
Date: Fri, 15 Mar 2013 09:00:20 -0400
Message-ID: <1363352438-15935-33-git-send-email-eduardo.valentin@ti.com>
References: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

Proper document the function to configure the IRQ event masks.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/omap-thermal/omap-bandgap.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/omap-thermal/omap-bandgap.c b/drivers/staging/omap-thermal/omap-bandgap.c
index 26d36f3..d001323 100644
--- a/drivers/staging/omap-thermal/omap-bandgap.c
+++ b/drivers/staging/omap-thermal/omap-bandgap.c
@@ -337,7 +337,15 @@ exit:
 
 /***   Helper functions handling device Alert/Shutdown signals   ***/
 
-/* Talert masks. Call it only if HAS(TALERT) is set */
+/**
+ * omap_bandgap_unmask_interrupts() - unmasks the events of thot & tcold
+ * @bg_ptr: struct omap_bandgap pointer
+ * @t_hot: hot temperature value to trigger alert signal
+ * @t_cold: cold temperature value to trigger alert signal
+ *
+ * Checks the requested t_hot and t_cold values and configures the IRQ event
+ * masks accordingly. Call this function only if bandgap features HAS(TALERT).
+ */
 static void omap_bandgap_unmask_interrupts(struct omap_bandgap *bg_ptr, int id,
 					   u32 t_hot, u32 t_cold)
 {
-- 
1.7.7.1.488.ge8e1c

