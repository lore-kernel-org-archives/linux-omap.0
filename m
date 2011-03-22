From: Heikki Krogerus <heikki.krogerus@nokia.com>
Subject: Re: [PATCH 0/2] USB: twl4030-usb: fix isp1707 xceiver powering
Date: Tue, 22 Mar 2011 11:45:42 +0200
Message-ID: <20110322094542.GD4286@esdhcp034230>
References: <1300715420-25602-1-git-send-email-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:50850 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753046Ab1CVJqE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Mar 2011 05:46:04 -0400
Content-Disposition: inline
In-Reply-To: <1300715420-25602-1-git-send-email-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, tony@atomide.com, jhnikula@gmail.com, ilkka.koskinen@nokia.com

Hi Kalle,

Missed the cover letter so I already commented the patches.

On Mon, Mar 21, 2011 at 03:50:18PM +0200, Kalle Jokiniemi wrote:
> These two patches introduce phy_power calls form board files
> to twl4030-usb. This fixes a problem in Nokia N900, where the
> ISP1707 serial tranceiver did not get disabled during phy
> power down.
> 
> Based on patches used on n900 maemo kernel, mainly from Heikki
> Krogerus. Comments&testing appreciated.
> 
> Basic test done on MeeGo + linux usb that the ISP powering
> happens correctly. Also simple data transfer tests done with
> backported patches on MeeGo n900 kernel.
> 
> Cross posting to linux-omap, but I propose that we'd push these
> to linux-usb. Patches based on linux-usb master.
> 
> Kalle Jokiniemi (2):
>   USB: twl4030-usb: do board specific phy_power up/down
>   OMAP3: rx51: specify phy_power for usb tranceiver
> 
>  arch/arm/mach-omap2/board-rx51-peripherals.c |   32 ++++++++++++++++++++++++++
>  drivers/usb/otg/twl4030-usb.c                |    9 ++++++-
>  2 files changed, 40 insertions(+), 1 deletions(-)

I do like the idea of getting the support for power down mode of
isp1707 in RX51 but...

If I understood correctly, meego has the isp1704_charger driver from
mainline, so we don't need to involve twl4030-usb when powering the
isp1707 like we did in maemo kernel.

-- 
heikki
