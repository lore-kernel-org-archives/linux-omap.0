From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
Subject: [PATCH 3/4] crypto: omap-sham - enable driver for EMU chips
Date: Wed, 20 Apr 2011 13:34:57 +0300
Message-ID: <c59cd9dcab197c7e1124426853afb683633eb70c.1303295558.git.dmitry.kasatkin@nokia.com>
References: <cover.1303295558.git.dmitry.kasatkin@nokia.com>
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <cover.1303295558.git.dmitry.kasatkin@nokia.com>
In-Reply-To: <cover.1303295558.git.dmitry.kasatkin@nokia.com>
References: <cover.1303295558.git.dmitry.kasatkin@nokia.com>
Sender: linux-crypto-owner@vger.kernel.org
To: herbert@gondor.hengli.com.au
Cc: linux-crypto@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

EMU chips also have crypto HW as HS chips.

Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
---
 drivers/crypto/omap-sham.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 50aca41..f5c01dc 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -1295,7 +1295,8 @@ static int __init omap_sham_mod_init(void)
 	pr_info("loading %s driver\n", "omap-sham");
 
 	if (!cpu_class_is_omap2() ||
-		omap_type() != OMAP2_DEVICE_TYPE_SEC) {
+		(omap_type() != OMAP2_DEVICE_TYPE_SEC &&
+			omap_type() != OMAP2_DEVICE_TYPE_EMU)) {
 		pr_err("Unsupported cpu\n");
 		return -ENODEV;
 	}
-- 
1.7.1
