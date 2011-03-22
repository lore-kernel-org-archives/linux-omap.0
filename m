From: <kalle.jokiniemi@nokia.com>
Subject: RE: [PATCH 0/2] USB: twl4030-usb: fix isp1707 xceiver powering
Date: Tue, 22 Mar 2011 10:19:48 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B06AFA3@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1300715420-25602-1-git-send-email-kalle.jokiniemi@nokia.com>
 <20110322094542.GD4286@esdhcp034230>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:30770 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753241Ab1CVKTz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Mar 2011 06:19:55 -0400
In-Reply-To: <20110322094542.GD4286@esdhcp034230>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Heikki.Krogerus@nokia.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, tony@atomide.com, jhnikula@gmail.com, ilkka.koskinen@nokia.com

Hi,

 > -----Original Message-----
 > From: Heikki Krogerus [mailto:heikki.krogerus@nokia.com]
 > Sent: 22. maaliskuuta 2011 11:46
 > To: Jokiniemi Kalle (Nokia-MS/Tampere)
 > Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org; balbi@ti.com;
 > tony@atomide.com; jhnikula@gmail.com; Koskinen Ilkka (Nokia-MS/Tampere)
 > Subject: Re: [PATCH 0/2] USB: twl4030-usb: fix isp1707 xceiver powering
 > 
 > Hi Kalle,
 > 
 > Missed the cover letter so I already commented the patches.
 > 
 > On Mon, Mar 21, 2011 at 03:50:18PM +0200, Kalle Jokiniemi wrote:
 > > These two patches introduce phy_power calls form board files
 > > to twl4030-usb. This fixes a problem in Nokia N900, where the
 > > ISP1707 serial tranceiver did not get disabled during phy
 > > power down.
 > >
 > > Based on patches used on n900 maemo kernel, mainly from Heikki
 > > Krogerus. Comments&testing appreciated.
 > >
 > > Basic test done on MeeGo + linux usb that the ISP powering
 > > happens correctly. Also simple data transfer tests done with
 > > backported patches on MeeGo n900 kernel.
 > >
 > > Cross posting to linux-omap, but I propose that we'd push these
 > > to linux-usb. Patches based on linux-usb master.
 > >
 > > Kalle Jokiniemi (2):
 > >   USB: twl4030-usb: do board specific phy_power up/down
 > >   OMAP3: rx51: specify phy_power for usb tranceiver
 > >
 > >  arch/arm/mach-omap2/board-rx51-peripherals.c |   32
 > ++++++++++++++++++++++++++
 > >  drivers/usb/otg/twl4030-usb.c                |    9 ++++++-
 > >  2 files changed, 40 insertions(+), 1 deletions(-)
 > 
 > I do like the idea of getting the support for power down mode of
 > isp1707 in RX51 but...
 > 
 > If I understood correctly, meego has the isp1704_charger driver from
 > mainline, so we don't need to involve twl4030-usb when powering the
 > isp1707 like we did in maemo kernel.

Thanks for all the comments. I'll rework the driver to use the isp charger driver instead.

- Kalle



 > 
 > --
 > heikki
