From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 00/18] OMAP4: PM data big spring cleanup and fixes
Date: Thu, 7 Jul 2011 15:10:42 +0300
Message-ID: <20110707121040.GF15815@atomide.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
 <alpine.DEB.2.00.1107060017480.4217@utopia.booyaka.com>
 <4E14B820.6070202@ti.com>
 <20110707055549.GC15815@atomide.com>
 <E9AF1FACCF71F448B55E58D9AED1B0F40E626BEE32@staex7mb2.telecom.sna.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:64834 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755675Ab1GGMKu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 08:10:50 -0400
Content-Disposition: inline
In-Reply-To: <E9AF1FACCF71F448B55E58D9AED1B0F40E626BEE32@staex7mb2.telecom.sna.samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Martin Fouts <mfouts@sta.samsung.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Martin Fouts <mfouts@sta.samsung.com> [110707 10:20]:
> > Do we really need to do that patching right now to add base 4460 support?
> 
> It should be done sometime, but I see no need for it to be right now.
> 
> > If we're just doing a bunch of renames all over the place to add support
> > for a new processor variant, something is wrong. This is exactly the kind
> > of "crazy churn" Linus was complaining about. In this case the crazy churn
> > is "let's rename 4430 to 44XX all over the place".
> 
> To me, this is not 'crazy churn', but rather, correcting an earlier oversight. I did not understand Linus to say "never fix a naming oversight", but "don't change names without a good reason."

I think this is crazy churn. It does not fix the problem we have, which
is "how can we support lots of SoCs in a sane way". It just postpones
fixing the problem until the next SoC variant comes around. And now
we already have the exact same problem with both the am3505 support
and 4460 support.

The second problem we have here is "why does adding 4460 support depend
on a cosmetic clean-up patch". That dependency should not exist at all
as it seems the 4460 patches should work even without this patch.
 
> > To me it's sane to assume that we can have most of 4430 features on 4460
> > and don't need to rename 4430 to 44XX for that. Adding 4460 should be
> > just add few new 4460 defines, then do an arch_initcall to fixup things
> > between 4430 and 4460.
> 
> This is a topic upon which mileage varies.  My experience has made we wary of making such assumptions, because too often they have turned out to be wrong.  It is much better to make it clear that the same code supports both than to leave people guessing.  Saying so in the filename is useful. It is also consistent with the naming scheme used in much of the kernel.
> 
> I don't feel a sense of urgency to correct this, nor a need to hit a merge window, but from my mileage, I would prefer that it be corrected within a reasonable time frame.
> 
> It seems to me that there is also a bullet to bite here. To achieve the sort of rationalization across the arm architecture that is envisioned, inconsistencies in naming styles between platforms will have to be reconciled and resolved, lest the habit continue.

Sure things should be fixed, but things should be fixed properly. Here
we are repeating the CHIP_IS flag in hundreds of places where it really
should be only checked once after SoC is detected. And then based on
that a SoC specifc list of devices can then be initialized.

Regards,

Tony
