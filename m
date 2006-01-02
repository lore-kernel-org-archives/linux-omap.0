From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: Problem on mounting a jffs2 rootfs image
Date: Mon, 02 Jan 2006 21:35:46 +0100
Message-ID: <43B98EA2.9040509@de.bosch.com>
References: <43741c56.6400405c.6f4c.ffff87c0@mx.gmail.com>
	<43743DC9.1090702@de.bosch.com>
	<20051111173755.GC10822@atomide.com>
	<4374F44A.7080807@de.bosch.com> <20060102183107.GH6034@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000509090801000907070202"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060102183107.GH6034@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: 'Linux OMAP Open Source' <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------000509090801000907070202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tony Lindgren wrote:
>>0x30003361 is the value used by spectrum digital. Seems to work. But I 
>>don't think it's the fastest possible timing. Anybody with a better CS3 
>>timing?
> 
> 
> I think we should push this to avoid postings on JFFS2 problems. How
> about changing the patch to use the EMIFS_CCS macro instead?

Something like this?

Nobody with a better timing?

Dirk


--------------000509090801000907070202
Content-Type: text/plain;
 name="osk_flash_timing.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="osk_flash_timing.patch"

--- ./arch/arm/mach-omap1/board-osk.c_orig	2006-01-02 21:27:12.609851688 +0100
+++ ./arch/arm/mach-omap1/board-osk.c	2006-01-02 21:29:10.204974512 +0100
@@ -254,8 +254,18 @@ static void __init osk_mistral_init(void
 static void __init osk_mistral_init(void) { }
 #endif
 
+#define EMFIS_CS3_VAL (0x30003361)
+
 static void __init osk_init(void)
 {
+        /* Workaround for wrong CS3 (NOR flash) timing
+         * There are some U-Boot versions out there which configure
+         * wrong CS3 memory timings. This mainly leads to CRC
+         * or similiar errors if you use NOR flash (e.g. with JFFS2)
+         */
+	if(omap_readl(EMIFS_CCS(3)) != EMFIS_CS3_VAL)
+               omap_writel(EMFIS_CS3_VAL, EMIFS_CCS(3));
+ 
 	osk_flash_resource.end = osk_flash_resource.start = omap_cs3_phys();
 	osk_flash_resource.end += SZ_32M - 1;
 	platform_add_devices(osk5912_devices, ARRAY_SIZE(osk5912_devices));


--------------000509090801000907070202
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000509090801000907070202--
