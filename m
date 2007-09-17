From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] OMAP: Adding Support for 2K nand page support for
	omap2430
Date: Mon, 17 Sep 2007 12:21:19 -0700
Message-ID: <20070917191652.GC5614@atomide.com>
References: <809D758398CC1F49AA8E493528AD4A27014DF6AE@ntxsjombx02.micron.com>
	<20070810104326.GX8658@atomide.com>
	<809D758398CC1F49AA8E493528AD4A27014DF6C1@ntxsjombx02.micron.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <809D758398CC1F49AA8E493528AD4A27014DF6C1@ntxsjombx02.micron.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: sshahrom@micron.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* sshahrom@micron.com <sshahrom@micron.com> [070827 09:34]:
> Hi;
> Sorry, I just got back from vacation. The difference between omap-nand-flash.c and omap2.c was so much that I thought modify omap-nand-flash.c file would cause more confusion. But I am open to any suggestion.

Can you please fix the following things so we can apply this:

- Please noCamelCase in linux code
- Some of the code should/could use gpmc.c code
- CodingStyle, see following output from scripts/checkpatch.pl

Mostly stuff that would be a showstopper merging it upstream in
MTD list anyways. You might want to run checkpatch.pl on all
your patches!

Regards,

Tony

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="checkpatch.pl-errors"

ERROR: trailing whitespace
#21: FILE: drivers/mtd/nand/omap2.c:5:
+ * Copyright (c) 2004 Micron Technology Inc. $

CHECK: Use #include <linux/io.h> instead of <asm/io.h>
#40: FILE: drivers/mtd/nand/omap2.c:24:
+#include <asm/io.h>

CHECK: Use #include <linux/io.h> instead of <asm/io.h>
#47: FILE: drivers/mtd/nand/omap2.c:31:
+#include <asm/io.h>

ERROR: need space after that ',' (ctx:VxV)
#77: FILE: drivers/mtd/nand/omap2.c:61:
+	.eccpos = {2,3,4,5,6,7,8,9,10,11,12,13},
                    ^

ERROR: need space after that ',' (ctx:VxV)
#77: FILE: drivers/mtd/nand/omap2.c:61:
+	.eccpos = {2,3,4,5,6,7,8,9,10,11,12,13},
                      ^

ERROR: need space after that ',' (ctx:VxV)
#77: FILE: drivers/mtd/nand/omap2.c:61:
+	.eccpos = {2,3,4,5,6,7,8,9,10,11,12,13},
                        ^

ERROR: need space after that ',' (ctx:VxV)
#77: FILE: drivers/mtd/nand/omap2.c:61:
+	.eccpos = {2,3,4,5,6,7,8,9,10,11,12,13},
                          ^

ERROR: need space after that ',' (ctx:VxV)
#77: FILE: drivers/mtd/nand/omap2.c:61:
+	.eccpos = {2,3,4,5,6,7,8,9,10,11,12,13},
                            ^

ERROR: need space after that ',' (ctx:VxV)
#77: FILE: drivers/mtd/nand/omap2.c:61:
+	.eccpos = {2,3,4,5,6,7,8,9,10,11,12,13},
                              ^

ERROR: need space after that ',' (ctx:VxV)
#77: FILE: drivers/mtd/nand/omap2.c:61:
+	.eccpos = {2,3,4,5,6,7,8,9,10,11,12,13},
                                ^

ERROR: need space after that ',' (ctx:VxV)
#77: FILE: drivers/mtd/nand/omap2.c:61:
+	.eccpos = {2,3,4,5,6,7,8,9,10,11,12,13},
                                  ^

ERROR: need space after that ',' (ctx:VxV)
#77: FILE: drivers/mtd/nand/omap2.c:61:
+	.eccpos = {2,3,4,5,6,7,8,9,10,11,12,13},
                                     ^

