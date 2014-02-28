From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 3/4] ARM: OMAP2+: add legacy display for omap3 DBB056
Date: Fri, 28 Feb 2014 14:38:25 -0800
Message-ID: <20140228223824.GN13624@atomide.com>
References: <1392387656-15186-1-git-send-email-chf.fritz@googlemail.com>
 <1392387656-15186-4-git-send-email-chf.fritz@googlemail.com>
 <52FE29BF.9040307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:60928 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751876AbaB1Wil (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Feb 2014 17:38:41 -0500
Content-Disposition: inline
In-Reply-To: <52FE29BF.9040307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Christoph Fritz <chf.fritz@googlemail.com>, bcousson@baylibre.com, Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Daniel Mack <zonque@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140214 06:38]:
> Hi,
> 
> On 14/02/14 16:20, Christoph Fritz wrote:
> > Full device tree support for omapdss is not yet accomplished. Until
> > then, init display by legacy platform code.
> > 
> > Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> > ---
> >  arch/arm/mach-omap2/dss-common.c   |   49 ++++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-omap2/dss-common.h   |    1 +
> >  arch/arm/mach-omap2/pdata-quirks.c |    8 +++++-
> >  3 files changed, 57 insertions(+), 1 deletion(-)
> 
> I'm not nack'ing this, but I'm again hoping to get DSS DT support for
> 3.15. I haven't done any bigger changes to my branch for some time now,
> and I'm just waiting to get some comments/acks for the bindings.
> 
> So I suggest to also try out DSS DT for your board, based on the latest
> DSS DT branch:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/dss-dt
> 
> That way you have it ready and tested if DSS DT goes forward.

Applying only patches 1 & 2 into omap-for-v3.15/dt thanks.

Regards,

Tony
