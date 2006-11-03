From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] To add OMAP 2430 Support
Date: Fri, 03 Nov 2006 20:03:52 +0100
Message-ID: <454B9298.4080009@gmail.com>
References: <77C7F7CB1230A74A9D19C0C111E6EDBE01C6AEA2@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070107090102020105010907"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <77C7F7CB1230A74A9D19C0C111E6EDBE01C6AEA2@DLEE09.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------070107090102020105010907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Syed Mohammed, Khasim wrote:
> Attached are set of patches to get OMAP 2430 "minimal" support on to the
> tree. 
> 
> With these patches I was able to boot the kernel on 2430SDP and have
> verified booting the same on 2420 H4 (just to confirm it doesn't break
> any existing 2420 functionality).
> 
> Please do let me know for any issues,

One minor thing: Attachment removes warning about defined
but unused sdp2430_init_flash. Maybe you like to add 
sdp2430_init_flash later again if its working?

Cheers

Dirk



--------------070107090102020105010907
Content-Type: text/plain;
 name="board-2430sdp_warning_fix.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="board-2430sdp_warning_fix.txt"

Index: linux-osk/arch/arm/mach-omap2/board-2430sdp.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap2/board-2430sdp.c
+++ linux-osk/arch/arm/mach-omap2/board-2430sdp.c
@@ -185,25 +185,12 @@ static inline void __init sdp2430_init_s
 
 }
 
-static void __init sdp2430_init_flash(void)
-{
-	unsigned long base;
-
-	if (gpmc_cs_request(SDP2430_FLASH_CS, SZ_64M, &base) < 0) {
-		printk("Can't request GPMC CS for flash\n");
-		return;
-	}
-	sdp2430_flash_resource.start	= base;
-	sdp2430_flash_resource.end   	= base + SZ_64M - 1;
-}
-
 static void __init omap_2430sdp_init_irq(void)
 {
 	omap2_init_common_hw();
 	omap_init_irq();
 	omap_gpio_init();
 	sdp2430_init_smc91x();
-//	2430sdp_init_flash();
 }
 
 static struct omap_uart_config sdp2430_uart_config __initdata = {


--------------070107090102020105010907
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070107090102020105010907--
