From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP4 Panda DVI problem
Date: Mon, 17 Jun 2013 04:35:47 -0700
Message-ID: <20130617113546.GS20992@atomide.com>
References: <51BB201C.3000605@ti.com>
 <51BEC4D7.2080903@ti.com>
 <20130617111834.GR20992@atomide.com>
 <51BEF2BF.3000104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:45921 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932390Ab3FQLft (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jun 2013 07:35:49 -0400
Content-Disposition: inline
In-Reply-To: <51BEF2BF.3000104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [130617 04:34]:
> On 17/06/13 14:18, Tony Lindgren wrote:
> 
> > You should be able to get the regulator based on the name just fine
> > from the drivers even if one driver is using DT and one is not. That is
> > as long as the regulator is defined. Then the regulator fwk will track
> > the usecount properly.
> 
> Doesn't the regulator need to be "bound" to a device for the driver to
> use the proper name for the regulator? I mean, in this case the dvi
> driver wants to get a regulator named "vdd_5v" (or something like that,
> I'm not sure what's the proper name). The USB host driver uses a name
> "vcc", while the real name of the regulator is "hsusbX_vcc".

I think that's for looking up regulators based on the dev entry, and also
name based lookup should work. But maybe I'm confusing it with the clock
framework. If you need to bind it to a device, you can do that too
dynamically I'd assume.

> If DVI driver wanted to use the regulator, it'd need to get
> "hsusbX_vcc". Which, I presume, would work, but is board specific and
> hacky, and it makes handling EPROBE_DEFER a bit more difficult.
> 
> Then again, maybe that's still simpler than making the regulator
> always-on, as there are complications with that approach also, which we
> are currently studying.
> 
> >>> So I think the simplest solution is to make DC_HST_5V always-on. This
> >>> should be fixed for 3.10 also.
> >>
> >> I am fine with this.
> > 
> > For a short term fix I'm fine with that, but please investigate using
> > the regulator, it might be simpler than you think.
> 
> I'll have a look, maybe there's something I'm missing.

Yes might be worth checking.

Regards,

Tony
