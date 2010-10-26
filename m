From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] omap: add hwspinlock device
Date: Tue, 26 Oct 2010 12:06:46 -0700
Message-ID: <20101026190645.GH3012@atomide.com>
References: <87r5fmxghm.fsf@deeprootsystems.com>
 <AANLkTinZ2+ocJCfUpT15Ow3J9XBa-8XWnVC3gDDJ7s-v@mail.gmail.com>
 <87bp6pviwf.fsf@deeprootsystems.com>
 <AANLkTikE1dCXW-7ScVoDgEK3sxai_TyFzstSG+zvNm2F@mail.gmail.com>
 <8739s0sobc.fsf@deeprootsystems.com>
 <AANLkTikdjtYtzhgM_=io3SFdUZq=8Xcc8n24bW=SFgTA@mail.gmail.com>
 <20101022165612.GF9149@atomide.com>
 <AANLkTimysu4L+ecFvpGAQ0bj3fhLQC1cveWddFNNp=JQ@mail.gmail.com>
 <20101025190221.GC7206@atomide.com>
 <AANLkTimkUDwAn-+gmNKMkXY0Uw8evt1_W2saeRKY-Xbd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61116 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756909Ab0JZTGx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Oct 2010 15:06:53 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimkUDwAn-+gmNKMkXY0Uw8evt1_W2saeRKY-Xbd@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Balaji T K <balajitk@ti.com>, "Kamat, Nishant" <nskamat@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Greg KH <greg@kroah.com>, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>

* Ohad Ben-Cohen <ohad@wizery.com> [101026 04:45]:
> On Mon, Oct 25, 2010 at 9:02 PM, Tony Lindgren <tony@atomide.com> wrote:
> >> if you feel that (2) is justifiable/desirable, I would be more
> >> than happy to submit that version.
> >
> > Yes (2) please. I would assume there will be more use of this. And then
> > we (or probably me again!) don't have to deal with cleaning up the drivers
> > again in the future.
> 
> Sounds good.
> 
> >> Or do you mean a variation of (2) with only the specific locking bits
> >> coming from pdata func pointers ? I guess that in this case we just
> >> might as well go with the full (2).
> >
> > Yes variation of (2) where you only pass the locking function via
> > platform data would be best.
> 
> It feels a bit funky to me because we would still have code that is
> omap-specific inside the "common" probe()/remove() calls.
> 
> I suggest to move everything that is omap-specific to a small omap
> module that, once probed, would register itself with the common
> hwspinlock framework (after initializing its hardware).
> 
> That small platfom-specific module probably doesn't have to sit in the
> arch/ folder; we can follow established conventions like
> mmc/i2c/gpio/spi/etc..
> 
> With that in hand, the hwspinlock would really be hardware-agnostic,
> and then applying s/omap_hwspin/hwspin/ would be justified.
> 
> Does this sound reasonable to you ?

Sounds good to me.

Tony
