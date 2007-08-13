From: Kevin Hilman <khilman@mvista.com>
Subject: Re: Pending patches, was: Git tree updated to 2.6.23-rc2
Date: Mon, 13 Aug 2007 09:59:01 -0700
Message-ID: <46C08DD5.5090001@mvista.com>
References: <20070806125225.GA2312@atomide.com> <46BCB2BD.1090905@mvista.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429019C4F78@dlee13.ent.ti.com>
	<20070813090623.GK13948@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070813090623.GK13948@atomide.com>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tony Lindgren wrote:
> * Woodruff, Richard <r-woodruff2@ti.com> [070810 13:16]:
>>> Can you undo this 1/3 nand patch?  2430 doesn't build without the other
>>> 2 patches due to some missing header (asm/arch/nand.h) that come with
>>> the later patches.
>> Kevin for compiles sake I added the missing patches instead of removing.
> 
> I reverted the 1/3 nand patch, and applied Richard's two fixes.
> I'll take a closer look at the nand patch this week, let's try to
> get things working for 2430 soon.
> 
>> There were a couple more fixes which I also added to get it booting.
>> 	- update defconfig to have vfp
>> 	- add missing TWL patch
> 
> I did not see a TWL patch in your attached patch?

Not sure if this is the same one Richard had, but this is what's needed
for a proper build of the 2430 LCD (which stil doesn't work :)

index 6e5b603..a252d82 100644
--- a/drivers/video/omap/lcd_2430sdp.c
+++ b/drivers/video/omap/lcd_2430sdp.c
@@ -32,7 +32,7 @@
 #define LCD_PANEL_BACKLIGHT_GPIO	91
 #define LCD_PANEL_ENABLE_GPIO		154
 #define LCD_PIXCLOCK_MAX		5400 /* freq 5.4 MHz */
-#define PM_RECEIVER             TWL4030_MODULE_PM_RECIEVER
+#define PM_RECEIVER             TWL4030_MODULE_PM_RECEIVER
 #define ENABLE_VAUX2_DEDICATED  0x09
 #define ENABLE_VAUX2_DEV_GRP    0x20
