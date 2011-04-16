From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/2 v2] OMAP2/3: hwmod: fix the i2c-reset timeout
 during bootup
Date: Sat, 16 Apr 2011 09:42:23 -0700
Message-ID: <1302972143.2719.22.camel@vence>
References: <20110407070310.GA21701@avinash-laptop>
	 <20110411131154.GA4498@avinash-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:45511 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759197Ab1DPWYL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 16 Apr 2011 18:24:11 -0400
Received: by pwj9 with SMTP id 9so2384809pwj.34
        for <linux-omap@vger.kernel.org>; Sat, 16 Apr 2011 15:24:09 -0700 (PDT)
In-Reply-To: <20110411131154.GA4498@avinash-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Avinash.H.M." <avinashhm@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

On Mon, 2011-04-11 at 18:41 +0530, Avinash.H.M. wrote:
> > > > +     oh->_sysc_cache = v;
> > > > +     omap_hwmod_write(v, oh, oh->class->sysc->sysc_offs);
> > >
> > > Direct SYSCONFIG access isn't right here.   This should go through
> > > omap_hwmod.
> > >
> > > What is probably needed is exposing _ocp_softreset to device code
> > > via something like omap_hwmod_ocp_softreset() and calling that here.
> > >
> 
> Hi Kevin , 
> 
> Looking more closely, i realised that, the sequence of _ocp_softreset
> doesn't work for I2C. It has a special programming sequence which needs
> to be followed to reset the IP. That was the reason, we created
> omap_i2c_reset.  So i feel we need not expose _ocp_softreset.
> 
> Since, the problem here is accessing the SYSCONFIG here, instead, what i
> can do is, something like below.
> 
> 	omap_hwmod_softreset(struct omap_hwmod *oh)
> 	{
> 
> 		v = oh->_sysc_cache;
> 		v |= (0x1 << oh->class->sysc->sysc_fields->srst_shift);
> 
> 		oh->_sysc_cache = v;
> 		omap_hwmod_write(v, oh, oh->class->sysc->sysc_offs);
> 
> 	}
> 
> And then call this in omap_i2c_reset. Is this OK ?

Yes, sounds reasonable.

Please be sure to describe the reasoning above in the changelog as well.

Thanks,

Kevin


