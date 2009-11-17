From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/8] musb: Add structure 'musb_hdrc_board_data'
Date: Tue, 17 Nov 2009 20:39:48 +0530
Message-ID: <1258470596-24321-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

This patch set adds a new structure 'musb_hdrc_board_data' to get all
board specific data from board files.

It is actually done to accomodate ULPI_VBUSCONTROL programming required
for OMAP3EVM Rev >=E which uses external Vbus supply to support 500mA.

Necessarly changes have been done in all the OMAP, Davinci and Blackfin
platform based boards.

[patches created against linus's tree and tested on OMAP3EVM]

Regards,
Ajay

Ajay Kumar Gupta (8):
  musb: Add structure to get board specific data
  musb: Get power (mA) from board data
  musb: Update musb_init() call for all OMAP3 boards
  musb: Update setup_usb() call for all Davinci boards
  musb: Add 'extvbus' in musb_hdrc_board_data
  musb: set 'extvbus = 0' for OMAP3 boards
  musb: set 'extvbus = 0' for Davinci boards
  musb: set 'extvbus = 0' for Blackfin boards

 arch/arm/mach-davinci/board-dm355-evm.c     |   10 +++++++++-
 arch/arm/mach-davinci/board-dm355-leopard.c |   10 +++++++++-
 arch/arm/mach-davinci/board-dm644x-evm.c    |    9 ++++++++-
 arch/arm/mach-davinci/board-sffsdr.c        |   10 +++++++++-
 arch/arm/mach-davinci/include/mach/common.h |    7 +++++--
 arch/arm/mach-davinci/usb.c                 |    8 ++++----
 arch/arm/mach-omap2/board-2430sdp.c         |    8 +++++++-
 arch/arm/mach-omap2/board-3430sdp.c         |    9 ++++++++-
 arch/arm/mach-omap2/board-ldp.c             |    8 +++++++-
 arch/arm/mach-omap2/board-omap3beagle.c     |    9 ++++++++-
 arch/arm/mach-omap2/board-omap3evm.c        |    9 ++++++++-
 arch/arm/mach-omap2/board-omap3pandora.c    |    9 ++++++++-
 arch/arm/mach-omap2/board-overo.c           |    9 ++++++++-
 arch/arm/mach-omap2/board-rx51.c            |    8 +++++++-
 arch/arm/mach-omap2/board-zoom2.c           |    8 +++++++-
 arch/arm/mach-omap2/usb-musb.c              |   13 +++++--------
 arch/arm/plat-omap/include/mach/usb.h       |    3 ++-
 arch/blackfin/mach-bf527/boards/cm_bf527.c  |    6 ++++++
 arch/blackfin/mach-bf527/boards/ezbrd.c     |    6 ++++++
 arch/blackfin/mach-bf527/boards/ezkit.c     |    6 ++++++
 arch/blackfin/mach-bf548/boards/cm_bf548.c  |    6 ++++++
 arch/blackfin/mach-bf548/boards/ezkit.c     |    6 ++++++
 drivers/usb/musb/musb_core.c                |   14 +++++++++++++-
 drivers/usb/musb/musb_regs.h                |    5 +++++
 include/linux/usb/musb.h                    |   19 +++++++++++++------
 25 files changed, 180 insertions(+), 35 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
