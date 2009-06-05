From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 00/07] pm: remove late/early platform driver pm callbacks
Date: Fri, 5 Jun 2009 21:10:58 +0200
Message-ID: <200906052110.59209.rjw@sisk.pl>
References: <20090605075436.14756.80501.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54257 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876AbZFETK7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Jun 2009 15:10:59 -0400
In-Reply-To: <20090605075436.14756.80501.sendpatchset@rx1.opensource.se>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, pavel@ucw.cz, hskinnemoen@atmel.com, anemo@mba.ocn.ne.jp, gregkh@suse.de, stern@rowland.harvard.edu, ben-linux@fluff.org, felipe.balbi@nokia.com, linux-omap@vger.kernel.org

On Friday 05 June 2009, Magnus Damm wrote:
> pm: remove late/early platform driver pm callbacks
> 
> [PATCH 01/07] arm: rework omap suspend_late()/resume_early()
> [PATCH 02/07] dma: rework dw_dmac suspend_late()/resume_early()
> [PATCH 03/07] dma: rework txx9dmac suspend_late()/resume_early()
> [PATCH 04/07] i2c: rework i2c-pxa suspend_late()/resume_early()
> [PATCH 05/07] i2c: rework i2c-s3c2410 suspend_late()/resume()
> [PATCH 06/07] usb: rework musb suspend()/resume_early()
> [PATCH 07/07] pm: remove platform device suspend_late()/resume_early()
> 
> These patches simply remove ->suspend_late() and ->resume_early()
> from struct platform_driver. Drivers are converted to dev_pm_ops
> with CONFIG_SUSPEND in mind. Untested.
> 
> All patches except [02/07] are known to compile.

I think the last patch will need to be rebased on top of linux-next, but rather
trivially.

I like the series, but I think it needs some more exposure.

Care to repost with a CC to the LKML and usb-devel?

Best,
Rafael


> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  arch/arm/plat-omap/debug-leds.c  |   11 +++++++----
>  arch/arm/plat-omap/gpio.c        |   14 ++++++++++----
>  drivers/base/platform.c          |   36 ------------------------------------
>  drivers/dma/dw_dmac.c            |   15 ++++++++++-----
>  drivers/dma/txx9dmac.c           |   15 ++++++++++-----
>  drivers/i2c/busses/i2c-pxa.c     |   25 +++++++++++++++++--------
>  drivers/i2c/busses/i2c-s3c2410.c |   28 +++++++++++++++++-----------
>  drivers/usb/musb/musb_core.c     |   18 ++++++++++++------
>  include/linux/platform_device.h  |    2 --
>  9 files changed, 83 insertions(+), 81 deletions(-)
