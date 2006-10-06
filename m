From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Can't Boot - OSK Frame Buffer Support in Kernel 2.6.18-omap1
Date: Fri, 06 Oct 2006 21:30:56 +0200
Message-ID: <4526AEF0.4000005@gmail.com>
References: <CC7B089C59ED6841BAE28F1EA69A8543873730@EXCHDB.admin.wpi.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090504080903060306050607"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <CC7B089C59ED6841BAE28F1EA69A8543873730@EXCHDB.admin.wpi.edu>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Sideleau, Scott R" <srs@WPI.EDU>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------090504080903060306050607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sideleau, Scott R wrote:
> ## Booting image at 00100000 ...
>    Image Name:   OE
>    Image Type:   ARM Linux Kernel Image (gzip compressed)
>    Data Size:    1065210 Bytes =  1 MB
>    Load Address: 10c08000
>    Entry Point:  10c08000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK

I wonder about the adresses used here. Do you followed

http://oskfordummies.hp.infoseek.co.jp/howto/flash_kernel.html

?

I would assume kernel at 0x40000 and start address/entry
point at 0x10008000. E.g.:

## Checking image at 00040000 ...
      Image Name:   Linux-2.6.11-omap1
      Image Type:   ARM Linux Kernel Image (umcompressed)
      Data Size:    1159328 Bytes = 1.1 MB
      Load Address: 10008000
      Entry Point:  10008000
      Veryfying Checksum ... OK

> Any ideas?  Any and all help/direction is appreciated.

For debugging, enable

Kernel hacking -> Kernel debugging -> Kernel low-level
debugging functions

(and temporarily apply patch in attachment, seems to be
necessary to work low level debugging properly).

Dirk



--------------090504080903060306050607
Content-Type: text/plain;
 name="temp_low_level_debug_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="temp_low_level_debug_patch.txt"

--- ./arch/arm/plat-omap/clock.c_orig	2006-10-06 21:16:49.000000000 +0200
+++ ./arch/arm/plat-omap/clock.c	2006-10-06 21:17:03.000000000 +0200
@@ -135,7 +135,7 @@ void clk_disable(struct clk *clk)
 		return;
 
 	spin_lock_irqsave(&clockfw_lock, flags);
-	BUG_ON(clk->usecount == 0);
+	//BUG_ON(clk->usecount == 0);
 	if (arch_clock->clk_disable)
 		arch_clock->clk_disable(clk);
 	spin_unlock_irqrestore(&clockfw_lock, flags);
--- ./arch/arm/mach-omap1/clock.c_orig	2006-10-06 21:18:57.000000000 +0200
+++ ./arch/arm/mach-omap1/clock.c	2006-10-06 21:16:21.000000000 +0200
@@ -651,7 +651,7 @@ int __init omap1_clk_init(void)
 
 	/* USB_REQ_EN will be disabled later if necessary (usb_dc_ck) */
 	reg = omap_readw(SOFT_REQ_REG) & (1 << 4);
-	omap_writew(reg, SOFT_REQ_REG);
+	//omap_writew(reg, SOFT_REQ_REG);
 	if (!cpu_is_omap15xx())
 		omap_writew(0, SOFT_REQ_REG2);
 



--------------090504080903060306050607
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090504080903060306050607--
