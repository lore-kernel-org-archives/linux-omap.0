From: Todd Poynor <tpoynor@mvista.com>
Subject: Fix fb driver miscompile
Date: Fri, 2 Dec 2005 20:26:52 -0800
Message-ID: <20051203042652.GA25469@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Fix miscompile if CONFIG_FB_OMAP_LCDC_INTERNAL=n.

---
commit a0f7a1e5640376ffb1e4a01d601a24fb05bed5d7
tree e8e922933de12aca63353f404f35930290eb30d4
parent b20b0ffcf86bcd9d814833f11b8989586ee122e2
author Todd Poynor <tpoynor@mvista.com> Fri, 02 Dec 2005 20:24:45 -0800
committer Todd Poynor <tpoynor@mvista.com> Fri, 02 Dec 2005 20:24:45 -0800

 drivers/video/omap/omapfb_main.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index 2c4098d..8aae102 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -1249,7 +1249,9 @@ static int omapfb_probe(struct platform_
 	init_MUTEX(&fbdev->rqueue_sema);
 
 #ifdef CONFIG_ARCH_OMAP1
+#ifdef CONFIG_FB_OMAP_LCDC_INTERNAL
 	fbdev->int_ctrl = &omap1_int_ctrl;
+#endif
 #ifdef CONFIG_FB_OMAP_LCDC_EXTERNAL
 	fbdev->ext_if = &sossi_extif;
 #endif
