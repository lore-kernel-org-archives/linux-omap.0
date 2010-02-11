From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/2] ARM : OMAP : Remove #ifdef from board-omap3evm.c
Date: Wed, 10 Feb 2010 16:17:57 -0800
Message-ID: <20100211001756.GZ21755@atomide.com>
References: <1262681372-7602-1-git-send-email-x0082077@ti.com>
 <20100105105604.GE11291@nokia.com>
 <20100115185801.GH12146@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61030 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756774Ab0BKARZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 19:17:25 -0500
Content-Disposition: inline
In-Reply-To: <20100115185801.GH12146@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, ext Maulik Mankad <x0082077@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, Olof Johansson <olof@lixom.net>

* Greg KH <greg@kroah.com> [100115 12:14]:
> On Tue, Jan 05, 2010 at 12:56:04PM +0200, Felipe Balbi wrote:
> > On Tue, Jan 05, 2010 at 09:49:32AM +0100, ext Maulik Mankad wrote:
> > >ARM : OMAP : Remove #ifdef from board-omap3evm.c
> > >
> > >Remove #ifdef around usb_nop_xceiv_register() from
> > >board-omap3evm.c
> > >
> > >Signed-off-by: Maulik Mankad <x0082077@ti.com>
> > >Cc: Tony Lindgren <tony@atomide.com>
> > 
> > Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
> > 
> > Tony, let's wait for Greg's Ack to the previous patch, but if everything 
> > is Fine, you can take this one on for-next.
> 
> I can take it as I took the one that this depended on.
> 
> Or both can go through Tony's tree, I don't care :)
> 
> If so, please add:
> 	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> to the patches.

Just to follow up on this, I've added both patches to omap
for-next queue. Compiles fine now, will also check compile
for x86.

Regards,

Tony
