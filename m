From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/7][OMAP 3/4+] BRIDGE: Module ISR removed
Date: Sat, 13 Sep 2008 12:55:26 +0300 (EEST)
Message-ID: <20080913.125526.217888976.Hiroshi.DOYU@nokia.com>
References: <496565EC904933469F292DDA3F1663E615187D03@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:57691 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754904AbYIMJzg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Sep 2008 05:55:36 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E615187D03@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: x00omar@ti.com, x0095840@ti.com
Cc: vikram.pandita@ti.com, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, felipe.contreras@gmail.com, Juha.M.Alanen@nokia.com

Hi,

All of these patches are incorporated into the "l-o bridge patch
series". I have updated other TI BRIDGE patches and rebased them
against the latest l-o again for easy integration of TI DSP BRIDGE
patches. You can get it by:

    $ wget http://4869037.web.fc2.com/tidspbridge-20080913.tgz

Most of the patches come directly from OMAPZOOM(Thanks, TI bridge
team!) and I just collected them;)

The current major diff against OMAPZOOM is the header file
location. Now bridge specific header files are located
under"linux/arch/arm/plat-omap/include/dspbridge", which was suggested
as below:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg04126.html

This "l-o bridge patch series" includes the following patches.

Axel Haslam (1):
      BRIDGE: tiomap unmap fix

Fernando Guzman Lugo (2):
      BRIDGE: Remove sparse warnings from wcd
      BRIDGE: Module ISR removed

Guzman Lugo, Fernando (1):
      BRIDGE: PRCS wrappers removal

Hiroshi DOYU (17):
      BRIDGE: Kconfig Entry
      BRIDGE: Header files
      BRIDGE: Doff image dynamic loader
      BRIDGE: Generic Utilities
      BRIDGE: Hardware Interfaces
      BRIDGE: Platform Manager
      BRIDGE: Resource Manager
      BRIDGE: Services
      BRIDGE: Mini driver
      BRIDGE: README
      BRIDGE: Fix header path
      BRIDGE: Sync omapzoom bridge patches
      BRIDGE: set 0 for phys_mempool_* as default
      BRIDGE: Rename header file location
      BRIDGE: Fix header path name to "arch/arm/plat-omap/include/dspbridge"
      BRIDGE: Add 'dspbridge' dirname in header file inclusion
      BRIDGE: Fix incorrect pathname

Omar Ramirez Luna (7):
      BRIDGE: Ceanup GT sparse warnings
      BRIDGE: Cleanup static declarations warnings
      BRIDGE: Remove unused clk structs
      BRIDGE: Clean up unusedvariables
      BRIDGE: Cosmetic changes reported from checkpatch
      BRIDGE: Checkpatch Cleanup
      BRIDGE: MMUfault infinite timeout fix

Ramesh Gupta (2):
      BRIDGE: Power management changes
      BRIDGE: OMAP PM Bug softlockup fix

Ramirez Luna, Omar (3):
      BRIDGE: OMAP CSL wrappers removed
      BRIDGE: Remove CDECL macro
      BRIDGE: GT mask for DSP traces

x00omar@ti.com (1):
      BRIDGE: Add wcd table end

If I missed somethig, please let me know.

      Hiroshi DOYU

