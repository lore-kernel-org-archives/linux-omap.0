From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: RE: [PATCH] 24xx NAND - Please Test
Date: Wed, 11 Jan 2006 08:40:36 +0900
Message-ID: <0ISW00H3OHRNMX@mmp1.samsung.com>
References: <20060110111203.26135.qmail@web32907.mail.mud.yahoo.com>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <20060110111203.26135.qmail@web32907.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Komal Shah' <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi 

> As you have already worked on h4 x-loader, I had cooked up NAND patch
> for H4, but was not able to test it on EVM, as I got stuck in x-loader
> and u-boot flashing itself.

No I just test OneNAND not NAND on xloader and I also don't have NAND device
on omap24xx.

I don't know we have a plan to make a NAND test board on omap24xx. I will
ask the hardware team. 

> 
> You may want to test it and submit it to linux-omap list, as 
> I will not
> able to work on this anymore. Thanx.
> 
> 

MTD: H4 NAND support.
Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>


diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 19b498d..3b16517 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c

+
+static struct resource h4_nand_resource = {
+	.start		= H4_CS0_BASE,
+	.end		= H4_CS0_BASE + SZ_64M - 1,
+	.flags		= IORESOURCE_MEM,
+};

I don't know CS0 is corret address on H4?
If some H4 board don't have NAND device, Is it working?

+#if defined(CONFIG_MTD_OMAP_NOR) || defined(CONFIG_MTD_OMAP_NOR_MODULE)
+	GPMC_CONFIG1_0	= 0x00060000;	/* rw wait0 pin monitoring */
+	GPMC_CONFIG	= 0x00000010;	/* write protect off */
+#endif

Is it right?

GPMC_CONFIG1_0	|= 0x00060000;	/* rw wait0 pin monitoring */
GPMC_CONFIG		|= 0x00000010;	/* write protect off */

Is it more reasonable?

Regards,
Kyungmin Park
