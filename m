From: Husam <husamsenussi@gmail.com>
Subject: Reading/Writing to MMC without interrupt handler
Date: Sat, 1 Apr 2006 13:04:36 +0100
Message-ID: <200604011304.36250.husamsenussi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
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

Hi,

I guess this stupid question, but I'm going to asked anyway :)

I'm adding ipaq h6300 support to u-boot which based OMAP1510 processer, I want 
to allow u-boot to load an kernel image from MMC/SD card.

I did make the changes but I'm having problem reading from the MMC card 
(Getting Data Timeout) ,

At the moment I'm polling for the status without using irq, and that seems to 
work for configuring the card and reading manufacturer information like date, 
serial number  etc.

mca_vsn : 03
cmdclass : 1F5
tacc_clks: 00
tacc_ns  : 4C4B400
max_dtr  : 1312D00
read_blkbits: 9
capacity    : 1003520
Manufacturer ID = 0000049A
HW/FW Revision = 0 0
Product Name = MMC
Serial Number = 0000049a
Month = 12
Year = 2004

My question is it passible to do that without having to enable irq and using 
interrupt handler?

Thanks 
