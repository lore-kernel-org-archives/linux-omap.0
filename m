From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] ti-soc-thermal: Fix a typo in a comment line
Date: Wed, 26 Apr 2017 17:39:19 +0200
Message-ID: <f1b47bde-bd8a-2a5d-a6b3-4c721628b243@users.sourceforge.net>
References: <cd524803-b771-c3d2-8906-ee78576c86d4@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <cd524803-b771-c3d2-8906-ee78576c86d4@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 26 Apr 2017 17:11:28 +0200

Add a missing character in this description for a function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 109fb0a5f19f..696ab3046b87 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -1010,7 +1010,7 @@ ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id)
 }
 
 /**
- * ti_bandgap_set_continous_mode() - One time enabling of continuous mode
+ * ti_bandgap_set_continuous_mode() - One time enabling of continuous mode
  * @bgp: pointer to struct ti_bandgap
  *
  * Call this function only if HAS(MODE_CONFIG) is set. As this driver may
-- 
2.12.2
