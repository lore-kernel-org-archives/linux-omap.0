From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 15/50] staging: omap-thermal: remove duplicated code
Date: Fri, 15 Mar 2013 09:00:03 -0400
Message-ID: <1363352438-15935-16-git-send-email-eduardo.valentin@ti.com>
References: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

There is no need to assign twice the same variable with the very same value.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/omap-thermal/omap-bandgap.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/omap-thermal/omap-bandgap.c b/drivers/staging/omap-thermal/omap-bandgap.c
index d0db361..531e853 100644
--- a/drivers/staging/omap-thermal/omap-bandgap.c
+++ b/drivers/staging/omap-thermal/omap-bandgap.c
@@ -164,7 +164,6 @@ static irqreturn_t omap_bandgap_talert_irq_handler(int irq, void *data)
 	u32 t_hot = 0, t_cold = 0, ctrl;
 	int i;
 
-	bg_ptr = data;
 	/* Read the status of t_hot */
 	for (i = 0; i < bg_ptr->conf->sensor_count; i++) {
 		tsr = bg_ptr->conf->sensors[i].registers;
-- 
1.7.7.1.488.ge8e1c
