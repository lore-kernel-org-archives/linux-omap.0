From: Heikki Krogerus <heikki.krogerus@nokia.com>
Subject: Re: [patch-v2.6.39 12/12] usb: otg: notifier: switch to atomic
 notifier
Date: Fri, 25 Feb 2011 12:46:53 +0200
Message-ID: <20110225104653.GA30637@esdhcp034230>
References: <1297946329-9353-1-git-send-email-balbi@ti.com>
 <1297946329-9353-13-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:21905 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754990Ab1BYKrV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 05:47:21 -0500
Content-Disposition: inline
In-Reply-To: <1297946329-9353-13-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Balbi <balbi@ti.com>
Cc: Greg KH <greg@kroah.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi Felipe,

On Thu, Feb 17, 2011 at 02:38:49PM +0200, ext Felipe Balbi wrote:
> most of our notifications, will be called from IRQ
> context, so an atomic notifier suits the job better.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/usb/otg/ab8500-usb.c    |    6 +++---
>  drivers/usb/otg/nop-usb-xceiv.c |    2 +-
>  drivers/usb/otg/twl4030-usb.c   |    6 +++---
>  drivers/usb/otg/twl6030-usb.c   |    8 ++++----
>  include/linux/usb/otg.h         |    6 +++---
>  5 files changed, 14 insertions(+), 14 deletions(-)

You should fix drivers/usb/otg/ab8500-usb.c as well. Also,
drivers/power/twl4030_charger.c will need to be made atomic notifier
safe.

-- 
heikki
