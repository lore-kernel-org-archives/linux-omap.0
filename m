From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v2 13/13] extcon: extcon-max77693: check if pdata exists
Date: Mon, 14 Apr 2014 13:46:24 +0200
Message-ID: <1397475984-28001-14-git-send-email-r.baldyga@samsung.com>
References: <1397475984-28001-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1397475984-28001-1-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rob@landley.net, myungjoo.ham@samsung.com, cw00.choi@samsung.com, dbaryshkov@gmail.com, dwmw2@infradead.org, balbi@ti.com, gregkh@linuxfoundation.org, grant.likely@linaro.org, ldewangan@nvidia.com, kishon@ti.com, gg@slimlogic.co.uk, anton@enomsg.org, jonghwa3.lee@samsung.com, rongjun.ying@csr.com, linux@roeck-us.net, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, aaro.koskinen@iki.fi, m.szyprowski@samsung.com, t.figa@samsung.com, Robert Baldyga <r.baldyga@samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch adds check if pdata is NULL, to avoid NULL pointer dereference
when platform data is not available. After this changes, in described
situation driver will be configured with default values.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/extcon/extcon-max77693.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77693.c
index 2cd8892..fa8534e 100644
--- a/drivers/extcon/extcon-max77693.c
+++ b/drivers/extcon/extcon-max77693.c
@@ -1210,7 +1210,7 @@ static int max77693_muic_probe(struct platform_device *pdev)
 
 
 	/* Initialize MUIC register by using platform data or default data */
-	if (pdata->muic_data) {
+	if (pdata && pdata->muic_data) {
 		init_data = pdata->muic_data->init_data;
 		num_init_data = pdata->muic_data->num_init_data;
 	} else {
-- 
1.7.9.5