ERROR: need space after that ',' (ctx:VxV)
#77: FILE: drivers/mtd/nand/omap2.c:61:
+	.eccpos = {2,3,4,5,6,7,8,9,10,11,12,13},
                                        ^

ERROR: need space after that ',' (ctx:VxV)
#77: FILE: drivers/mtd/nand/omap2.c:61:
+	.eccpos = {2,3,4,5,6,7,8,9,10,11,12,13},
                                           ^

WARNING: line over 80 characters
#96: FILE: drivers/mtd/nand/omap2.c:80:
+	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info, mtd);

WARNING: line over 80 characters
#120: FILE: drivers/mtd/nand/omap2.c:104:
+	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info, mtd);

ERROR: switch and case should be at the same indent
#122: FILE: drivers/mtd/nand/omap2.c:106:
+	switch (ctrl) {

+		case NAND_CTRL_CHANGE | NAND_CTRL_CLE:
[...]
+		case NAND_CTRL_CHANGE | NAND_CTRL_ALE:
[...]
+		case NAND_CTRL_CHANGE | NAND_NCE:


WARNING: line over 80 characters
#124: FILE: drivers/mtd/nand/omap2.c:108:
+			info->nand.IO_ADDR_W = info->gpmcCsBaseAddr + GPMC_CS_NAND_COMMAND;

WARNING: line over 80 characters
#125: FILE: drivers/mtd/nand/omap2.c:109:
+			info->nand.IO_ADDR_R = info->gpmcCsBaseAddr + GPMC_CS_NAND_DATA;

ERROR: trailing whitespace
#127: FILE: drivers/mtd/nand/omap2.c:111:
+^I	$

WARNING: line over 80 characters
#129: FILE: drivers/mtd/nand/omap2.c:113:
+			info->nand.IO_ADDR_W = info->gpmcCsBaseAddr + GPMC_CS_NAND_ADDRESS;

WARNING: line over 80 characters
#130: FILE: drivers/mtd/nand/omap2.c:114:
+			info->nand.IO_ADDR_R = info->gpmcCsBaseAddr + GPMC_CS_NAND_DATA;

WARNING: line over 80 characters
#134: FILE: drivers/mtd/nand/omap2.c:118:
+			info->nand.IO_ADDR_W = info->gpmcCsBaseAddr + GPMC_CS_NAND_DATA;

WARNING: line over 80 characters
#135: FILE: drivers/mtd/nand/omap2.c:119:
+			info->nand.IO_ADDR_R = info->gpmcCsBaseAddr + GPMC_CS_NAND_DATA;

ERROR: no space after that open parenthesis '('
#140: FILE: drivers/mtd/nand/omap2.c:124:
+		__raw_writeb( cmd, info->nand.IO_ADDR_W );

ERROR: no space before that close parenthesis ')'
#140: FILE: drivers/mtd/nand/omap2.c:124:
+		__raw_writeb( cmd, info->nand.IO_ADDR_W );

WARNING: line over 80 characters
#152: FILE: drivers/mtd/nand/omap2.c:136:
+	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info, mtd);

WARNING: line over 80 characters
#171: FILE: drivers/mtd/nand/omap2.c:155:
+	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info, mtd);

WARNING: line over 80 characters
#179: FILE: drivers/mtd/nand/omap2.c:163:
+		while (GPMC_BUF_EMPTY==(readl(info->gpmcBaseAddr+GPMC_STATUS)&GPMC_BUF_FULL)) ;

ERROR: need spaces around that '==' (ctx:VxV)
#179: FILE: drivers/mtd/nand/omap2.c:163:
+		while (GPMC_BUF_EMPTY==(readl(info->gpmcBaseAddr+GPMC_STATUS)&GPMC_BUF_FULL)) ;
                                     ^

WARNING: line over 80 characters
#190: FILE: drivers/mtd/nand/omap2.c:174:
+	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info, mtd);

