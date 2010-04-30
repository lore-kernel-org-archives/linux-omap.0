From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: JFFS2 summary support : problem
Date: Fri, 30 Apr 2010 16:55:25 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030D6E2ACD@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,
I am working on TI OMAP3 platform and was looking to reduce the JFFS2 mount time (NAND). 

I have selected CONFIG_JFFS2_SUMMARY, but not working fully, its giving ECC error (at end of this email) after add a new file in JFFS2. 

Without this option its working fine; but taking long time to mount. Please let me know if I am missing anything -http://dev.omapzoom.org/pub/scm/integration/kernel-omap3.git

[*] JFFS2 summary support (EXPERIMENTAL)
i.e. CONFIG_JFFS2_SUMMARY=y
=> I have created and flushed jffs2 image with summary nodes, as-
sumtool -n -e 0x20000 -p -i rootdir.jffs2 -o rootdir-sum.jffs2


# mount -t jffs2 /dev/mtdblock4 /mnt
JFFS2 notice: (640) jffs2_build_xattr_subsystem: complete building xattr subsystem, 0 of xdatum (0 unchecked, 0 orphan) and 0 of xref (0 dead, 0 orphan) found.
# umount /mnt
==> I checked this multiple time and no issue. 

# 
# mount -t jffs2 /dev/mtdblock4 /mnt
JFFS2 notice: (644) jffs2_build_xattr_subsystem: complete building xattr subsystem, 0 of xdatum (0 unchecked, 0 orphan) and 0 of xref (0 dead, 0 orphan) found.
# vi /mnt/test.c (created a new file)
# umount /mnt

# mount -t jffs2 /dev/mtdblock4 /mnt
mtd->read(0x1fb04 bytes from 0x8de04fc) returned ECC error
mtd->read(0x9a74 bytes from 0x8df658c) returned ECC error
Empty flash at 0x08df6588 ends at 0x08df6800
JFFS2 notice: (656) jffs2_build_xattr_subsystem: complete building xattr subsystem, 0 of xdatum (0 unchecked, 0 orphan) and 0 of xref (0 dead, 0 orphan) found.
mtd->read(0x7bc bytes from 0x8df6844) returned ECC error

Is there another way to fix the problem? Am I missing any patch or missing any configuration?

Thanks & regards,
Ghorai

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
