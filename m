From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v2 12/13] extcon: extcon-max8997: check if pdata exists
Date: Mon, 14 Apr 2014 13:46:23 +0200
Message-ID: <1397475984-28001-13-git-send-email-r.baldyga@samsung.com>
References: <1397475984-28001-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:49939 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682AbaDNLty (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Apr 2014 07:49:54 -0400
In-reply-to: <1397475984-28001-1-git-send-email-r.baldyga@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rob@landley.net, myungjoo.ham@samsung.com, cw00.choi@samsung.com, dbaryshkov@gmail.com, dwmw2@infradead.org, balbi@ti.com, gregkh@linuxfoundation.org, grant.likely@linaro.org, ldewangan@nvidia.com, kishon@ti.com, gg@slimlogic.co.uk, anton@enomsg.org, jonghwa3.lee@samsung.com, rongjun.ying@csr.com, linux@roeck-us.net, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, aaro.koskinen@iki.fi, m.szyprowski@samsung.com, t.figa@samsung.com, Robert Baldyga <r.baldyga@samsung.com>

This patch adds check if pdata is NULL, to avoid NULL pointer dereference
when platform data is not available. After this changes, in described
situation driver will be configured with default values.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/extcon/extcon-max8997.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
index c071588..d7d12e9 100644
--- a/drivers/extcon/extcon-max8997.c
+++ b/drivers/extcon/extcon-max8997.c
@@ -726,7 +726,7 @@ static int max8997_muic_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
-	if (pdata->muic_pdata) {
+	if (pdata && pdata->muic_pdata) {
 		struct max8997_muic_platform_data *muic_pdata
 			= pdata->muic_pdata;
 
-- 
1.7.9.5

