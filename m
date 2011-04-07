From: "Avinash.H.M." <avinashhm@ti.com>
Subject: Re: [PATCH 1/2 v2] OMAP2/3: hwmod: fix the i2c-reset timeout
 during bootup
Date: Thu, 7 Apr 2011 12:33:10 +0530
Message-ID: <20110407070310.GA21701@avinash-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:53802 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752201Ab1DGHDY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Apr 2011 03:03:24 -0400
Received: by mail-gy0-f179.google.com with SMTP id 8so999914gyg.38
        for <linux-omap@vger.kernel.org>; Thu, 07 Apr 2011 00:03:23 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

Date: Thu, 7 Apr 2011 12:12:37 +0530
From: "Mahadeva, Avinash" <avinashhm@ti.com>
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>,
	Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 1/2 v2] OMAP2/3: hwmod: fix the i2c-reset timeout during bootup

On Tue, Apr 5, 2011 at 11:57 PM, Kevin Hilman <khilman@ti.com> wrote:

> "Avinash.H.M" <avinashhm@ti.com> writes:
>
> > The i2c module has a special reset sequence. The sequence is
> > - Disable the I2C.
> > - Write to SOFTRESET bit.
> > - Enable the I2C.
> > - Poll on the RESETDONE bit.
> > This sequence must be followed for i2c reset in omap2, omap3. The
> sequence is
> > implemented as a function and the i2c_class is updated with the correct
> > 'reset' pointer.
> >
> > Cc: Rajendra Nayak <rnayak@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Signed-off-by: Avinash.H.M <avinashhm@ti.com>
>
> [...]
>
> > +
> > +/**
> > + * omap_i2c_reset- reset the omap i2c module.
> > + * @oh: struct omap_hwmod *
> > + *
> > + * The i2c moudle in omap2, omap3 had a special sequence to reset. The
> > + * sequence is:
> > + * - Disable the I2C.
> > + * - Write to SOFTRESET bit.
> > + * - Enable the I2C.
> > + * - Poll on the RESETDONE bit.
> > + * The sequence is implemented in below function. This is called for
> 2420,
> > + * 2430 and omap3.
> > + */
> > +int omap_i2c_reset(struct omap_hwmod *oh)
> > +{
> > +     u32 v;
> > +     int c = 0;
> > +
> > +     /* Disable I2C */
> > +     v = omap_hwmod_read(oh, I2C_CON_OFFSET);
> > +     v = v & ~I2C_EN;
> > +     omap_hwmod_write(v, oh, I2C_CON_OFFSET);
> > +
> > +     /* Write to the SOFTRESET bit */
> > +     v = oh->_sysc_cache;
> > +     v |= (0x1 << oh->class->sysc->sysc_fields->srst_shift);
> > +
> > +     oh->_sysc_cache = v;
> > +     omap_hwmod_write(v, oh, oh->class->sysc->sysc_offs);
>
> Direct SYSCONFIG access isn't right here.   This should go through
> omap_hwmod.
>
> What is probably needed is exposing _ocp_softreset to device code
> via something like omap_hwmod_ocp_softreset() and calling that here.
>
>

* Sorry, somehow the mail bounced from l-o. Resending it agian. *

Hi Kevin ,

thanks for the review.

OK. I ll create a wrapper function ' omap_hwmod_ocp_softreset'
around '_ocp_softreset' and call it here .

b r ,
- avinash.



> Kevin
>

