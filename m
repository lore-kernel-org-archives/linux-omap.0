From: "arun c" <arun.edarath@gmail.com>
Subject: flashing of x-loader and u-boot
Date: Thu, 28 Jun 2007 11:42:29 +0530
Message-ID: <c656a4d20706272312m64c948bey285a082a951d0ba3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi all,

I am using omap2430SDP board.I have a doubt with that board

For booting from nand flash i am doing these steps

1) I am flashing the u-boot.bin to nand at address 0x10000 using u-boot

2) Then i am flashing xload.bin.ift to address 0x0c000000 using CSST

>From manuals i found that nand is mapped to address 0x0c000000.

so why can,t we flash xload.bin at 0x0c000000 and uboot.bin at
0x0c000000+<size of xload.bin> ?.. Instead of this why we are writing u-boot at
0x10000?


Thanks&Regards

Arun
