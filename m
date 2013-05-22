From: Libo Chen <clbchenlibo.chen@huawei.com>
Subject: [PATCH v2] usb: omap2430: fix memleak in err case
Date: Wed, 22 May 2013 11:30:25 +0800
Message-ID: <519C3BD1.6050307@huawei.com>
References: <5192E650.3070303@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5192E650.3070303@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, gregkh@linuxfoundation.org, grant.likely@linaro.org, rob.herring@calxeda.com, Li Zefan <lizefan@huawei.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
List-Id: linux-omap@vger.kernel.org


when omap_get_control_dev faild, we should release related platform_device

* Changelog from v1:
	* fix spell: s/fail/fails/, s/relational/related/ , thank Sergei <sergei.shtylyov@cogentembedded.com>

Signed-off-by: Libo Chen <libo.chen@huawei.com>
---
 drivers/usb/musb/omap2430.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 3551f1a..b626f19 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -549,7 +549,8 @@ static int omap2430_probe(struct platform_device *pdev)
 		glue->control_otghs = omap_get_control_dev();
 		if (IS_ERR(glue->control_otghs)) {
 			dev_vdbg(&pdev->dev, "Failed to get control device\n");
-			return -ENODEV;
+			ret = -ENODEV;
+			goto err2;
 		}
 	} else {
 		glue->control_otghs = ERR_PTR(-ENODEV);
-- 
1.7.1
