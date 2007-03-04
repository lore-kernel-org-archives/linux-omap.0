From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Pending February (March) patches
Date: Sun, 04 Mar 2007 18:22:20 +0100
Message-ID: <45EB004C.40403@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

please find below my list of pending OMAP patches for 
January 2007 (and from March up to now). As ususal, if you 
think anything is wrong, missing or already applied, please 
correct. Especially if I lost the track for N800, mainly the 
camera patches, forgive me and correct ;)

Pending OMAP patches February 2007
----------------------------------

1. [PATCH 1/4] [PATCH] ARM: OMAP: Update camera sensor interface
http://linux.omap.com/pipermail/linux-omap-open-source/2007-February/009063.html

2. [PATCH 2/4] ARM: OMAP: Add OMAP2 camera driver
http://linux.omap.com/pipermail/linux-omap-open-source/2007-February/009069.html

3. [PATCH 3/4] ARM: OMAP: Add devices entry for camera.
http://linux.omap.com/pipermail/linux-omap-open-source/2007-February/009064.html

4. [PATCH 4/4] ARM: OMAP: Fix build breakage of OMAP1 camera 
driver
http://linux.omap.com/pipermail/linux-omap-open-source/2007-February/009065.html

5. [PATCH] ARM: OMAP: Philips TEA5761 Radio driver for N800
http://linux.omap.com/pipermail/linux-omap-open-source/2007-February/009067.html

6. [PATCH] Add PRCM scheme I on omap2420
http://linux.omap.com/pipermail/linux-omap-open-source/2007-February/009076.html


Pending OMAP patches March 2007
-------------------------------

1. [PATCH 1/4 take2] ARM: OMAP: Add MMU framework
http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009175.html

2. [PATCH 2/4 take2] ARM: OMAP: MMU implementations for 
OMAP1 and OMAP2
http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009176.html

3. [PATCH 3/4 take2] ARM: OMAP: Adapt to new MMU framework
http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009177.html

4. [PATCH 4/4 take2] ARM: OMAP: MMU fwk modulisation and 
misc. changes.
http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009178.html

5. [PATCH] Display Controller Library for OMAP2420/2430/3430 
platforms.
http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009182.html

6. [PATCH] OneNAND driver update for N800 kernel
http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009186.html

7. [PATCH] ARM: OMAP: Update board-n800-audio.c with fixes 
done after first release
http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009190.html

8. [PATCH] Micron Camera sensor support
http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009202.html

9. [PATCH] Move N800 specific OneNand setup to N800 platform 
file
http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009210.html

Depends on OneNAND patch in "[PATCH] Basic N800 support"
http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008958.html

10. [PATCH] to revert the drivers/video/Kconfig changes
http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009208.html

11. [PATCH] ARM: OMAP: Fix USB compilation for N800 defconfig
http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009212.html

12. [PATCH] OMAP1: Add clock for the SOSSI
http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009214.html

13. [PATCH] board_nokia770: add hwa742 platform data
http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009215.html

14. [PATCH] ARM: OMAP: Fix SPI merge issues and reintroduce 
omap_uwire.c
http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009217.html

15. [PATCH] ARM: OMAP2: Update N800 defconfig
(fix broken net/ipv4/netfilter/ipt_IDLETIMER.c)
http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009218.html

16. [PATCH] add ssi/Kconfig to arch/arm/Kconfig
http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009223.html


"Dave, can you have a look" patches ;)
--------------------------------------

1. [review] OMAP2 USB device DMA support
http://linux.omap.com/pipermail/linux-omap-open-source/2006-November/008342.html

2. [PATCH] MUSB HDRC: RMMOD fixing
http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008853.html

3. [PATCH] ARM: OMAP: Fix warnings in musb_procfs.c
http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008903.html


Open, do not apply yet (see list archives for details)
------------------------------------------------------

I removed here "PalmZ71 MPUIO monitoring" and 
"omap-alsa-aic23.c cleanup". See same section in

http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008778.html

for details.


Best regards

Dirk
