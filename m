From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 1/3] video: omapdss: delete unneeded of_node_put
Date: Mon, 12 Oct 2015 22:43:14 +0200
Message-ID: <1444682596-3065-2-git-send-email-Julia.Lawall@lip6.fr>
References: <1444682596-3065-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444682596-3065-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: kernel-janitors@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Bjorn Helgaas <bhelgaas@google.com>, Jason Cooper <jason@lakedaemon.net>
List-Id: linux-omap@vger.kernel.org

Device node iterators perform an of_node_put on each iteration, so putting
an of_node_put before a continue results in a double put.

A simplified version of the semantic match that finds this problem is as
follows (http://coccinelle.lip6.fr):

// <smpl>
@@
expression root,e;
local idexpression child;
iterator i;
@@

 i(..., child, ...) {
   ... when != of_node_get(child)
*  of_node_put(child);
   ...
*  continue;
}
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/video/fbdev/omap2/dss/omapdss-boot-init.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/omapdss-boot-init.c b/drivers/video/fbdev/omap2/dss/omapdss-boot-init.c
index 8b6f6d5..136d304 100644
--- a/drivers/video/fbdev/omap2/dss/omapdss-boot-init.c
+++ b/drivers/video/fbdev/omap2/dss/omapdss-boot-init.c
@@ -199,10 +199,8 @@ static int __init omapdss_boot_init(void)
 	omapdss_walk_device(dss, true);
 
 	for_each_available_child_of_node(dss, child) {
-		if (!of_find_property(child, "compatible", NULL)) {
-			of_node_put(child);
+		if (!of_find_property(child, "compatible", NULL))
 			continue;
-		}
 
 		omapdss_walk_device(child, true);
 	}