WARNING: line over 80 characters
#206: FILE: drivers/mtd/nand/omap2.c:190:
+	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info, mtd);

ERROR: no space after that open parenthesis '('
#212: FILE: drivers/mtd/nand/omap2.c:196:
+	val = ( (0x00000001<<8) | 0x00000001 );

ERROR: no space before that close parenthesis ')'
#212: FILE: drivers/mtd/nand/omap2.c:196:
+	val = ( (0x00000001<<8) | 0x00000001 );

ERROR: need space after that ',' (ctx:VxV)
#213: FILE: drivers/mtd/nand/omap2.c:197:
+	__raw_writel(val,info->gpmcBaseAddr+GPMC_ECC_CONTROL);
                        ^

WARNING: line over 80 characters
#217: FILE: drivers/mtd/nand/omap2.c:201:
+	/*       ECCSIZE1=512   |  ECCSIZE0=8bytes | Select eccResultsize[0123] */

ERROR: need space after that ',' (ctx:VxV)
#219: FILE: drivers/mtd/nand/omap2.c:203:
+	__raw_writel(val,info->gpmcBaseAddr+GPMC_ECC_SIZE_CONFIG);
                        ^

ERROR: trailing whitespace
#230: FILE: drivers/mtd/nand/omap2.c:214:
+^Iu32 tmp = ecc_buf[0] | (ecc_buf[1] << 16) | $

ERROR: trailing whitespace
#233: FILE: drivers/mtd/nand/omap2.c:217:
+^Iecc_buf[0] = ~(P64o(tmp) | P64e(tmp) | P32o(tmp) | P32e(tmp) | $

ERROR: no space before that close parenthesis ')'
#234: FILE: drivers/mtd/nand/omap2.c:218:
+		       P16o(tmp) | P16e(tmp) | P8o(tmp) | P8e(tmp) );

ERROR: trailing whitespace
#235: FILE: drivers/mtd/nand/omap2.c:219:
+^Iecc_buf[1] = ~(P1024o(tmp) | P1024e(tmp) | P512o(tmp) | P512e(tmp) | $

ERROR: no space after that open parenthesis '('
#237: FILE: drivers/mtd/nand/omap2.c:221:
+	ecc_buf[2] = ~( P4o(tmp) | P4e(tmp) | P2o(tmp) | P2e(tmp) | P1o(tmp) |

ERROR: use tabs not spaces
#238: FILE: drivers/mtd/nand/omap2.c:222:
+^I	       	P1e(tmp) | P2048o(tmp) | P2048e(tmp));$

ERROR: use tabs not spaces
#276: FILE: drivers/mtd/nand/omap2.c:260:
+        }$

ERROR: need spaces around that '<' (ctx:VxW)
#298: FILE: drivers/mtd/nand/omap2.c:282:
+	for (i = 0; i< 6; i++ )
                     ^

ERROR: no space before that close parenthesis ')'
#298: FILE: drivers/mtd/nand/omap2.c:282:
+	for (i = 0; i< 6; i++ )

WARNING: no space between function name and open parenthesis '('
#321: FILE: drivers/mtd/nand/omap2.c:305:
+		DEBUG (MTD_DEBUG_LEVEL0, "ECC UNCORRECTED_ERROR 1\n");

WARNING: no space between function name and open parenthesis '('
#326: FILE: drivers/mtd/nand/omap2.c:310:
+		DEBUG (MTD_DEBUG_LEVEL0, "ECC UNCORRECTED_ERROR B\n");

ERROR: trailing whitespace
#331: FILE: drivers/mtd/nand/omap2.c:315:
+^I	find_byte = (ecc_bit[23] << 8) + $

ERROR: trailing whitespace
#332: FILE: drivers/mtd/nand/omap2.c:316:
+^I		    (ecc_bit[21] << 7) + $

WARNING: line over 80 characters
#343: FILE: drivers/mtd/nand/omap2.c:327:
+		DEBUG (MTD_DEBUG_LEVEL0, "Correcting single bit ECC error at offset: %d, bit: %d\n", find_byte, find_bit);

