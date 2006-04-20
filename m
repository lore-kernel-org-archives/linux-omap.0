From: Kevin Hilman <khilman@mvista.com>
Subject: Re: Kernel Boot Problem - OMAP 730 P2 - v2.6.9-rc1-omap1
Date: Thu, 20 Apr 2006 11:17:07 -0700
Message-ID: <4447D023.6000000@mvista.com>
References: <OF7AB99364.2B971A7B-ON65257156.0050B604-65257156.0050C95E@flextronicssoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <OF7AB99364.2B971A7B-ON65257156.0050B604-65257156.0050C95E@flextronicssoftware.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Chetan Kapoor <chetan.kapoor@flextronicssoftware.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

 From what I can see, the uncompress part of the pre-boot isn't even running, 
Normally you should see "Uncompressing linux..." followed by a bunch of '.' and 
then linux will start.

Is there a reason you're using that kernel version?  I suggest you try the 
latest kernel.  I have verified that the latest git kernel builds and runs on 
OMAP730/P2.

Kevin

Chetan Kapoor wrote:
> Hello
> 
> I am trying to boot kernel version 2.6.9-rc1-omap1 on my OMAP P2 730 
> target board, but am facing problems in the kernel boot process. I am 
> using u-boot version 1.0.1, which has been burnt to the target's NOR 
> flash.
> 
> u-boot 1.0.1 is up and running on the target, and I use the command 'loadb 
> 0x(addr)' along with triggering a send file (protocol->kermit) on the 
> hyperterminal to download the kernel image 'uImage' on to the target's 
> RAM. 'uImage' is created using a utility 'mkimage' which is created by 
> u-boot build process. I specified the load address & entry point as 
> 0x10008000 while creating the uImage.
> 
> I also made sure that I properly specify the environment variables for 
> u-boot, the most important one being 'bootargs'. The following command was 
> given at the u-boot prompt to specify 'bootargs'.
> 
> OMAP730 P2 # setenv bootargs mem=32M console=ttyS0,115200n8 root=/dev/ram0 
> rw initrd=0x10400000,1M devfs=mount
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
>    Image Name:   Linux-2.6.9-rc1-omap1
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    864600 Bytes = 844.3 kB
>    Load Address: 10008000
>    Entry Point:  10008000
>    Verifying Checksum ... OK
>    XIP Kernel Image ... OK
> 
> Starting kernel ... 
> 
>                 -----> and the execution stucks beyond this point. The 
> system freezes right after u-boot finishes uncompressing the image for 
> startup. Nothing is output after that & there are no responses to any 
> input from the terminal.
> 
> I am not very sure if there is any missing step which is needed to make 
> the kernel boot or maybe I am giving the load-address/entry-point wrongly 
> while building the kernel images. 
> 
> Also, I tried changing the filed textaddr-y in the kernel makefile while 
> building the kernel zImage. Does any one have any idea that what does this 
> address signify & does it effect the kernel images created by the build 
> process. The original entry against the textaddr-y field in the kernel 
> Makefile was 0xC0008000 which was changed to 0x10008000 by me as the 
> former address looked a bit obscure & did not relate to the target's 
> memory map.
> 
> Please help me if anyone has faced the similar problem before or if anyone 
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
