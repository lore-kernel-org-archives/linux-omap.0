From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: 2430 linux does not boot in nand
Date: Thu, 18 Jan 2007 21:29:09 -0600
Message-ID: <45B03B05.5000202@gmail.com>
References: <8bf247760701180640g1886b5edu4cadbeb2a4a2f7c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <8bf247760701180640g1886b5edu4cadbeb2a4a2f7c2@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ram <vshrirama@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Ram stated on 1/18/2007 8:40 AM:
> Hi,
>  Im using Linux 2.6.14-omap-2430ONLY linux which i downloaded for
> linux.omap.com, i have also tried linux-2.6.16omap2430.tgz also.
>
>  Im using a TI 2430 SDP board.
>
which version? V4.0 or above?
> I dont understand why the same kernel with the same bootargs boots
> in NOR, but not in NAND.
>
u have other variables such as a bootloader...
>  All i get is --
>
> OMAP243X SDP # bootm
> ## Booting image at 80000000 ...
>  Image Name:   Linux Kernel Image
>  Image Type:   ARM Linux Kernel Image (gzip compressed)
>  Data Size:    1404634 Bytes =  1.3 MB
>  Load Address: 80c08000
>  Entry Point:  80c08000
>  Verifying Checksum ... OK
>  Uncompressing Kernel Image ... OK
>
ok so u booted just fine.. u reached the uboot prompt, which is good..
> Starting kernel ...
>
> Uncompressing
> Linux..............................................................................................
>
> done, booting the kernel.
Now, u need to go back and check ur bootargs. in general that is the
culprit.. or u got some bad uboot/x-loader in ur board that did not some
clock setting proper or got some dip switch messed up .. am just
guessing here..

>
> Should i need to enable a few options in make menuconfig for nand
> booting?
none that i have heard of :)

Regards,
NM
