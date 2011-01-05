From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap4: panda: remove usb_nop_xceiv_register
Date: Wed, 5 Jan 2011 16:10:35 +0200
Message-ID: <20110105141035.GD2304@legolas.emea.dhcp.ti.com>
References: <1294148397-26582-1-git-send-email-tom.leiming@gmail.com>
 <87ipy442i7.fsf@ti.com>
 <20110105065643.GE2458@legolas.emea.dhcp.ti.com>
 <AANLkTik3Mw3fTZ6TPv4aiiWet-dARVQOLtUv_DAMqoNo@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:44460 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750953Ab1AEOKk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 09:10:40 -0500
Received: by mail-ey0-f173.google.com with SMTP id 7so4014776eyg.4
        for <linux-omap@vger.kernel.org>; Wed, 05 Jan 2011 06:10:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTik3Mw3fTZ6TPv4aiiWet-dARVQOLtUv_DAMqoNo@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: balbi@ti.com, Kevin Hilman <khilman@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org

Hi,

On Wed, Jan 05, 2011 at 09:40:19PM +0800, Ming Lei wrote:
> > Reviewed-by: Felipe Balbi <balbi@ti.com>
> >
> > This is ok, but can only go after 2.6.38 merge window. There are patches
> > to add support for internal PHY. Ideally we would actually register both
> > PHYs and it would work. They would have different capabilities, though.
> 
> The current otg only supports one global transceiver, so we have to remove
> the nop on Panda.

Yes, of course. I just pointed out your commit log is wrong and that
ideally we would fix this limitation. Ideally we would we have some sort
of framework for transceivers where we could add several of them.

-- 
balbi
