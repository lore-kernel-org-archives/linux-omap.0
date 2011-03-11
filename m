From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap2+: mux: Add macro for configuring static with
 omap_hwmod_mux_init (Re: [PATCH] omap2+: mux: Remove the use of IDLE flag)
Date: Fri, 11 Mar 2011 11:35:54 -0800
Message-ID: <20110311193554.GH10079@atomide.com>
References: <1299472552-22017-1-git-send-email-r.sricharan@ti.com>
 <20110308164033.GC26463@atomide.com>
 <b76e32aff88265d31cc1b7b2fc502a32@mail.gmail.com>
 <20110309203200.GP26463@atomide.com>
 <d613e06b28e16ab8da53af60e1e2ec56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:41958 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab1CKTf4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Mar 2011 14:35:56 -0500
Content-Disposition: inline
In-Reply-To: <d613e06b28e16ab8da53af60e1e2ec56@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, paul@pswan.com, linux-arm-kernel@lists.infradead.org

* Sricharan R <r.sricharan@ti.com> [110310 22:10]:
> Tony,
> >>Look OK to me, but let's make things a bit easier to read
> >>and maintain with the following patch. Can you please
> >>update your patches to use this macro?
> >>
> >>Each line then just becomes something like:
> >>
> >>OMAP_MUX_STATIC("uart3_tx_irtx.uart3_tx_irtx",
> >>		OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
> >>
> >Ok thanks. I will update and send again.
> 
> 4430SDP:
> http://marc.info/?l=linux-omap&m=129982347622340&w=2
> 
> omap4panda:
> http://marc.info/?l=linux-omap&m=129982347722344&w=2
> 
> 3430sdp:
> http://marc.info/?l=linux-omap&m=129982347822347&w=2
> 
> I have reworked the patches using your MACRO.
> 
> I have applied on top of the omap-for-linus branch and
> tested them on 4430sdp, 3430sdp, omap4panda.

OK thanks, applying them.

Tony
