From: Qi <linux0x0@gmail.com>
Subject: Re: Kernel Boot Problem - OMAP 730 P2 - v2.6.9-rc1-omap1
Date: Fri, 21 Apr 2006 15:25:18 +0800
Message-ID: <d911ca650604210025k34643318o615b5212a7a916b1@mail.gmail.com>
References: <OF7AB99364.2B971A7B-ON65257156.0050B604-65257156.0050C95E@flextronicssoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <OF7AB99364.2B971A7B-ON65257156.0050B604-65257156.0050C95E@flextronicssoftware.com>
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
To: Chetan Kapoor <chetan.kapoor@flextronicssoftware.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

There no enough information to find out the problem .
So, I suggest you:
1st, download zImage or Image to SDRAM, and run it. If your serial is
correct configurated, you will see the serial output you expected.

If not, then report the output of serial.



2006/4/20, Chetan Kapoor <chetan.kapoor@flextronicssoftware.com>:
>
> Hello
>
> I am trying to boot kernel version 2.6.9-rc1-omap1 on my OMAP P2 730
> target board, but am facing problems in the kernel boot process. I am
> using u-boot version 1.0.1, which has been burnt to the target's NOR
> flash.
>
> u-boot 1.0.1 is up and running on the target, and I use the command 'load=
b
> 0x(addr)' along with triggering a send file (protocol->kermit) on the
> hyperterminal to download the kernel image 'uImage' on to the target's
> RAM. 'uImage' is created using a utility 'mkimage' which is created by
> u-boot build process. I specified the load address & entry point as
> 0x10008000 while creating the uImage.
>
> I also made sure that I properly specify the environment variables for
> u-boot, the most important one being 'bootargs'. The following command wa=
s
> given at the u-boot prompt to specify 'bootargs'.
>
> OMAP730 P2 # setenv bootargs mem=3D32M console=3DttyS0,115200n8 root=3D/d=
ev/ram0
> rw initrd=3D0x10400000,1M devfs=3Dmount
>
> The ramdisk image was then downloaded to the target's RAM over the serial
> line at the 'initrd' address - 0x10400000. Having done everything by the
> book, I now issue the following command to boot the kernel:
>
> OMAP730 P2 # bootm 0x10008000 0x10400000
>
> The traces received on the hyperterminal are:
>
>
> ## Booting image at 10008000 ...
>   Image Name:   Linux-2.6.9-rc1-omap1
>   Image Type:   ARM Linux Kernel Image (uncompressed)
>   Data Size:    864600 Bytes =3D 844.3 kB
>   Load Address: 10008000
>   Entry Point:  10008000
>   Verifying Checksum ... OK
>   XIP Kernel Image ... OK
>
> Starting kernel ...
>
>                -----> and the execution stucks beyond this point. The
> system freezes right after u-boot finishes uncompressing the image for
> startup. Nothing is output after that & there are no responses to any
> input from the terminal.
>
> I am not very sure if there is any missing step which is needed to make
> the kernel boot or maybe I am giving the load-address/entry-point wrongly
> while building the kernel images.
>
> Also, I tried changing the filed textaddr-y in the kernel makefile while
> building the kernel zImage. Does any one have any idea that what does thi=
s
> address signify & does it effect the kernel images created by the build
> process. The original entry against the textaddr-y field in the kernel
> Makefile was 0xC0008000 which was changed to 0x10008000 by me as the
> former address looked a bit obscure & did not relate to the target's
> memory map.
>
> Please help me if anyone has faced the similar problem before or if anyon=
e
> can make out the missing link in the steps which I am doing in order to
> boot the kernel image.
>
> Your reply & suggestion will be of great help.
>
> Chetan
>
> ***********************  FSS-Unclassified   ***********************
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>



--
q.h.
