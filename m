From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 9/9] OMAP:GPIO: Implement GPIO as a platform device
Date: Wed, 5 May 2010 15:37:38 -0700
Message-ID: <20100505223738.GH29604@atomide.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02C52D12CB@dbde02.ent.ti.com>
 <877hni5akk.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49578 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754768Ab0EEWhn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 18:37:43 -0400
Content-Disposition: inline
In-Reply-To: <877hni5akk.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>

* Kevin Hilman <khilman@deeprootsystems.com> [100505 13:54]:
> "Varadarajan, Charulatha" <charu@ti.com> writes:
> 
> >> -----Original Message-----
> >> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> >
> > 2. omap_init_irq() needs to be completed before calling early_gpio_init().
> > So, if early_gpio_init() is called from omap2_init_common_hw(), we need to
> > have omap_init_irq() called before omap2_init_common_hw(). But Tony
> > objected this approach mentioning that board might not boot up as
> > omap2_init_common_hw() has to be done asap.
> >
> > That's why, I had not moved the omap_gpio_init() usage from board files.
> 
> OK... for now.  I'd still like to see GPIO init consolidated as there's
> no (good) reason why every board file has to init GPIOs when it's common
> for all SoCs, but this doesn't necessarily have to be done in your series.
> Although, if you do it for OMAP1 (as proposed below) you should do similar
> for OMAP2+.

Let's try to use just arch/subsys_initcall for starting the GPIO. AFAIK
we don't need it earlier than that. See also my comments to the patch 5/9.

Regards,

Tony
 
