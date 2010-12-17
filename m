From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP4: Pandaboard: Fixing MMC card detect gpio line
Date: Fri, 17 Dec 2010 10:02:52 -0800
Message-ID: <20101217180251.GQ5941@atomide.com>
References: <1291723986-24658-1-git-send-email-raghuveer.murthy@ti.com>
 <4CFFB704.3030905@ti.com>
 <AANLkTim_vp6VsdZtN+3ehWuDyw2TE4+x_+f0KZ3Mn6EB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57615 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755683Ab0LQSC6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 13:02:58 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTim_vp6VsdZtN+3ehWuDyw2TE4+x_+f0KZ3Mn6EB@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: David Anders <x0132446@ti.com>, "Murthy, Raghuveer" <raghuveer.murthy@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Menon, Nishanth <nm@ti.com> [101217 09:50]:
> On Wed, Dec 8, 2010 at 10:49, David Anders <x0132446@ti.com> wrote:
> > On 12/07/2010 06:13 AM, Murthy, Raghuveer wrote:
> >>
> >> The .gpio_cd member of omap2_hsmmc_info is not initialized. This
> >> will default to zero. On Pandaboard this interferes with gpio line
> >> assigned for powering TFP410 DVI chip.
> >>
> >> This fix was missed out in the previous commit bf56f0a6668cd, from
> >> Nishanth Menon
> >>
> >> Signed-off-by: Kishore Kadiyala<kishore.kadiyala@ti.com>
> >> Signed-off-by: Raghuveer Murthy<raghuveer.murthy@ti.com>
> >> Acked-by: Nishanth Menon<nm@ti.com>
> >>
> >
> > Tested-by: David Anders <x0132446@ti.com>
> Tony,
> this is a regression introduced in my commit for .37-rc1. any chance
> of this making to one of 37 rc cycles? I can re-post this patch
> including l-a if that is the path you'd like.

Yes please, and also explain what exactly this breaks.

If it just breaks MMC card detect with some DVI chip driver that's
not merged yet, then this would be in the "it never worked before".

Tony
