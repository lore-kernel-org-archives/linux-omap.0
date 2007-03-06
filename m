From: "sandeep prabhu" <sandeep.mitian@gmail.com>
Subject: query on u-boot support for Micron nand flash
Date: Tue, 6 Mar 2007 14:41:17 +0530
Message-ID: <c04186510703060111l6928d500ocaea71d55cf77af8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

I am using Micron NAND flash (MT29F1GxxABB) on a custom omap2430 based
board, to which I am porting the u-boot (version 1.1.4).
I am downloading the u-boot ELF image using CCS and trying to access NAND
Flash using the u-boot commands. I am using the nand legacy
driver(drivers/nand_legacy/nand_legacy.c).
I am able to detect the nand flash, and retrieve the vendor and device ID
properly, but read/write operations fail on nand flash.

Nand Chip Details:
Chip       : MT29F1GxxABB
Total Size : 128MB
Page Size  : 2KB
OOB Size   : 64bytes per page.
Block Size : 128KB = 64Pages
# of Blocks: 1024
Bus Width  : 16 bit (16x)

I have following queries on this:

1. Does u-boot support large page NAND devices like this Micron chip ? and
if it does, how to enable it ?
2. Does anyone has driver for Micron NAND Flash ? any patches that need to
be applied ?


Please help,
Sandeep Prabhu
