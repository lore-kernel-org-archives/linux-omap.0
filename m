From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/7] Updates for common omap code for next merge window
Date: Mon, 16 Mar 2009 10:31:47 -0700
Message-ID: <20090316173146.GB19229@atomide.com>
References: <20090304214540.21101.72079.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55374 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764AbZCPRbq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 13:31:46 -0400
Content-Disposition: inline
In-Reply-To: <20090304214540.21101.72079.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [090304 13:48]:
> Hi,
> 
> This series contains updates for common omap code. Still to come
> is a series of omap3 specific patches during this week.

I've added this series to my for-next queue to wait for the merge
window to start.

> Regards,
> 
> Tony
> 
> ---
> 
> Felipe Balbi (1):
>       ARM: OMAP: get rid of OMAP_TAG_USB
> 
> Jarkko Nikula (3):
>       ARM: OMAP: Add method to register additional I2C busses on the command line
>       ARM: OMAP: Add command line option for I2C bus speed
>       ARM: OMAP: Add documentation for function omap_register_i2c_bus
> 
> Santosh Shilimkar (2):
>       ARM: OMAP: Dispatch only relevant DMA interrupts
>       ARM: OMAP: Get available DMA channels from cmdline
> 
> Timo Kokkonen (1):
>       ARM: OMAP: Export dmtimer functions
> 
> 
>  arch/arm/mach-omap1/board-ams-delta.c   |    2 -
>  arch/arm/mach-omap1/board-generic.c     |    5 +
>  arch/arm/mach-omap1/board-h2.c          |    2 -
>  arch/arm/mach-omap1/board-h3.c          |    2 -
>  arch/arm/mach-omap1/board-innovator.c   |    5 +
>  arch/arm/mach-omap1/board-nokia770.c    |    9 ---
>  arch/arm/mach-omap1/board-osk.c         |    2 -
>  arch/arm/mach-omap1/board-palmte.c      |    2 -
>  arch/arm/mach-omap1/board-palmtt.c      |    2 -
>  arch/arm/mach-omap1/board-palmz71.c     |    2 -
>  arch/arm/mach-omap1/board-sx1.c         |    2 -
>  arch/arm/mach-omap1/board-voiceblue.c   |    2 -
>  arch/arm/mach-omap2/board-apollon.c     |    2 -
>  arch/arm/mach-omap2/board-h4.c          |   34 ++++++++++
>  arch/arm/plat-omap/dma.c                |   24 +++++++
>  arch/arm/plat-omap/dmtimer.c            |   26 ++++++++
>  arch/arm/plat-omap/i2c.c                |  104 +++++++++++++++++++++++++++----
>  arch/arm/plat-omap/include/mach/board.h |    1 
>  arch/arm/plat-omap/include/mach/usb.h   |    2 +
>  arch/arm/plat-omap/usb.c                |   25 +------
>  20 files changed, 192 insertions(+), 63 deletions(-)
> 
> -- 
> Signature
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
