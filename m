From: "Arun KS" <getarunks@gmail.com>
Subject: Issue With MMC driver for 2430
Date: Wed, 26 Dec 2007 18:09:22 +0530
Message-ID: <dfeb90390712260439y7d8f7393w530c732fa48a56c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dear Madhu,

I am using OMAP-2430 based custom board. I am facing some issue with MMC
card detection. When I use NFS as file system my card is getting detected. I
have a requirement of using ramdisk as the filesystem, which is of size
20MB.
When I use 20MB ramdisk as the filesystem, the MMC card is not getting
detected.

I want to give you one more input. When I use 4MB ramdisk, the mmc driver
detects the card. I think its a timing  issue. I changed in the architecture
specific file (arch/arm/mach-omap/board-2530xxx-mmc.c) the following and got
my card detected by the driver.


 ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
                                                VSEL_S2_CLR,
VMMC1_DEDICATED);
                if (ret != 0)
                        goto err;
//msleep(100);
mdelay(5000);
 omap_writel(omap_readl(OMAP2_CONTROL_PBIAS) | 0x7,
                        OMAP2_CONTROL_PBIAS);

And I think this is not the right way to make it work. Please provide your
suggestions/comments on this.


Thanks
Arun KS
