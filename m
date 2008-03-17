From: "Tim Chen" <tim.chen.86@gmail.com>
Subject: OMAP730/850 NAND flash problem, ECC error.
Date: Mon, 17 Mar 2008 15:43:11 +0800
Message-ID: <9c1eb1b90803170043l7a019ac2jd300f6d55c7f9c12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:11509 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbYCQHnM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2008 03:43:12 -0400
Received: by rv-out-0910.google.com with SMTP id k20so3121770rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 17 Mar 2008 00:43:11 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,
My board is Zante which is an OMAP730(actually OMAP850, but the two
processors are almost the same) based board,
I'm trying to mount root file system from JFFS2.
The NAND flash part is Samsung K5E1212-ACB MCP(64MB NAND flash / 64MB DDR),

The NAND device structures in board-zante.c are as follows.

static struct mtd_partition zante_nand_partitions[] = {
        {
                .name           = "xloader",
                .offset         = 0,
                .size           = 64 * 1024,
                .mask_flags     = MTD_WRITEABLE,        /* force read-only */
        },
        {
                .name           = "bootloader",
                .offset         = MTDPART_OFS_APPEND,
                .size           = 256 * 1024,
                .mask_flags     = MTD_WRITEABLE,        /* force read-only */
        },
        {
                .name           = "params",
                .offset         = MTDPART_OFS_APPEND,
                .size           = 192 * 1024,
        },
        {
                .name           = "kernel",
                .offset         = MTDPART_OFS_APPEND,
                .size           = 2 * SZ_1M,
        },
        {
                .name           = "filesystem",
                .size           = MTDPART_SIZ_FULL,
                .offset         = MTDPART_OFS_APPEND,
        },
};

/* dip switches control NAND chip access:  8 bit, 16 bit, or neither */
static struct omap_nand_platform_data nand_data = {
        .options        = NAND_SAMSUNG_LP_OPTIONS,
        .parts          = zante_nand_partitions,
        .nr_parts       = ARRAY_SIZE(zante_nand_partitions),
        .device_width   = 8,
};

static struct resource nand_resource = {
        .start          = OMAP_CS3_PHYS,
        .end            = OMAP_CS3_PHYS + SZ_64M - 1,
        .flags          = IORESOURCE_MEM,
};

static struct platform_device nand_device = {
        .name           = "omapnand",
        .id             = 0,
        .dev            = {
                .platform_data  = &nand_data,
        },
        .num_resources  = 1,
        .resource       = &nand_resource,
};


And in the linux-2.6.24-omap1/drivers/mtd/nand/Kconfig, I added
MACH_OMAP_ZANTE to the "config MTD_NAND_OMAP" part, so that make sure
omap-nand-flash.c is used.

The kernel boot message is as follows.
Kernel command line: root=/dev/mtdblock4 rootfstype=jffs2
init=/sbin/init console=ttyS1,115200
NAND device: Manufacturer ID: 0xec, Chip ID: 0x36 (Samsung NAND 64MiB
1,8V 8-bit)
Scanning device for bad blocks
Bad eraseblock 753 at 0x00bc4000
Bad eraseblock 1007 at 0x00fbc000
Bad eraseblock 1112 at 0x01160000
Bad eraseblock 1281 at 0x01404000
Bad eraseblock 1948 at 0x01e70000
Bad eraseblock 2158 at 0x021b8000
Bad eraseblock 2328 at 0x02460000
Bad eraseblock 2941 at 0x02df4000
Creating 5 MTD partitions on "omapnand.0":
0x00000000-0x00010000 : "xloader"
0x00010000-0x00050000 : "bootloader"
0x00050000-0x00080000 : "params"
0x00080000-0x00280000 : "kernel"
0x00280000-0x04000000 : "filesystem"

And then followed by many errors like:
mtd->read(0x200 bytes from 0x3e00) returned ECC error
mtd->read(0x400 bytes from 0x0) returned ECC error
CLEANMARKER node found at 0x00000000 has totlen 0xc != normal 0x0
mtd->read(0x3c04 bytes from 0x3fc) returned ECC error
jffs2_scan_inode_node(): CRC failed on node at 0x000039d8: Read 0xe4eb139a, calc
ulated 0x538ae90c
mtd->read(0x8c bytes from 0x3f74) returned ECC error
mtd->read(0x200 bytes from 0x7e00) returned ECC error
mtd->read(0x400 bytes from 0x4000) returned ECC error

Then, kernel stop at one "mtd->read(xxxx) returned ECC error" error.

The code base is just checked out from OMAP Linux GIT tree.

Any thing should I check for the NAND driver?

Thanks in advance.

-- 
--
Regards,
Tim.