WARNING: no space between function name and open parenthesis '('
#343: FILE: drivers/mtd/nand/omap2.c:327:
+		DEBUG (MTD_DEBUG_LEVEL0, "Correcting single bit ECC error at offset: %d, bit: %d\n", find_byte, find_bit);

WARNING: line over 80 characters
#350: FILE: drivers/mtd/nand/omap2.c:334:
+			if (ecc_data2[0] == 0 && ecc_data2[1] == 0 && ecc_data2[2] == 0)

ERROR: trailing whitespace
#352: FILE: drivers/mtd/nand/omap2.c:336:
+^I	} $

WARNING: no space between function name and open parenthesis '('
#353: FILE: drivers/mtd/nand/omap2.c:337:
+		DEBUG (MTD_DEBUG_LEVEL0, "UNCORRECTED_ERROR default\n");

WARNING: line over 80 characters
#358: FILE: drivers/mtd/nand/omap2.c:342:
+static int omap_correct_data(struct mtd_info *mtd,u_char * dat,u_char * read_ecc,u_char * calc_ecc)

ERROR: need space after that ',' (ctx:VxV)
#358: FILE: drivers/mtd/nand/omap2.c:342:
+static int omap_correct_data(struct mtd_info *mtd,u_char * dat,u_char * read_ecc,u_char * calc_ecc)
                                                  ^

ERROR: need space after that ',' (ctx:VxV)
#358: FILE: drivers/mtd/nand/omap2.c:342:
+static int omap_correct_data(struct mtd_info *mtd,u_char * dat,u_char * read_ecc,u_char * calc_ecc)
                                                               ^

ERROR: need space after that ',' (ctx:VxV)
#358: FILE: drivers/mtd/nand/omap2.c:342:
+static int omap_correct_data(struct mtd_info *mtd,u_char * dat,u_char * read_ecc,u_char * calc_ecc)
                                                                                 ^

WARNING: line over 80 characters
#360: FILE: drivers/mtd/nand/omap2.c:344:
+	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info, mtd);

WARNING: line over 80 characters
#364: FILE: drivers/mtd/nand/omap2.c:348:
+	if ((info->nand.ecc.mode == NAND_ECC_HW) && (info->nand.ecc.size  == 2048))

ERROR: trailing whitespace
#366: FILE: drivers/mtd/nand/omap2.c:350:
+^Ielse    $

WARNING: line over 80 characters
#392: FILE: drivers/mtd/nand/omap2.c:376:
+static int omap_calculate_ecc(struct mtd_info *mtd, const u_char *dat, u_char *ecc_code)

WARNING: line over 80 characters
#394: FILE: drivers/mtd/nand/omap2.c:378:
+	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info, mtd);

WARNING: line over 80 characters
#399: FILE: drivers/mtd/nand/omap2.c:383:
+	if ((info->nand.ecc.mode == NAND_ECC_HW) && (info->nand.ecc.size  == 2048))

ERROR: trailing whitespace
#401: FILE: drivers/mtd/nand/omap2.c:385:
+^Ielse    $

ERROR: trailing whitespace
#405: FILE: drivers/mtd/nand/omap2.c:389:
+^Ireg = (unsigned long)(info->gpmcBaseAddr + GPMC_ECC1_RESULT);  $

ERROR: trailing whitespace
#414: FILE: drivers/mtd/nand/omap2.c:398:
+^I$

ERROR: trailing whitespace
#416: FILE: drivers/mtd/nand/omap2.c:400:
+^I$

WARNING: line over 80 characters
#421: FILE: drivers/mtd/nand/omap2.c:405:
+	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info, mtd);

