From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/2] of: address: use resource_size helper
Date: Fri, 22 Jul 2011 22:47:21 +0300
Message-ID: <1311364042-8325-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, Felipe Balbi <balbi@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

that should be the approved way of calculating
the size of resources. No functional changes.

Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/of/address.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index deefc0c..6e7b2cf 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -624,6 +624,6 @@ void __iomem *of_iomap(struct device_node *np, int index)
 	if (of_address_to_resource(np, index, &res))
 		return NULL;
 
-	return ioremap(res.start, 1 + res.end - res.start);
+	return ioremap(res.start, resource_size(&res));
 }
 EXPORT_SYMBOL(of_iomap);
-- 
1.7.6
