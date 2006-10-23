From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: RE: [patch 2.6.18-omap-git] omap2 fullspeed usb 1/2
Date: Mon, 23 Oct 2006 13:52:26 +0900
Message-ID: <001f01c6f65f$09a71a30$c7a3580a@swcenter.sec.samsung.co.kr>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7BIT
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

> [PATCH] Initial USB support on OMAP2
> 
> Initial full speed USB support on OMAP2 platform.
> Remaining issues include:
> 
>     -	only usb0 port tested (not usb1, usb2)
>     -	only peripheral/gadget controller tested (not ohci, otg)
>     -	UDC DMA is not working
>     -	clocks are not turned off
> 
> Board support is in separate patches.
> 
> Also minor omap_udc updates:  whitespace fixes, syncing with a few 
> changes from upstream, warning removal.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> -------
> NOTE:  this is just a cleaned up version of the code from Kyungmin, I 
> don't have it behaving yet on H4, and didn't re-test on e.g. OSK.

There's missing patch. We have to modify following line.

--

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig index
08c962a..4734e78 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -167,7 +167,7 @@ config USB_GADGET_MUSB_HDRC
 
 config USB_GADGET_OMAP
 	boolean "OMAP USB Device Controller"
-	depends on ARCH_OMAP1
+	depends on ARCH_OMAP
 	select ISP1301_OMAP if MACH_OMAP_H2 || MACH_OMAP_H3
 	help
 	   Many Texas Instruments OMAP processors have flexible full