ERROR: switch and case should be at the same indent
#424: FILE: drivers/mtd/nand/omap2.c:408:
+	switch (mode) {

+		case NAND_ECC_READ    :
[...]
+		case NAND_ECC_READSYN :
[...]
+		case NAND_ECC_WRITE   :
[...]
+		default:


ERROR: need space after that ',' (ctx:VxV)
#426: FILE: drivers/mtd/nand/omap2.c:410:
+			__raw_writel(0x101,info->gpmcBaseAddr+GPMC_ECC_CONTROL);
                                          ^

ERROR: need space after that ',' (ctx:VxV)
#431: FILE: drivers/mtd/nand/omap2.c:415:
+			__raw_writel(0x100,info->gpmcBaseAddr+GPMC_ECC_CONTROL);
                                          ^

ERROR: need space after that ',' (ctx:VxV)
#436: FILE: drivers/mtd/nand/omap2.c:420:
+			__raw_writel(0x101,info->gpmcBaseAddr+GPMC_ECC_CONTROL);
                                          ^

WARNING: line over 80 characters
#441: FILE: drivers/mtd/nand/omap2.c:425:
+			DEBUG (MTD_DEBUG_LEVEL0, "Error: Unrecognized Mode[%d]!\n",mode);

WARNING: no space between function name and open parenthesis '('
#441: FILE: drivers/mtd/nand/omap2.c:425:
+			DEBUG (MTD_DEBUG_LEVEL0, "Error: Unrecognized Mode[%d]!\n",mode);

ERROR: need space after that ',' (ctx:VxV)
#441: FILE: drivers/mtd/nand/omap2.c:425:
+			DEBUG (MTD_DEBUG_LEVEL0, "Error: Unrecognized Mode[%d]!\n",mode);
                                                                                  ^

ERROR: need space after that ',' (ctx:VxV)
#446: FILE: drivers/mtd/nand/omap2.c:430:
+	__raw_writel(val,info->gpmcBaseAddr+GPMC_ECC_CONFIG);
                        ^

WARNING: line over 80 characters
#452: FILE: drivers/mtd/nand/omap2.c:436:
+	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info, mtd);

ERROR: need space after that ',' (ctx:VxV)
#460: FILE: drivers/mtd/nand/omap2.c:444:
+		__raw_writel(val,info->gpmcBaseAddr+GPMC_IRQ_STATUS);
                                ^

