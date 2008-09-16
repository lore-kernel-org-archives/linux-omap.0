From: David Brownell <david-b@pacbell.net>
Subject: Re: [rfc] [patch] clean up to ehci-omap (Was: Re: [patch] omap: usb: ehci: fix use of hcd->regs)
Date: Mon, 15 Sep 2008 23:35:48 -0700
Message-ID: <200809152335.48966.david-b@pacbell.net>
References: <20080912121024.GG759@gandalf.research.nokia.com> <200809152248.19959.david-b@pacbell.net> <5A47E75E594F054BAF48C5E4FC4B92AB02C4347F19@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:37204 "HELO
	smtp113.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750990AbYIPGfv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Sep 2008 02:35:51 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02C4347F19@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, Tony Lindgren <tony@atomide.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Monday 15 September 2008, Gadiyar, Anand wrote:
> > 
> > ... yes, but also move all the pinmuxing to arch/arm/plat-omap/something
> > 
> 
> Pin-muxing is done in the board file. Is there a problem with that?

Sorry, I was too loose.  I meant "pin setup", which is a superset
of pin muxing.  The functions in the second patch should be wrapped
up in board-specific code.


