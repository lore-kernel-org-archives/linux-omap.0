From: Tony Lindgren <tony@atomide.com>
Subject: musb_hdrc: Fix compile if CONFIG_ARCH_OMAP_OTG is not set
Date: Thu, 11 Oct 2007 10:05:25 -0700
Message-ID: <11921223411763-git-send-email-tony@atomide.com>
References: <1192122325531-git-send-email-tony@atomide.com>
	<11921223262203-git-send-email-tony@atomide.com>
	<11921223272557-git-send-email-tony@atomide.com>
	<11921223283749-git-send-email-tony@atomide.com>
	<11921223301447-git-send-email-tony@atomide.com>
	<11921223311131-git-send-email-tony@atomide.com>
	<11921223321890-git-send-email-tony@atomide.com>
	<11921223331118-git-send-email-tony@atomide.com>
	<11921223352146-git-send-email-tony@atomide.com>
	<11921223372253-git-send-email-tony@atomide.com>
	<11921223381405-git-send-email-tony@atomide.com>
	<11921223392718-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11921223392718-git-send-email-tony@atomide.com>
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

Fix compile if CONFIG_ARCH_OMAP_OTG is not set

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/plat-omap/usb.c
+++ b/arch/arm/plat-omap/usb.c
@@ -76,7 +76,7 @@
 
 /*-------------------------------------------------------------------------*/
 
-#ifdef	CONFIG_ARCH_OMAP_OTG
+#if	defined(CONFIG_ARCH_OMAP_OTG) || defined(CONFIG_USB_MUSB_OTG)
 
 static struct otg_transceiver *xceiv;
 
