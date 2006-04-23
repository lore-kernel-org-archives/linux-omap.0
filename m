From: Chetan Kapoor <chetan.kapoor@flextronicssoftware.com>
Subject: Re: Kernel Boot Problem - OMAP 730 P2 - v2.6.9-rc1-omap1
Date: Sun, 23 Apr 2006 17:22:39 +0530
Message-ID: <OF6F4A756C.0828421B-ON65257159.003E3CD8-65257159.004144B0@flextronicssoftware.com>
References: <4449091D.2030009@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4449091D.2030009@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello Kevin & Qi

Thanks a lot for the help.

Kevin, we downloaded the uImage from the ftp location you gave. It seems 
to execute properly but only after we load the image onto an address 
different from 0x10008000 (which is the value of load address & entry 
point specified by mkimage or make uImage). We downloaded the image onto 
the target at address 0x10800000, without changing the load address & 
entry point values (which are set to 0x10008000 by make uImage), an did a 
'bootm 0x10800000' and received the kernel boot traces:

OMAP730 P2 # bootm 0x10800000
## Booting image at 10800000 ...
   Image Name:   Linux-2.6.16-omap1
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1121704 Bytes =  1.1 MB
   Load Address: 10008000
   Entry Point:  10008000
   Verifying Checksum ... OK
OK

Starting kernel ...

Uncompressing 
Linux.............................................................
................ done, booting the kernel.
Linux version 2.6.16-omap1 (root@handset) (gcc version 3.3.2) #1 PREEMPT 
Fri Apr
 21 17:54:17 IST 2006
CPU: ARM926EJ-Sid(wb) [41069263] revision 3 (ARMv5TEJ)
Machine: OMAP730 Perseus2
Memory policy: ECC disabled, Data cache writeback
OMAP07303 revision 1 handled as 07xx id: 0000000000000000
SRAM: Mapped pa 0x20000000 to va 0xd0000000 size: 0x32000
CPU0: D VIVT write-back cache
CPU0: I cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
CPU0: D cache: 8192 bytes, associativity 4, 32 byte lines, 64 sets
Built 1 zonelists........
..
..
..
..
..


For days, we were downloading the uImage to the address 0x10008000 which 
is same as the load address & entry point specified by make uImage 
(mkimage at the backend), and the image execution used to be stuck beyond 
the "Starting Kernel......" point, also the bootm 0x10008000 commad 
displayed the image to be an XIP one. 

I am not very sure why we were not able to execute the image from 
0x10008000, as it seems to execute perfectly from the address 0x10800000. 
Remember, the load address & entry point were the same in both these 
cases.

It this a rule of thumb that we should not load the image onto the 
target's ram at an address which is not the same as its entry point or is 
there a way to come up with a XIP uImage.

Thanks again,

Cheers!!

Chetan 




Kevin Hilman <khilman@mvista.com> 
04/21/2006 10:02 PM


To
Chetan Kapoor/HSS@HSS
cc
Qi <linux0x0@gmail.com>, linux-omap-open-source@linux.omap.com
Subject
Re: Kernel Boot Problem - OMAP 730 P2 - v2.6.9-rc1-omap1






Chetan Kapoor wrote:
> Hello
> 
> Thanks for the reply.
> 
> Yes, we tried out downloading the zImage to the SDRAM & executing it 
using 
> 'go' command. And, we did get the kernel boot traces on the terminal. 

This is expeted.  u-boot doesn't pass bootargs when using 'go', only 
'bootm'

> the uImage still doesn't seem to execute. uImage was created using the 
> mkimage utility. The command issued (on the development host) to create 
> uImage is:
> 
> mkimage -n 'Linux Kernel Image 2.6.9-rc1-omap1' -A arm -O linux -T 
kernel 
> -C none -a 0x10008000 -e 0x10008000 -d zImage uImage

You can also use 'make uImage' in the kernel source.  I've done a 'make 
uImage' 
with the latest git tree.  You can also grab the resultant uImage from 
ftp://hilman.org/omap730/uImage-2.6.16-rc5-omap1 to test on your board.

You might try updating your u-boot.  The version on my board (rev4) is 
1.1.4. 
There should be a newer u-boot available on linux.omap.com (which is 
currently 
down.)

Kevin



***********************  FSS-Unclassified   ***********************
