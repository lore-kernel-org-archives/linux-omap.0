From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Resending - PATCH 1/3] Triton BCI driver board/device setup
	for OMAP3430
Date: Tue, 5 Aug 2008 16:35:51 +0300
Message-ID: <20080805133550.GJ7193@atomide.com>
References: <38309.192.168.10.89.1216727733.squirrel@dbdmail.itg.ti.com> <1473aac0380c8c62329714e83f6ca795@felipebalbi.com> <002301c8ec7f$1405df30$37f6180a@ent.ti.com> <3db54da6fc6e74db523cc8e6bd2cf69d@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60052 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754130AbYHENf5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 09:35:57 -0400
Content-Disposition: inline
In-Reply-To: <3db54da6fc6e74db523cc8e6bd2cf69d@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap@vger.kernel.org, Mikko.K.Ylinen@nokia.com

* Felipe Balbi <me@felipebalbi.com> [080723 10:32]:
> 
> 
> On Wed, 23 Jul 2008 10:16:27 +0530, "Madhusudhan Chikkature"
> <madhu.cr@ti.com> wrote:
> > Hi Felipe,
> > 
> >> Tony, weird that we still have these prototypes in these headers.
> >> Could be some merging conflict ?
> > Yes. I see that these prototypes are still present in the board3430 and
> > board2430 header files in the omap tree.
> > 
> >> Anyways, please apply the attached patch. We're using
> >> usb_musb_init() and usb_ehci_init() now.
> > You mean I should apply the attached patch you sent for local use, right?
> > And I guess I dont need to resend this perticular BCI patch, am I
> correct?
> 
> No :-)
> 
> that was to Tony. Just replied to your mail so it's easy to see why we need
> that patch :-)

Pushing these today. Do you have a patch for moving the extern
prototypes into the twl header?

Tony
