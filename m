From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 09/13] OMAP: omap_device: ensure hwmod tracks attached
 omap_device pointer
Date: Fri, 2 Jul 2010 05:40:24 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1007020539080.13691@utopia.booyaka.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com> <1277336563-24988-10-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36637 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756584Ab0GBLkY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 07:40:24 -0400
In-Reply-To: <1277336563-24988-10-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Wed, 23 Jun 2010, Kevin Hilman wrote:

> The omap_hwmod struct has a field to track the omap_device that is
> attached to it, but it was not being assigned.  Fix by assigning omap_device
> pointer when omap_device is built.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

This patch has been modified to use array indexing rather than pointer 
arithmetic; I think it is easier to read and debug; revised patch below.


- Paul

OMAP: omap_device: ensure hwmod tracks attached omap_device pointer

From: Kevin Hilman <khilman@deeprootsystems.com>

The omap_hwmod struct has a field to track the omap_device that is
attached to it, but it was not being assigned.  Fix by assigning omap_device
pointer when omap_device is built.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
[paul@pwsan.com: use an array index rather than pointer arithmetic]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/omap_device.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index f899603..f9dec0d 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -359,7 +359,7 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	struct omap_device *od;
 	char *pdev_name2;
 	struct resource *res = NULL;
-	int res_count;
+	int i, res_count;
 	struct omap_hwmod **hwmods;
 
 	if (!ohs || oh_cnt == 0 || !pdev_name)
@@ -416,6 +416,9 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	else
 		ret = omap_device_register(od);
 
+	for (i = 0; i < oh_cnt; i++)
+		hwmods[i]->od = od;
+
 	if (ret)
 		goto odbs_exit4;
 
