From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 11/20] OMAP: omap_device: ensure hwmod tracks attached
	omap_device pointer
Date: Fri, 02 Jul 2010 09:29:30 -0600
Message-ID: <20100702152927.6221.90018.stgit@localhost.localdomain>
References: <20100702152703.6221.33529.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100702152703.6221.33529.stgit@localhost.localdomain>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>
List-Id: linux-omap@vger.kernel.org

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
