From: Ram <vshrirama@gmail.com>
Subject: 2430 linux does not boot in nand
Date: Thu, 18 Jan 2007 20:10:37 +0530
Message-ID: <8bf247760701180640g1886b5edu4cadbeb2a4a2f7c2@mail.gmail.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
  Im using Linux 2.6.14-omap-2430ONLY linux which i downloaded for
linux.omap.com, i have also tried linux-2.6.16omap2430.tgz also.

  Im using a TI 2430 SDP board.

 This kernel, im able to boot in NOR flash, but not in NAND flash.
  However, im able to boot 2.6.19 in NOR and NAND without any problem.
  So, i presume, there is no problem with nand u-boot bootloader.

  I dont understand why the same kernel with the same bootargs boots
in NOR, but not in NAND.

  All i get is --

OMAP243X SDP # bootm
## Booting image at 80000000 ...
  Image Name:   Linux Kernel Image
  Image Type:   ARM Linux Kernel Image (gzip compressed)
  Data Size:    1404634 Bytes =  1.3 MB
  Load Address: 80c08000
  Entry Point:  80c08000
  Verifying Checksum ... OK
  Uncompressing Kernel Image ... OK

Starting kernel ...

Uncompressing Linux..............................................................................................
done, booting the kernel.

I dont know how to debug - since, immediately after i get 'booting the
kernel' it hangs.
how does one debug? - im not sure if serial port is getting enabled/not.

Do i need to check any specific configuration option?.

Should i need to enable a few options in make menuconfig for nand booting?

Any advices,

Regards,
sriram
