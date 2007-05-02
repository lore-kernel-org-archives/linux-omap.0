From: <parthasarathy.muniswamy@wipro.com>
Subject: JFFS2 on NAND Flash
Date: Wed, 2 May 2007 16:50:54 +0530
Message-ID: <2EE5E03B4244D94F850FC93C0B7172234C45F0@BLR-SGM-MSG01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
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

Hello to all

=20

            Our aim is to use JFFS2 with NAND flash. The target board is
SDP2430.=20

           =20

           The proceedings are described below.

=20

            Tool chain used:  arm-linux , ver 3.3.2

           =20

 Kernel: 2.6, support for MTD and JFFS2 is enabled

=20

MTD util:  mtd-utils-1.0.1

                Built this with the above tool chain, and installed it
on /Project/rootfs. This will be used as target RFS

=20

Mkefs2 utility is used to generate a ramdisk from /Project/rootfs.

=20

On successful booting the kernel on the target, with the above image and
ramdisk, we tried to use the MTD util nftl_format.=20

But it returns the following error

=20

------------

# nftl_format /dev/mtd12

/sbin/nftl_format: 1: Syntax error: "(" unexpected

---------

=20

Also, the same error results, for all the MTD util, like nandwrite,
nand_info, mkfs.jffs2, etc.

=20

Please help.=20

=20

Let me know if, you need any other information.

=20

Thanks in advance

Partha=20
