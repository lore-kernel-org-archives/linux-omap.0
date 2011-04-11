From: "Avinash.H.M." <avinashhm@ti.com>
Subject: Re: [PATCH 1/2 v2] OMAP2/3: hwmod: fix the i2c-reset timeout
 during bootup
Date: Mon, 11 Apr 2011 18:41:54 +0530
Message-ID: <20110411131154.GA4498@avinash-laptop>
References: <20110407070310.GA21701@avinash-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:59944 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751673Ab1DKNMS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Apr 2011 09:12:18 -0400
Received: by mail-gw0-f52.google.com with SMTP id 15so2298950gwj.39
        for <linux-omap@vger.kernel.org>; Mon, 11 Apr 2011 06:12:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110407070310.GA21701@avinash-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cous>

> > > +     oh->_sysc_cache = v;
> > > +     omap_hwmod_write(v, oh, oh->class->sysc->sysc_offs);
> >
> > Direct SYSCONFIG access isn't right here.   This should go through
> > omap_hwmod.
> >
> > What is probably needed is exposing _ocp_softreset to device code
> > via something like omap_hwmod_ocp_softreset() and calling that here.
> >

Hi Kevin , 

Looking more closely, i realised that, the sequence of _ocp_softreset
doesn't work for I2C. It has a special programming sequence which needs
to be followed to reset the IP. That was the reason, we created
omap_i2c_reset.  So i feel we need not expose _ocp_softreset.

Since, the problem here is accessing the SYSCONFIG here, instead, what i
can do is, something like below.

	omap_hwmod_softreset(struct omap_hwmod *oh)
	{

		v = oh->_sysc_cache;
		v |= (0x1 << oh->class->sysc->sysc_fields->srst_shift);

		oh->_sysc_cache = v;
		omap_hwmod_write(v, oh, oh->class->sysc->sysc_offs);

	}

And then call this in omap_i2c_reset. Is this OK ?


- Avinash



