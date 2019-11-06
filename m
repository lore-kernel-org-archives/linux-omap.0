From: Benoit Parrot <bparrot@ti.com>
Subject: [Patch v3 5/5] media: ti-vpe: vpe: fix compatible to match bindings
Date: Wed, 6 Nov 2019 14:26:22 -0600
Message-ID: <20191106202622.2648-6-bparrot@ti.com>
References: <20191106202622.2648-1-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191106202622.2648-1-bparrot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Parrot <bparrot@ti.com>
List-Id: linux-omap@vger.kernel.org

Update the compatible string to match the updated bindings.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 drivers/media/platform/ti-vpe/vpe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti-vpe/vpe.c b/drivers/media/platform/ti-vpe/vpe.c
index b54f637633a7..65c2c048b018 100644
--- a/drivers/media/platform/ti-vpe/vpe.c
+++ b/drivers/media/platform/ti-vpe/vpe.c
@@ -2644,7 +2644,7 @@ static int vpe_remove(struct platform_device *pdev)
 #if defined(CONFIG_OF)
 static const struct of_device_id vpe_of_match[] = {
 	{
-		.compatible = "ti,vpe",
+		.compatible = "ti,dra7-vpe",
 	},
 	{},
 };
-- 
2.17.1
