From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH] omap3: ehci build-fix
Date: Thu,  1 Oct 2009 16:19:42 +0530
Message-ID: <1254394182-29025-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53925 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756216AbZJAKto (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 06:49:44 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n91Anjs7028781
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 1 Oct 2009 05:49:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anand Gadiyar <gadiyar@ti.com>

omap3: ehci build-fix

Commit b5d4fdd9 (omap: ehci: remove chargepump hack) by me
introduced a build error.

Fix this.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
Apologies for introducing this. I'm prettuy sure I build
tested on several platforms before sending it out, so I
suppose I sent out the wrong patch. :(

For what it's worth, current l-o master builds and boots
great on 3430 SDP.

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 7efc2f5..45b8a7c 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -568,7 +568,6 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 	omap->port_mode[0]		= pdata->port_mode[0];
 	omap->port_mode[1]		= pdata->port_mode[1];
 	omap->port_mode[2]		= pdata->port_mode[2];
-	omap->chargepump		= pdata->chargepump;
 	omap->ehci		= hcd_to_ehci(hcd);
 	omap->ehci->sbrn	= 0x20;
 
