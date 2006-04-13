From: Chetan Kapoor <chetan.kapoor@flextronicssoftware.com>
Subject: P2 730: Accidental Sysboot/U-boot Erase
Date: Thu, 13 Apr 2006 13:54:01 +0530
Message-ID: <OF8A56AE65.9D002E79-ON6525714F.002A5AFB-6525714F.002E2A0A@flextronicssoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
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
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello

It seems that I accidentally erased the Sysboot OR U-boot binary present 
in the P2 730 NOR Flash. (Sysboot was present in the factory-shipped P2 
board, U-boot was flashed by me on to the NOR flash, thus overwriting 
Sysboot, using a utility called W32REPRO.EXE).

Quick notes about our host-target setup for  P2 730:

- Sysboot present in the factory shipped board, we received Sysboot traces 
onto hyperterminal with the main board switch configuration (2,3,7,9 - ON, 
 Rest - OFF)
- u-boot.bin written on the NOR flash using W32REPRO.EXE (using the same 
switch settings as above)
- u-boot prompt came up on the next power-up (this showed that Sysboot has 
been overwritten by u-boot)
- linux kernel image (arm/omap730 build) downloaded to P2's RAM using 
u-boot->loadb 0x10008000 and triggering hyperterminal->send 
file->protocol=kermit options.
- kernel executed using u-boot command bootm 0x10008000

Now, I was downlaoding the RAMDISK image onto the target using the 
u-boot->loadb 0x000010000 command & hyperterminal->send file options. The 
write address was 0x00001000. But, it seems that I ended up corrupting 
u-boot present on the NOR flash, as that board did not come up after the 
next power-up & there were no u-boot/sysboot traces visible through the 
serial port/hyperterminal.

I was not very sure that the address 0x00001000 points to the NOR flash on 
not OR rather where the address 0x00001000 points to. The switch 
configuration when this mishap occurred was the same as above (2,3,7,9 - 
ON, Rest - Off). Does anyone have an idea where the address 0x000010000 
points to with the above switch setting on P2 main board.

The board is not coming up upon power-up, and moreover we are not able to 
flash the same u-boot binary, which we used earlier, again to the NOR 
flash. It seems that Sysboot persence was mandatory for u-boot.bin to be 
flashed onto the NOR flash.

Any ideas on how Sysboot can be flashed again to the target?? We have a 
file Sysboot_P2SampleRev5_NOR.out which needs to be downloaded & executed 
from P2's RAM and it will flash sysboot on to the NOR flash (according to 
the vendor), but this also does not work for us.

Also, is anyone having the P2 730 complete memory map??, the one given in 
P2 reference guide doesn't seem to list P2 RAM addresses, also it mentions 
presence of 'Internal Boot Rom' in the memory map, which is not very 
clear. 

Your answers will be of great help as we are stuck now and the board seems 
to be dead as there is not Sysboot present.

Chetan
 
 

***********************  FSS-Unclassified   ***********************
