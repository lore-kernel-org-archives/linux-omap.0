From: Catalin Marinas <catalin.marinas@arm.com>
Subject: RE: [PATCH 0/6] ARM: l2x0: kexex, cleanup and optimisation
Date: Wed, 08 Sep 2010 16:25:43 +0100
Message-ID: <1283959543.10137.65.camel@e102109-lin.cambridge.arm.com>
References: <1283846243-11600-1-git-send-email-santosh.shilimkar@ti.com>
	 <AANLkTi=chtedwbDDJnZOe5yTqobUeXz=aZYUNNUDpQQm@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02CD0D30A5@dbde02.ent.ti.com>
	 <1283958089.10137.55.camel@e102109-lin.cambridge.arm.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02CD0D348E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:47562 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752126Ab0IHPZy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Sep 2010 11:25:54 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02CD0D348E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, linux-omap@vger.kernel.org, per.xx.fransson@stericsson.com

On Wed, 2010-09-08 at 16:09 +0100, Shilimkar, Santosh wrote:
> > On Wed, 2010-09-08 at 08:34 +0100, Shilimkar, Santosh wrote:
> > > > Can you also include the patch by Per Fransson I sent off to
> > > > Thomas and the list just a few days ago with the subject
> > > > "[PATCH] ARM: ux500 specific L2 cache code"
> > > > in this patch series?
> > >
> > > Basically I plan to push all these patches to
> > > RMK's patch system after getting his OK. I can push
> > > your patch along with that.
> > >
> > > Is that ok with you ?
> >
> > Or rather a pull request. AFAIK (unless this was fixed recently) the
> > patch system doesn't handle the "From: " line to set the correct patch
> > author.
> >
> Oh Yes... pull request-is also doable... I have all these patches pilled up
> here already ...
> http://dev.omapzoom.org/?p=santosh/kernel-omap4-base.git;a=shortlog;h=refs/heads/l2x0-for-rmk

Well, regarding my patches, I'm only OK for you to submit the
cache-l2x0.c one named:

"ARM: Improve the L2 cache performance when PL310 is used"

The other patches I'll push separately.

Thanks.

-- 
Catalin

