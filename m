From: Archit Taneja <archit@ti.com>
Subject: [PATCH 1/2] v4l: ti-vpe: Fix the data_type value for UYVY VPDMA format
Date: Tue, 3 Dec 2013 17:21:12 +0530
Message-ID: <1386071473-10808-2-git-send-email-archit@ti.com>
References: <1386071473-10808-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1386071473-10808-1-git-send-email-archit@ti.com>
Sender: linux-media-owner@vger.kernel.org
To: linux-media@vger.kernel.org, k.debski@samsung.com
Cc: linux-omap@vger.kernel.org, hverkuil@xs4all.nl, Archit Taneja <archit@ti.com>
List-Id: linux-omap@vger.kernel.org

The data_type value to be programmed in the data descriptors to fetch/write a
UYVY buffer was not mentioned correctly in the older DRA7x documentation. This
caused VPE to fail with UYVY color formats.

Update the data_type value to fix functionality when UYVY format is used.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/media/platform/ti-vpe/vpdma_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti-vpe/vpdma_priv.h b/drivers/media/platform/ti-vpe/vpdma_priv.h
index f0e9a80..c1a6ce1 100644
--- a/drivers/media/platform/ti-vpe/vpdma_priv.h
+++ b/drivers/media/platform/ti-vpe/vpdma_priv.h
@@ -78,7 +78,7 @@
 #define DATA_TYPE_C420				0x6
 #define DATA_TYPE_YC422				0x7
 #define DATA_TYPE_YC444				0x8
-#define DATA_TYPE_CY422				0x23
+#define DATA_TYPE_CY422				0x27
 
 #define DATA_TYPE_RGB16_565			0x0
 #define DATA_TYPE_ARGB_1555			0x1
-- 
1.8.3.2
