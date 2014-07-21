From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 4/7] ARM: OMAP4+: PRM: register interrupt information
 from DT
Date: Mon, 21 Jul 2014 04:28:07 -0700
Message-ID: <20140721112807.GA18374@atomide.com>
References: <1402025761-16831-1-git-send-email-nm@ti.com>
 <1402025761-16831-5-git-send-email-nm@ti.com>
 <20140721105149.GU18374@atomide.com>
 <CAGo_u6q2NOxWVG3LOfAyk8qLZss5N6MxCvYkf-yN8c4ec4mftw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50584 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697AbaGUL3c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jul 2014 07:29:32 -0400
Content-Disposition: inline
In-Reply-To: <CAGo_u6q2NOxWVG3LOfAyk8qLZss5N6MxCvYkf-yN8c4ec4mftw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: dt list <devicetree@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Nishanth Menon <nm@ti.com> [140721 04:24]:
> On Mon, Jul 21, 2014 at 5:51 AM, Tony Lindgren <tony@atomide.com> wrote:
> >
> >> +static struct of_device_id omap_prm_dt_match_table[] = {
> >> +     { .compatible = "ti,omap4-prm" },
> >> +     { .compatible = "ti,omap5-prm" },
> >> +     { .compatible = "ti,dra7-prm" },
> >> +     { }
> >> +};
> >> +
> >
> > I'd like to avoid adding more driver like stuff to mach-omap2
> > and parsing compatible flags and dealing with interupts sounds
> > very driver like.. But maybe just the handling can be moved
> > out?
> 
> I understand your view, but, Handling of interrupts is already in
> place even now in mach-omap2. Currently the prm devices are handled by
> mach-omap2 and all this does it to prevent hardcoding of irq numbers
> within the current code.

Yeah but at a cost of no dev entry, no probe etc. I'd rather keep
that SoC specific data around until a driver can deal with it
in a standard way.

> > Would a simple driver be doable that parses the compatible
> > flags, takes care of the IRQ chaining, and gets some SoC specific
> > function pointers as auxdata?
> 
> Tero has been trying to move PRM/CM stuff to a separate drivers of
> thier own. With that there wont be a need for auxdata even. - this
> current logic will get merged with that driver - if and when that is
> ready. I am not actually adding any driver logic here - just reusing
> the logic and providing glue for using dt description instead of
> hardcoded logic that the current mach-omap2 driver does.

Well how about let's just leave out the non-standard parts for
now, then once the PRM/CM driver can deal with, it can do things
in a normal way?

Regards,

Tony
