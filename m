From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RFC 2/3] ARM: dts: omap4 clock data
Date: Tue, 4 Jun 2013 12:37:45 -0700
Message-ID: <20130604193744.GP3331@atomide.com>
References: <1370327958-19776-1-git-send-email-mturquette@linaro.org>
 <1370327958-19776-3-git-send-email-mturquette@linaro.org>
 <20130604145543.GK3331@atomide.com>
 <20130604183449.10233.48956@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:38039 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab3FDThv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jun 2013 15:37:51 -0400
Content-Disposition: inline
In-Reply-To: <20130604183449.10233.48956@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Tero Kristo <t-kristo@ti.com>, Rajendra <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>, Joel A Fernandes <joelagnel@ti.com>, Paul Walmsley <paul@pwsan.com>

* Mike Turquette <mturquette@linaro.org> [130604 11:40]:
> Quoting Tony Lindgren (2013-06-04 07:55:43)
> > * Mike Turquette <mturquette@linaro.org> [130603 23:45]:
> > > This is a first pass at creating a unique node for each clock in the
> > > OMAP4 power, reset and & clock manager (PRCM).  So far I have only
> > > converted mux clocks & fixed-rate clocks, which coexist with the current
> > > clock data in the kernel.  The rest needs to be done but better to
> > > publish early and often to see what others think of this approach.
> > 
> > > +/* FIXME need to print the address directly */
> > > +/*
> > > +#include "../../mach-omap2/prm44xx.h"
> > > +#include "../../mach-omap2/cm2_44xx.h"
> > > +#include "../../mach-omap2/cm1_44xx.h"
> > > +*/
> > 
> > I don't think you're using the above includes any longer
> > in this file?
> > 
> 
> Correct.  I actually spotted this before emailing the patches out at
> midnight, but by then I didn't care to fix it.  The benefits of marking
> a patch as "RFC" ;-)

:)
 
> I had a mind to use the new preprocessor capabilities of dtc for the
> PRCM bit masks and shift values, but instead I ended up using the raw
> hex values.  I've actually come to prefer using the raw hex values for
> DT, which I think makes more sense for a description of the hardware
> which is not tied to any Linux implementation.

Agreed, especially if the value is only used once.

Regards,

Tony
