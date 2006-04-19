From: Chetan Kapoor <chetan.kapoor@flextronicssoftware.com>
Subject: Problem updating u-boot
Date: Wed, 19 Apr 2006 21:04:30 +0530
Message-ID: <OFFA3C4449.168C1B45-ON65257155.005572E2-65257155.005593B0@flextronicssoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
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

Hello

I am facing a problem with u-boot update on my OMAP P2 730 target. Are 
there any build-time configruation options for u-boot build related to the 
target's NAND or NOR flash. In other words, do we need to specify any 
build-time configuration options if we intend to burn the resulting u-boot 
binary to NAND or NOR flash.

I have U-boot 1.0.1 burnt to OMAP 730 P2 NOR flash. I am now trying to 
update u-boot using the method:

- Download u-boot.bin (new version) to target's RAM using serial line 
- Copy u-boot.bin to target's flash using u-boot command 'cp.b'

The u-boot version I am running presently is vendor supplied (version 
1.0.1) and I want to update it with the one I have built (version 1.1.1) 
for my target hardware.

I tried downloading the u-boot.bin to the P2 730 RAM over serial line to a 
specific address and triggered the binary's entry point using command:
go 'start address'

The new u-boot binary seems to execute as it comes up with normal u-boot 
start-up messages, but stops and hangs at a point. Please have a look at 
the traces of execution:

OMAP730 P2 # loadb 11080000
## Ready for binary (kermit) download to 0x11080000 at 115200 bps...
## Total Size      = 0x0001ca68 = 117352 Bytes
## Start Addr      = 0x11080000
OMAP730 P2 # go 11080000
## Starting application at 0x11080000 ...


U-Boot 1.1.1 (Apr 19 2006 - 15:50:59)

U-Boot code: 11080000 -> 1109CA68  BSS: -> 110A134C
RAM Configuration:
Bank #0: 10000000 32 MB
Flash:  0 kB
NAND:                                                    ---------> The 
execution hangs at this point


I am not very sure what is expected by u-boot binary at his point. The 
above binary is result of a custom build done by me. The u-boot sources 
were downloaded from http://linux.omap.com and the build time 
configuration was done using 'make omap730p2_config'.

Do I need to take care of any other build-time options/configurations?

Kindly help if you have any ideas/answers.

Your suggestion on how to update u-boot are also welcome.

Thanks

Chetan

***********************  FSS-Unclassified   ***********************