ERROR: need a space before the open brace '{'
#463: FILE: drivers/mtd/nand/omap2.c:447:
+		while (cnt++ < 0x1FF){

ERROR: no space after that open parenthesis '('
#487: FILE: drivers/mtd/nand/omap2.c:471:
+	info = kzalloc( sizeof(struct omap_nand_info), GFP_KERNEL);

ERROR: trailing whitespace
#496: FILE: drivers/mtd/nand/omap2.c:480:
+^I$

ERROR: need space after that ',' (ctx:VxV)
#512: FILE: drivers/mtd/nand/omap2.c:496:
+	val  = gpmc_cs_read_reg(info->gpmc_cs,GPMC_CS_CONFIG1);
                                             ^

ERROR: need space after that ',' (ctx:VxV)
#516: FILE: drivers/mtd/nand/omap2.c:500:
+	val  = gpmc_cs_read_reg(info->gpmc_cs,GPMC_CS_CONFIG7);
                                             ^

ERROR: trailing whitespace
#517: FILE: drivers/mtd/nand/omap2.c:501:
+^Ival &= ~(0xf << 8); $

WARNING: line over 80 characters
#521: FILE: drivers/mtd/nand/omap2.c:505:
+	if (!request_mem_region(info->physBase, NAND_IO_SIZE, pdev->dev.driver->name)) {

ERROR: trailing whitespace
#535: FILE: drivers/mtd/nand/omap2.c:519:
+^I$

ERROR: trailing whitespace
#539: FILE: drivers/mtd/nand/omap2.c:523:
+^I$

ERROR: need space after that ',' (ctx:VxV)
#585: FILE: drivers/mtd/nand/omap2.c:569:
+	omap_nandWP(&info->mtd,NAND_WP_OFF);
                              ^

ERROR: need space after that ',' (ctx:VxV)
#626: FILE: drivers/mtd/nand/omap2.c:610:
+	printk(KERN_INFO "%s driver initializing\n",DRIVER_NAME);
                                                   ^

ERROR: no space before that close parenthesis ')'
#700: FILE: include/asm-arm/arch-omap/nand.h:53:
+#define P2048e(a)	(TF(a & NAND_Ecc_P2048e)	<< 0 )

ERROR: no space before that close parenthesis ')'
#701: FILE: include/asm-arm/arch-omap/nand.h:54:
+#define P2048o(a)	(TF(a & NAND_Ecc_P2048o)	<< 1 )

ERROR: no space before that close parenthesis ')'
#702: FILE: include/asm-arm/arch-omap/nand.h:55:
+#define P1e(a)		(TF(a & NAND_Ecc_P1e)		<< 2 )

ERROR: no space before that close parenthesis ')'
#703: FILE: include/asm-arm/arch-omap/nand.h:56:
+#define P1o(a)		(TF(a & NAND_Ecc_P1o)		<< 3 )

ERROR: no space before that close parenthesis ')'
#704: FILE: include/asm-arm/arch-omap/nand.h:57:
+#define P2e(a)		(TF(a & NAND_Ecc_P2e)		<< 4 )

ERROR: no space before that close parenthesis ')'
#705: FILE: include/asm-arm/arch-omap/nand.h:58:
+#define P2o(a)		(TF(a & NAND_Ecc_P2o)		<< 5 )

ERROR: no space before that close parenthesis ')'
#706: FILE: include/asm-arm/arch-omap/nand.h:59:
+#define P4e(a)		(TF(a & NAND_Ecc_P4e)		<< 6 )

ERROR: no space before that close parenthesis ')'
#707: FILE: include/asm-arm/arch-omap/nand.h:60:
+#define P4o(a)		(TF(a & NAND_Ecc_P4o)		<< 7 )

ERROR: no space before that close parenthesis ')'
#709: FILE: include/asm-arm/arch-omap/nand.h:62:
+#define P8e(a)		(TF(a & NAND_Ecc_P8e)		<< 0 )

ERROR: no space before that close parenthesis ')'
#710: FILE: include/asm-arm/arch-omap/nand.h:63:
+#define P8o(a)		(TF(a & NAND_Ecc_P8o)		<< 1 )

ERROR: no space before that close parenthesis ')'
#711: FILE: include/asm-arm/arch-omap/nand.h:64:
+#define P16e(a)		(TF(a & NAND_Ecc_P16e)		<< 2 )

ERROR: no space before that close parenthesis ')'
#712: FILE: include/asm-arm/arch-omap/nand.h:65:
+#define P16o(a)		(TF(a & NAND_Ecc_P16o)		<< 3 )

ERROR: no space before that close parenthesis ')'
#713: FILE: include/asm-arm/arch-omap/nand.h:66:
+#define P32e(a)		(TF(a & NAND_Ecc_P32e)		<< 4 )

ERROR: no space before that close parenthesis ')'
#714: FILE: include/asm-arm/arch-omap/nand.h:67:
+#define P32o(a)		(TF(a & NAND_Ecc_P32o)		<< 5 )

ERROR: no space before that close parenthesis ')'
#715: FILE: include/asm-arm/arch-omap/nand.h:68:
+#define P64e(a)		(TF(a & NAND_Ecc_P64e)		<< 6 )

ERROR: no space before that close parenthesis ')'
#716: FILE: include/asm-arm/arch-omap/nand.h:69:
+#define P64o(a)		(TF(a & NAND_Ecc_P64o)		<< 7 )

ERROR: no space before that close parenthesis ')'
#718: FILE: include/asm-arm/arch-omap/nand.h:71:
+#define P128e(a)	(TF(a & NAND_Ecc_P128e)		<< 0 )

ERROR: no space before that close parenthesis ')'
#719: FILE: include/asm-arm/arch-omap/nand.h:72:
+#define P128o(a)	(TF(a & NAND_Ecc_P128o)		<< 1 )

ERROR: no space before that close parenthesis ')'
#720: FILE: include/asm-arm/arch-omap/nand.h:73:
+#define P256e(a)	(TF(a & NAND_Ecc_P256e)		<< 2 )

ERROR: no space before that close parenthesis ')'
#721: FILE: include/asm-arm/arch-omap/nand.h:74:
+#define P256o(a)	(TF(a & NAND_Ecc_P256o)		<< 3 )

ERROR: no space before that close parenthesis ')'
#722: FILE: include/asm-arm/arch-omap/nand.h:75:
+#define P512e(a)	(TF(a & NAND_Ecc_P512e)		<< 4 )

ERROR: no space before that close parenthesis ')'
#723: FILE: include/asm-arm/arch-omap/nand.h:76:
+#define P512o(a)	(TF(a & NAND_Ecc_P512o)		<< 5 )

ERROR: no space before that close parenthesis ')'
#724: FILE: include/asm-arm/arch-omap/nand.h:77:
+#define P1024e(a)	(TF(a & NAND_Ecc_P1024e)	<< 6 )

ERROR: no space before that close parenthesis ')'
#725: FILE: include/asm-arm/arch-omap/nand.h:78:
+#define P1024o(a)	(TF(a & NAND_Ecc_P1024o)	<< 7 )

ERROR: no space before that close parenthesis ')'
#727: FILE: include/asm-arm/arch-omap/nand.h:80:
+#define P8e_s(a)	(TF(a & NAND_Ecc_P8e)		<< 0 )

ERROR: no space before that close parenthesis ')'
#728: FILE: include/asm-arm/arch-omap/nand.h:81:
+#define P8o_s(a)	(TF(a & NAND_Ecc_P8o)		<< 1 )

ERROR: no space before that close parenthesis ')'
#729: FILE: include/asm-arm/arch-omap/nand.h:82:
+#define P16e_s(a)	(TF(a & NAND_Ecc_P16e)		<< 2 )

ERROR: no space before that close parenthesis ')'
#730: FILE: include/asm-arm/arch-omap/nand.h:83:
+#define P16o_s(a)	(TF(a & NAND_Ecc_P16o)		<< 3 )

ERROR: no space before that close parenthesis ')'
#731: FILE: include/asm-arm/arch-omap/nand.h:84:
+#define P1e_s(a)	(TF(a & NAND_Ecc_P1e)		<< 4 )

ERROR: no space before that close parenthesis ')'
#732: FILE: include/asm-arm/arch-omap/nand.h:85:
+#define P1o_s(a)	(TF(a & NAND_Ecc_P1o)		<< 5 )

ERROR: no space before that close parenthesis ')'
#733: FILE: include/asm-arm/arch-omap/nand.h:86:
+#define P2e_s(a)	(TF(a & NAND_Ecc_P2e)		<< 6 )

ERROR: no space before that close parenthesis ')'
#734: FILE: include/asm-arm/arch-omap/nand.h:87:
+#define P2o_s(a)	(TF(a & NAND_Ecc_P2o)		<< 7 )

ERROR: no space before that close parenthesis ')'
#736: FILE: include/asm-arm/arch-omap/nand.h:89:
+#define P4e_s(a)	(TF(a & NAND_Ecc_P4e)		<< 0 )

ERROR: no space before that close parenthesis ')'
#737: FILE: include/asm-arm/arch-omap/nand.h:90:
+#define P4o_s(a)	(TF(a & NAND_Ecc_P4o)		<< 1 )

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--rwEMma7ioTxnRzrJ--
