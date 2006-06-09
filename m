From: jason <jason.noronha@gmail.com>
Subject: osk problem with 2.6 kernel
Date: Fri, 9 Jun 2006 06:35:13 +0000 (UTC)
Message-ID: <loom.20060609T082829-119@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

I have read the posts in this mailing list and have built u-boot 1.1.4 using 
ELDK 3.1.1. It works perfectly fine on the osk 5912. but when i copy my 2.6.7 
kernel (which i also built with ELDK 3.1.1) onto the board, it just hangs 
after uncompressing the kernel. i have used an omap patch obtained from 
http://www.muru.com. Can somebody help me out? Is it working for anyone and if 
yes, what is the version of your linux kernel and are there anyone patches 
available or do any files need to be changed.

this is what is displayed :
___________________________________________________________________________
OMAP5912 OSK # bootm 0x100000
## Booting image at 00100000 ...
   Image Name:   Linux Kernel Image
   Image Type:   ARM Linux Kernel Image (gzip compressed)
   Data Size:    839088 Bytes = 819.4 kB
   Load Address: 10c08000
   Entry Point:  10c08000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

Starting kernel ...
____________________________________________________________________________

Thank you.

Regards 
Jason
