From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/7] musb: Add structure 'musb_hdrc_board_data'
Date: Mon, 16 Nov 2009 13:08:32 -0800
Message-ID: <20091116210832.GR3684@atomide.com>
References: <1258275578-1773-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59567 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754242AbZKPVIa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 16:08:30 -0500
Content-Disposition: inline
In-Reply-To: <1258275578-1773-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, felipe.balbi@nokia.com, khilman@deeprootsystems.com

* Ajay Kumar Gupta <ajay.gupta@ti.com> [091115 00:59]:
> Hi,
> 
> This patch set adds a new structure 'musb_hdrc_board_data' to get all
> board specific data from board files.
> 
> It is actually done to accomodate ULPI_VBUSCONTROL programming required
> for OMAP3EVM Rev >=E which uses external Vbus supply to support 500mA.
> 
> Necessarly changes have been done in all the OMAP and Davinci platform
> based boards.
> 
> Please review and provide your feedback.
> [patches created against linux-omap/master branch and tested on OMAP3EVM]

Can you please resend with linux-usb also Cc'd? There are more architectures
using musb other than omap and davinci.

Regards,

Tony
 
> Regards,
> Ajay
> 
> Ajay Kumar Gupta (7):
>   musb: Add structure to get board specific data
>   musb: Get power (mA) from board data
>   musb: Update musb_init() call for all OMAP3 boards
>   musb: Update setup_usb() call for all Davinci boards
>   musb: Add 'extvbus' in musb_hdrc_board_data
>   musb: set 'extvbus' default value to zero
>   musb: set 'extvbus' for OMAP3EVM Rev >=E
> 
>  arch/arm/mach-davinci/board-dm355-evm.c     |   10 +++++++++-
>  arch/arm/mach-davinci/board-dm355-leopard.c |   10 +++++++++-
>  arch/arm/mach-davinci/board-dm644x-evm.c    |    9 ++++++++-
>  arch/arm/mach-davinci/board-sffsdr.c        |   10 +++++++++-
>  arch/arm/mach-davinci/include/mach/common.h |    7 +++++--
>  arch/arm/mach-davinci/usb.c                 |    8 ++++----
>  arch/arm/mach-omap2/board-2430sdp.c         |    8 +++++++-
>  arch/arm/mach-omap2/board-3430sdp.c         |    8 +++++++-
>  arch/arm/mach-omap2/board-cm-t35.c          |    8 +++++++-
>  arch/arm/mach-omap2/board-ldp.c             |    8 +++++++-
>  arch/arm/mach-omap2/board-omap3beagle.c     |    8 +++++++-
>  arch/arm/mach-omap2/board-omap3evm.c        |   10 +++++++++-
>  arch/arm/mach-omap2/board-omap3pandora.c    |    8 +++++++-
>  arch/arm/mach-omap2/board-overo.c           |    8 +++++++-
>  arch/arm/mach-omap2/board-rx51.c            |    8 +++++++-
>  arch/arm/mach-omap2/usb-musb.c              |   13 +++++--------
>  arch/arm/plat-omap/include/plat/usb.h       |    3 ++-
>  drivers/usb/musb/musb_core.c                |   14 +++++++++++++-
>  drivers/usb/musb/musb_regs.h                |    5 +++++
>  include/linux/usb/musb.h                    |   19 +++++++++++++------
>  20 files changed, 147 insertions(+), 35 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
