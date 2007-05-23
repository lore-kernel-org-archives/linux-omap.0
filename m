From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: [RESUBMIT PATCH] OMAP: MUSB plat_uds.c fix
Date: Wed, 23 May 2007 11:50:18 +0530
Message-ID: <5DF83221BE20114E9C331F665ACBC0800305CB67@dbde01.ent.ti.com>
References: <5DF83221BE20114E9C331F665ACBC08002FF6AB1@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <5DF83221BE20114E9C331F665ACBC08002FF6AB1@dbde01.ent.ti.com>
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

[Resubmitting patch after line wrap removal]
Fix plat_uds.c for proper registers to be cleared for disabling
interrupts

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>

---
diff -purN -X ./dontdiff a/drivers/usb/musb/plat_uds.c
b/drivers/usb/musb/plat_uds.c
--- a/drivers/usb/musb/plat_uds.c	2007-05-21 12:57:45.000000000
+0530
+++ b/drivers/usb/musb/plat_uds.c	2007-05-23 11:37:14.000000000
+0530
@@ -494,6 +494,9 @@ static irqreturn_t musb_stage0_irq(struc
 			// REVISIT HNP; just force disconnect
 		}
 		pThis->bDelayPortPowerOff =3D FALSE;
+		musb_writew(pBase, MGC_O_HDRC_INTRTXE, pThis->wEndMask);
+		musb_writew(pBase, MGC_O_HDRC_INTRRXE, pThis->wEndMask &
0xfffe);
+		musb_writeb(pBase, MGC_O_HDRC_INTRUSBE, 0xf7);
 #endif
 		pThis->port1_status &=3D ~(USB_PORT_STAT_LOW_SPEED
 					|USB_PORT_STAT_HIGH_SPEED
@@ -741,8 +744,8 @@ static void musb_generic_disable(struct=20
=20
 	/* disable interrupts */
 	musb_writeb(pBase, MGC_O_HDRC_INTRUSBE, 0);
-	musb_writew(pBase, MGC_O_HDRC_INTRTX, 0);
-	musb_writew(pBase, MGC_O_HDRC_INTRRX, 0);
+	musb_writew(pBase, MGC_O_HDRC_INTRTXE, 0);
+	musb_writew(pBase, MGC_O_HDRC_INTRRXE, 0);
=20
 	/* off */
 	musb_writeb(pBase, MGC_O_HDRC_DEVCTL, 0);
@@ -1312,7 +1315,7 @@ static int __init musb_core_init(u16 wTy
=20
=20
/*----------------------------------------------------------------------
---*/
=20
-#ifdef CONFIG_ARCH_OMAP2430
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3430)
=20
 static irqreturn_t generic_interrupt(int irq, void *__hci)
 {
@@ -1780,6 +1783,7 @@ musb_init_controller(struct device *dev,
=20
 	/* be sure interrupts are disabled before connecting ISR */
 	musb_platform_disable(pThis);
+	musb_generic_disable(pThis);
=20
 	/* setup musb parts of the core (especially endpoints) */
 	status =3D musb_core_init(plat->multipoint
@@ -1997,7 +2001,6 @@ static struct platform_driver musb_drive
 		.bus		=3D &platform_bus_type,
 		.owner		=3D THIS_MODULE,
 	},
-	.probe		=3D musb_probe,
 	.remove		=3D __devexit_p(musb_remove),
 	.shutdown	=3D musb_shutdown,
 	.suspend	=3D musb_suspend,
