From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/7] musb_hdrc: Fix doing HNP multiple times
Date: Fri, 17 Aug 2007 05:59:24 -0700
Message-ID: <20070817125923.GB16240@atomide.com>
References: <118735108469-git-send-email-tony@atomide.com>
	<11873510862981-git-send-email-tony@atomide.com>
	<11873510882998-git-send-email-tony@atomide.com>
	<11873510911954-git-send-email-tony@atomide.com>
	<11873510931624-git-send-email-tony@atomide.com>
	<11873510951742-git-send-email-tony@atomide.com>
	<11873510973002-git-send-email-tony@atomide.com>
	<11873511001036-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="U+BazGySraz5kW0T"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <11873511001036-git-send-email-tony@atomide.com>
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


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

* Tony Lindgren <tony@atomide.com> [070817 04:45]:
> Without this patch OPT HS B TD.6.15 fails if run multiple
> times in a row.

Here's a follow-up patch to this one to remove compile warning.

Tony


--U+BazGySraz5kW0T
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline;
	filename="musb-remove-unused-delay-port-power-off.patch"

musb_hdrc: Remove old unused delay_port_power_off

Remove old unused delay_port_power_off

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -450,11 +450,6 @@ struct musb {
 	struct usb_gadget_driver *gadget_driver;	/* its driver */
 #endif
 
-#ifdef CONFIG_USB_MUSB_OTG
-	/* FIXME this can't be OTG-specific ... ? */
-	u8 delay_port_power_off;
-#endif
-
 #ifdef MUSB_CONFIG_PROC_FS
 	struct proc_dir_entry *proc_entry;
 #endif
diff --git a/drivers/usb/musb/plat_uds.c b/drivers/usb/musb/plat_uds.c
index 4d02460..3e63565 100644
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -557,7 +557,6 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 int_usb,
 		if (is_peripheral_active(musb)) {
 			// REVISIT HNP; just force disconnect
 		}
-		musb->delay_port_power_off = FALSE;
 		musb_writew(mbase, MUSB_INTRTXE, musb->epmask);
 		musb_writew(mbase, MUSB_INTRRXE, musb->epmask & 0xfffe);
 		musb_writeb(mbase, MUSB_INTRUSBE, 0xf7);
diff --git a/drivers/usb/musb/virthub.c b/drivers/usb/musb/virthub.c
index 757da5e..d9f3c28 100644
--- a/drivers/usb/musb/virthub.c
+++ b/drivers/usb/musb/virthub.c
@@ -121,13 +121,6 @@ static void musb_port_reset(struct musb *musb, u8 bReset)
 		musb->port1_status &= ~USB_PORT_STAT_RESET;
 		return;
 	}
-
-	/* REVISIT this looks wrong for HNP */
-	u8 devctl = musb_readb(mbase, MUSB_DEVCTL);
-
-	if (musb->delay_port_power_off || !(devctl & MUSB_DEVCTL_HM)) {
-		return;
-	}
 #endif
 
 	if (!is_host_active(musb))

--U+BazGySraz5kW0T
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--U+BazGySraz5kW0T--
