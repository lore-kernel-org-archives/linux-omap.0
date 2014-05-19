From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 06/11] ARM: OMAP2+: Fix voltage scaling init for device
 tree
Date: Mon, 19 May 2014 13:23:27 -0700
Message-ID: <20140519202327.GC11945@atomide.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
 <1397173639-29587-7-git-send-email-tony@atomide.com>
 <CAGhQ9VxS+Hg6EX=CDxbibV2TFw++LwZY+GQomZEHx--JGuWHNg@mail.gmail.com>
 <20140519180104.GL4849@atomide.com>
 <CAGo_u6oGHFAFimYSc8Utgbp=oCahXzO0ZoYjhFgOkT3YkppS6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:31535 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932836AbaESUXe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 16:23:34 -0400
Content-Disposition: inline
In-Reply-To: <CAGo_u6oGHFAFimYSc8Utgbp=oCahXzO0ZoYjhFgOkT3YkppS6A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Joachim Eastwood <manabian@gmail.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Tero Kristo <t-kristo@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Nishanth Menon <nm@ti.com> [140519 11:33]:
> On Mon, May 19, 2014 at 1:01 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Joachim Eastwood <manabian@gmail.com> [140519 10:51]:
> >>
> >> As far as I understand the setup above is only valid for 4430 and not
> >> 4460 since it is hook up to the twl in diffent way. External switcher
> >> (TPS62361) for mpu rail and the other rails are used differently.
> >
> > Hmm interesting, I think we had this enabled with legacy booting?
> >
> >> I also get the following messages on boot now:
> >> [ 2.458740] twl: not initialized
> >> [ 2.462127] twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for
> >> 1375000 Vs max 1316660
> >> [ 2.470581] twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for
> >> 1375000 Vs max 1316660
> >> [ 2.479003] twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for
> >> 1375000 Vs max 1316660
> >> [ 2.487457] twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for
> >> 1375000 Vs max 1316660
> >> [ 2.495880] twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for
> >> 1375000 Vs max 1316660
> >> [ 2.504302] twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for
> >> 1375000 Vs max 1316660
> >> [ 2.512725] twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for
> >> 1410000 Vs max 1316660
> >> [ 2.521179] omap2_set_init_voltage: unable to find boot up OPP for vdd_mpu
> >> [ 2.528411] omap2_set_init_voltage: unable to set vdd_mpu
> >> [ 2.534088] omap2_set_init_voltage: unable to find boot up OPP for vdd_core
> >> [ 2.541412] omap2_set_init_voltage: unable to set vdd_core
> >> [ 2.547210] omap2_set_init_voltage: unable to find boot up OPP for vdd_iva
> >> [ 2.554443] omap2_set_init_voltage: unable to set vdd_iva
> >>
> >> It doesn't seem too happy on my 4460.
> >
> > Indeed, we need to fix it. Nishant, any comments on how we should
> > deal with this one?
> 
> we can add TPS data here for 4460 mpu (panda-ES) if that is
> interesting to us - given that the common voltage domain/VC/VP stuff
> so far has gone in no positive direction in our discussions last year.

Makes sense to me. That way we have things back working after all
these device tree related changes.

Regards,

Tony


