From: Tony Lindgren <tony@atomide.com>
Subject: Re: i2c issue on Panda with DT boot, v3.10-rc4
Date: Fri, 7 Jun 2013 11:36:29 -0700
Message-ID: <20130607183628.GD3331@atomide.com>
References: <51B1C9D2.6060703@ti.com>
 <51B1D3D6.2020803@ti.com>
 <51B1D654.9070107@ti.com>
 <20130607175705.GC3331@atomide.com>
 <42EC710806A55841BBE342FAEBBEF172D26A1F@DNCE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:60692 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755813Ab3FGSgb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 14:36:31 -0400
Content-Disposition: inline
In-Reply-To: <42EC710806A55841BBE342FAEBBEF172D26A1F@DNCE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "Strashko, Grygorii" <grygorii.strashko@ti.com>, linux-omap <linux-omap@vger.kernel.org>

* Valkeinen, Tomi <tomi.valkeinen@ti.com> [130607 11:37]:
> Tony Lindgren [tony@atomide.com]:
> 
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [130607 05:53]:
> 
> > > With that one, I don't get timeouts, but it still doesn't work (i.e.
> > > behavior is the same as on -rc1).
> > >
> > > When I run i2cdump the first time, I see that it (probably) manages to
> > > read the first byte, as that's "00". Everything after that are 'XX'es.
> >
> > Hmm I suggest git bisect, I'm pretty sure I was using my panda es
> > with my omap4 DT conversion patches against v3.10-rc1.
> 
> As I mentioned, it doesn't work on v3.10-rc1 either. Note that DVI output
> itself works fine, it's the EDID read that fails. So if you force the
> videomode, you won't notice anything.

OK, that's probably I had it working.
 
> I didn't try with v3.9 (does DT boot work on that one?), though. So I don't
> know if reading EDID has ever worked with DT boot.

Yes but requires several fixes. Without fixes, v3.10-rc4 is your
best bet. Of course that won't help much with git bisect.

Maybe check that the i2c related pins are muxed properly for your board
with pinctrl-single?

Regards,

Tony

