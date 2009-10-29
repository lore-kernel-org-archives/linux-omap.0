From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/5] New mux code for 34xx
Date: Thu, 29 Oct 2009 13:35:54 -0700
Message-ID: <20091029203124.11843.89983.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57902 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872AbZJ2Ufv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 16:35:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: mike.rapoport@gmail.com

Hi all,

Here's an initial version of the new mux code to play with.
Big thanks to Paul & Benoit for the 34xx mux data!

To try out the new code, compile a kernel with CONFIG_OMAP_MUX
and CONFIG_DEBUG_FS and these patches. The series is also
availabe in the l-o git in mux branch.

To see the mux configuration on your board:

# mount -t debugfs debugfs /sys/kernel/debug
# cat /sys/kernel/debug/omap_mux | less
OMAP3_MUX(CAM_D0, OMAP_PIN_INPUT | OMAP_PIN_OFF_NONE | OMAP_PIN_OFF_WAKEUPENABLE
 | OMAP_MUX_MODE4, 0),                                                          
padconf: cam_d0 signal: gpio_99:        offset: 0x0e6   value: 0x4104           
m0: cam_d0      m1:             m2:             m3:                             
m4: gpio_99     m5:             m6:             m7: safe_mode                   
phys: 0x48002116        ball bottom: ag17        ball top:                      
                                                                                
OMAP3_MUX(CAM_D10, OMAP_PIN_OUTPUT | OMAP_PIN_OFF_NONE | OMAP_MUX_MODE7, 0),    
padconf: cam_d10        signal: safe_mode:      offset: 0x0fa   value: 0x0007   
m0: cam_d10     m1:             m2:             m3:                             
m4: gpio_109    m5:             m6:             m7: safe_mode                   
phys: 0x4800212a        ball bottom: b25         ball top:
...

Then to produce a list of board mux entries from a working
system, do:

# cat /sys/kernel/debug/omap_mux | grep OMAP3_MUX
OMAP3_MUX(CAM_D0, OMAP_PIN_INPUT | OMAP_PIN_OFF_NONE | OMAP_PIN_OFF_WAKEUPENABLE
 | OMAP_MUX_MODE4, 0),                                                          
OMAP3_MUX(CAM_D10, OMAP_PIN_OUTPUT | OMAP_PIN_OFF_NONE | OMAP_MUX_MODE7, 0),    
OMAP3_MUX(CAM_D11, OMAP_PIN_INPUT | OMAP_PIN_OFF_NONE | OMAP_PIN_OFF_WAKEUPENABL
E | OMAP_MUX_MODE4, 0),                                                         
OMAP3_MUX(CAM_D1, OMAP_PIN_INPUT | OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_NONE | O
MAP_PIN_OFF_WAKEUPENABLE | OMAP_MUX_MODE4, 0),
...

Currenly no write support to tweak the pins via debugfs,
but I'll add that soon with command line support too.

I have not really verified the data yet, but it mostly looks
right. Adding support for 3630 and omap4 should be easy
after generating the data. It's currently implemented only
for 34xx.

I guess the next step would be to convert all omap3 calls
to omap_cfg_reg() to use omap_mux_set() instead with the
new data and make sure things work. Then we can remove the
old data for 34xx.

Comments welcome as always.

Regards,

Tony


---

Mike Rapoport (1):
      omap2: mux: intoduce omap_mux_{read,write}

Tony Lindgren (4):
      omap: mux: Add debugfs support for new mux code
      omap: mux: Add new style init functions to omap3 board-*.c files
      omap: mux: Add new style pin multiplexing data for 34xx
      omap: mux: Add new style pin multiplexing code for omap3


 arch/arm/mach-omap2/Makefile             |    4 
 arch/arm/mach-omap2/board-3430sdp.c      |    9 
 arch/arm/mach-omap2/board-cm-t35.c       |    9 
 arch/arm/mach-omap2/board-ldp.c          |    9 
 arch/arm/mach-omap2/board-omap3beagle.c  |    9 
 arch/arm/mach-omap2/board-omap3evm.c     |    9 
 arch/arm/mach-omap2/board-omap3pandora.c |    9 
 arch/arm/mach-omap2/board-overo.c        |    8 
 arch/arm/mach-omap2/board-rx51.c         |   10 
 arch/arm/mach-omap2/board-zoom2.c        |    8 
 arch/arm/mach-omap2/mux.c                |  424 ++++++++
 arch/arm/mach-omap2/mux.h                |  127 ++
 arch/arm/mach-omap2/mux34xx.c            | 1552 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/mux34xx.h            |  352 +++++++
 14 files changed, 2533 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mach-omap2/mux.h
 create mode 100644 arch/arm/mach-omap2/mux34xx.c
 create mode 100644 arch/arm/mach-omap2/mux34xx.h

-- 
Signature
