From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/8] ARM: DRA7: id: Add cpu detection support for
 DRA7xx based SoCs'
Date: Tue, 30 Jul 2013 06:55:27 -0700
Message-ID: <20130730135527.GM7656@atomide.com>
References: <1375183546-12758-1-git-send-email-rnayak@ti.com>
 <1375183546-12758-2-git-send-email-rnayak@ti.com>
 <20130730131009.GA28162@radagast>
 <20130730131837.GB28162@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49668 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951Ab3G3Nzc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Jul 2013 09:55:32 -0400
Content-Disposition: inline
In-Reply-To: <20130730131837.GB28162@radagast>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, khilman@linaro.org, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com, sourav.poddar@ti.com

* Felipe Balbi <balbi@ti.com> [130730 06:25]:
> On Tue, Jul 30, 2013 at 04:10:09PM +0300, Felipe Balbi wrote:
> > Hi,
> > 
> > On Tue, Jul 30, 2013 at 04:55:39PM +0530, Rajendra Nayak wrote:
> > > @@ -379,6 +407,13 @@ IS_OMAP_TYPE(3430, 0x3430)
> > >  # define soc_is_omap543x()		is_omap543x()
> > >  #endif
> > >  
> > > +# if defined(CONFIG_SOC_DRA7XX)
> > > +# undef soc_is_dra7xx
> > > +# undef soc_is_dra75x
> > > +# define soc_is_dra7xx()		is_dra7xx()
> > > +# define soc_is_dra75x()		is_dra75x()
> > 
> > since this platform is DT-only, couldn't we just believe DT-data to be
> > correct of_machine_is_compatible() ? 2/3 of this patch would be removed.
> 
> s/correct of_/correct and use of_

Makes sense to me. AFAIK we no longer need to initialize much
anything super early.

Regards,

Tony
