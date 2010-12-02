From: Felipe Balbi <balbi@ti.com>
Subject: [GIT PULL] FOR TESTING ONLY
Date: Thu, 2 Dec 2010 13:48:05 +0200
Message-ID: <20101202114805.GT5429@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:53662 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757073Ab0LBLs2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 06:48:28 -0500
Received: by gyh3 with SMTP id 3so4485371gyh.12
        for <linux-omap@vger.kernel.org>; Thu, 02 Dec 2010 03:48:27 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi Tony,

I have a gigantic amount of patches on musb starting to move it to a
place where we can build am35x.c, omap2430.c and tusb6010.c together and
have a working binary.

There are a few changes still needed (as per comments Mike's comments on
linux-usb) but it's working fine on my pandaboard. Mike's comments are
mostly cosmetic (appending _musb suffix to function names and adding
const to a struct, for example).

If you could merge them into linux-omap so we can put the hwmod and
pm_runtime patches on top, I'd be glad.

Keep in mind that branch still might get rebased, so get ready to merge
-s ours :-p

Below is the pull request:

The following changes since commit e8a7e48bb248a1196484d3f8afa53bded2b24e71:

   Linux 2.6.37-rc4 (2010-11-29 20:42:04 -0800)

are available in the git repository at:
   git://gitorious.org/usb/usb.git musb-hw

Felipe Balbi (29):
       usb: musb: introduce struct musb_platform_ops
       usb: musb: make all glue layer export struct musb_platform_ops
       arm: omap4: panda: initialize musb
       usb: musb: hold context on musb structure
       usb: musb: add Kconfig options for each glue layer
       usb: musb: trivial search and replace patch
       usb: musb: split omap2430 to its own platform_driver
       usb: musb: split am35x to its own platform_driver
       usb: musb: split tusb6010 to its own platform_driver
       usb: musb: split davinci to its own platform_driver
       usb: musb: split da8xx to its own platform_driver
       usb: musb: split blackfin to its own platform_driver
       usb: musb: omap2430: give it a context structure
       usb: musb: am35x: give it a context structure
       usb: musb: tusb6010: give it a context structure
       usb: musb: davinci: give it a context structure
       usb: musb: da8xx: give it a context structure
       usb: musb: blackfin: give it a context structure
       usb: musb: pass platform_ops via platform_data
       usb: musb: mark ->set_clock deprecated
       usb: musb: move clock handling to glue layer
       usb: musb: drop the set_clock magic
       usb: musb: drop musb_platform_save/restore_context
       usb: musb: mark musb_save/restore_context static
       usb: musb: omap2430: drop the nops
       usb: musb: omap2430: use dev_pm_ops structure
       usb: musb: am35x: usb dev_pm_ops structure
       usb: musb: blackfin: usb dev_pm_ops structure
       usb: musb: drop musb_platform_suspend/resume

  arch/arm/mach-davinci/usb.c                  |    5 +-
  arch/arm/mach-omap2/board-n8x0.c             |    6 +-
  arch/arm/mach-omap2/board-omap4panda.c       |    1 +
  arch/arm/mach-omap2/clock2420_data.c         |    2 +-
  arch/arm/mach-omap2/clock2430_data.c         |    2 +-
  arch/arm/mach-omap2/clock3xxx_data.c         |    8 +-
  arch/arm/mach-omap2/clock44xx_data.c         |    2 +-
  arch/arm/mach-omap2/usb-musb.c               |    5 +-
  arch/arm/mach-omap2/usb-tusb6010.c           |    2 +-
  arch/blackfin/mach-bf527/boards/ad7160eval.c |    2 +-
  arch/blackfin/mach-bf527/boards/cm_bf527.c   |    2 +-
  arch/blackfin/mach-bf527/boards/ezbrd.c      |    2 +-
  arch/blackfin/mach-bf527/boards/ezkit.c      |    2 +-
  arch/blackfin/mach-bf527/boards/tll6527m.c   |    2 +-
  arch/blackfin/mach-bf548/boards/cm_bf548.c   |    2 +-
  arch/blackfin/mach-bf548/boards/ezkit.c      |    2 +-
  drivers/usb/gadget/gadget_chips.h            |    2 +-
  drivers/usb/musb/Kconfig                     |   71 +++-----
  drivers/usb/musb/Makefile                    |   20 +--
  drivers/usb/musb/am35x.c                     |  267 +++++++++++++++++++++----
  drivers/usb/musb/blackfin.c                  |  177 +++++++++++++++--
  drivers/usb/musb/da8xx.c                     |  165 +++++++++++++++--
  drivers/usb/musb/davinci.c                   |  160 ++++++++++++++-
  drivers/usb/musb/musb_core.c                 |  168 ++++++----------
  drivers/usb/musb/musb_core.h                 |  184 +++++++++++-------
  drivers/usb/musb/musb_io.h                   |    4 +-
  drivers/usb/musb/musb_regs.h                 |    4 +-
  drivers/usb/musb/musb_virthub.c              |    2 +-
  drivers/usb/musb/omap2430.c                  |  271 ++++++++++++++++++++------
  drivers/usb/musb/tusb6010.c                  |  163 +++++++++++++--
  include/linux/usb/musb.h                     |    8 +-
  31 files changed, 1282 insertions(+), 431 deletions(-)

-- 
balbi
