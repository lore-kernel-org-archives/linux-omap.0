From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 0/6] ARM: l2x0: kexex, cleanup and optimisation
Date: Wed, 8 Sep 2010 20:59:13 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD0D34A0@dbde02.ent.ti.com>
References: <1283846243-11600-1-git-send-email-santosh.shilimkar@ti.com>
	 <AANLkTi=chtedwbDDJnZOe5yTqobUeXz=aZYUNNUDpQQm@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02CD0D30A5@dbde02.ent.ti.com>
	 <1283958089.10137.55.camel@e102109-lin.cambridge.arm.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02CD0D348E@dbde02.ent.ti.com>
 <1283959543.10137.65.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42424 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755279Ab0IHP3u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Sep 2010 11:29:50 -0400
In-Reply-To: <1283959543.10137.65.camel@e102109-lin.cambridge.arm.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "per.xx.fransson@stericsson.com" <per.xx.fransson@stericsson.com>

> -----Original Message-----
> From: Catalin Marinas [mailto:catalin.marinas@arm.com]
> Sent: Wednesday, September 08, 2010 8:56 PM
> To: Shilimkar, Santosh
> Cc: Linus Walleij; linux-arm-kernel@lists.infradead.org;
> tglx@linutronix.de; linux-omap@vger.kernel.org;
> per.xx.fransson@stericsson.com
> Subject: RE: [PATCH 0/6] ARM: l2x0: kexex, cleanup and optimisation
> 
> On Wed, 2010-09-08 at 16:09 +0100, Shilimkar, Santosh wrote:
> > > On Wed, 2010-09-08 at 08:34 +0100, Shilimkar, Santosh wrote:
> > > > > Can you also include the patch by Per Fransson I sent off to
> > > > > Thomas and the list just a few days ago with the subject
> > > > > "[PATCH] ARM: ux500 specific L2 cache code"
> > > > > in this patch series?
> > > >
> > > > Basically I plan to push all these patches to
> > > > RMK's patch system after getting his OK. I can push
> > > > your patch along with that.
> > > >
> > > > Is that ok with you ?
> > >
> > > Or rather a pull request. AFAIK (unless this was fixed recently) the
> > > patch system doesn't handle the "From: " line to set the correct patch
> > > author.
> > >
> > Oh Yes... pull request-is also doable... I have all these patches pilled
> up
> > here already ...
> > http://dev.omapzoom.org/?p=santosh/kernel-omap4-
> base.git;a=shortlog;h=refs/heads/l2x0-for-rmk
> 
> Well, regarding my patches, I'm only OK for you to submit the
> cache-l2x0.c one named:
> 
> "ARM: Improve the L2 cache performance when PL310 is used"
> 
> The other patches I'll push separately.
> 
Sure. 

