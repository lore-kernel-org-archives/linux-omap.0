From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [BISECTED] 3.10-rc1 OMAP1 GPIO IRQ regression
Date: Mon, 24 Jun 2013 02:43:26 +0300
Message-ID: <20130623234326.GA20703@blackmetal.musicnaut.iki.fi>
References: <20130513205302.GA3157@blackmetal.musicnaut.iki.fi>
 <20130516180933.GG5600@atomide.com>
 <20130516210006.GA31836@blackmetal.musicnaut.iki.fi>
 <20130516214430.GN5600@atomide.com>
 <20130520174621.GI10378@atomide.com>
 <20130605223355.EDC113E10E4@localhost>
 <20130606155341.GL3331@atomide.com>
 <20130623221605.GA3150@blackmetal.musicnaut.iki.fi>
 <CAAwP0s1DkMu8Vfka43hS4Wj-927q=O5u-coyFsPBgy3qtA_vjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:53719 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125Ab3FWXne (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Jun 2013 19:43:34 -0400
Content-Disposition: inline
In-Reply-To: <CAAwP0s1DkMu8Vfka43hS4Wj-927q=O5u-coyFsPBgy3qtA_vjw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jon Hunter <jgchunter@gmail.com>

Hi,

On Mon, Jun 24, 2013 at 01:06:37AM +0200, Javier Martinez Canillas wrote:
> On Mon, Jun 24, 2013 at 12:16 AM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> > What is the status of this patch? We're already at 3.10-rc7 and GPIO
> > IRQs are still broken on OMAP1.

[...]

> There is a problem with this patch.

[...]

> So I think that the correct solution is to add SPARSE_IRQ support to
> omap1 and not reverting Jon's patch. Of course this may not be
> possible since we are so close to 3.10 and most OMAP patches already
> merged for 3.11 but we should definitely try to have this at least for
> 3.12. Otherwise we won't be able to move to DT-only booting for
> OMAP2+.

OMAP1 does not use DT. So we could put this code under #ifdef
CONFIG_ARCH_OMAP1 or similar. It's just a few lines of code. OMAP2+
work should not regress OMAP1.

Demanding SPARSE_IRQ support for OMAP1 should have been discussed before
these changes were made. It's not reasonable to assume such things can
be made during rc-cycle. Also, now, I don't think it's reasonable to
wait for that to be done, as it would take until 3.12 or even later to
get OMAP1 functional again.

A.
