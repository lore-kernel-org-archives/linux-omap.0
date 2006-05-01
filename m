From: David Brownell <david-b@pacbell.net>
Subject: [PATCH 2.6.17-rc3-omap] omap_cf works better
Date: Mon, 1 May 2006 14:04:16 -0700
Message-ID: <200605011404.16645.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QfnVEV6VibR1kJB"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

--Boundary-00=_QfnVEV6VibR1kJB
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

PCMCIA core changed; this got rid of an oops, and restored some
changes from upstream that got clobbered.

There's still something way goofy going on.  The driver
mostly behaves, but under much load something will access
a bogus (and unmapped) kernel address, causing trouble.
I suspect that's in the pcmcia core, not omap_cf.



--Boundary-00=_QfnVEV6VibR1kJB
Content-Type: text/x-diff;
  charset="us-ascii";
  name="omap_cf.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="omap_cf.patch"

Adding a "struct resource" prevented oopsing because of recent changes in
PCMCIA core requirements.

Restore a changes that lost in some kernel.org merge:  don't forget to
unregister the PCMCIA socket when unbinding the driver.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: osk/drivers/pcmcia/omap_cf.c
===================================================================
--- osk.orig/drivers/pcmcia/omap_cf.c	2006-05-01 12:31:47.000000000 -0700
+++ osk/drivers/pcmcia/omap_cf.c	2006-05-01 13:37:48.000000000 -0700
@@ -67,6 +67,7 @@ struct omap_cf_socket {
 	struct platform_device	*pdev;
 	unsigned long		phys_cf;
 	u_int			irq;
+	struct resource		iomem;
 };
 
 #define	POLL_INTERVAL		(2 * HZ)
@@ -112,10 +113,7 @@ static int omap_cf_get_status(struct pcm
 	if (!sp)
 		return -EINVAL;
 
-	/* FIXME power management should probably be board-specific:
-	 *  - 3VCARD vs XVCARD (OSK only handles 3VCARD)
-	 *  - POWERON (switched on/off by set_socket)
-	 */
+	/* NOTE CF is always 3VCARD */
 	if (omap_cf_present()) {
 		struct omap_cf_socket	*cf;
 
@@ -254,6 +252,9 @@ static int __init omap_cf_probe(struct d
 	default:
 		goto  fail1;
 	}
+	cf->iomem.start = cf->phys_cf;
+	cf->iomem.end = cf->iomem.end + SZ_8K - 1;
+	cf->iomem.flags = IORESOURCE_MEM;
 
 	/* pcmcia layer only remaps "real" memory */
 	cf->socket.io_offset = (unsigned long)
@@ -297,6 +298,7 @@ static int __init omap_cf_probe(struct d
 	cf->socket.features = SS_CAP_PCCARD | SS_CAP_STATIC_MAP
 				| SS_CAP_MEM_ALIGN;
 	cf->socket.map_size = SZ_2K;
+	cf->socket.io[0].res = &cf->iomem;
 
 	status = pcmcia_register_socket(&cf->socket);
 	if (status < 0)
@@ -321,6 +323,7 @@ static int __devexit omap_cf_remove(stru
 	struct omap_cf_socket *cf = dev_get_drvdata(dev);
 
 	cf->active = 0;
+	pcmcia_unregister_socket(&cf->socket);
 	del_timer_sync(&cf->timer);
 	iounmap((void __iomem *) cf->socket.io_offset);
 	release_mem_region(cf->phys_cf, SZ_8K);
@@ -334,8 +337,8 @@ static struct device_driver omap_cf_driv
 	.bus		= &platform_bus_type,
 	.probe		= omap_cf_probe,
 	.remove		= __devexit_p(omap_cf_remove),
-	.suspend 	= pcmcia_socket_dev_suspend,
-	.resume 	= pcmcia_socket_dev_resume,
+	.suspend	= pcmcia_socket_dev_suspend,
+	.resume		= pcmcia_socket_dev_resume,
 };
 
 static int __init omap_cf_init(void)

--Boundary-00=_QfnVEV6VibR1kJB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_QfnVEV6VibR1kJB--
