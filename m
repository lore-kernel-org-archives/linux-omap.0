From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/8] OMAP: OMAP3 DSS related clock patches
Date: Wed, 5 Mar 2014 09:19:29 -0800
Message-ID: <20140305171929.GE4983@atomide.com>
References: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com>
 <5316E1B6.4060007@ti.com>
 <5316F895.30607@ti.com>
 <531709C2.6080607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:17313 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbaCERTg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Mar 2014 12:19:36 -0500
Content-Disposition: inline
In-Reply-To: <531709C2.6080607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140305 03:28]:
> On 05/03/14 12:12, Tero Kristo wrote:
> > On 03/05/2014 10:35 AM, Tomi Valkeinen wrote:
> >> Hi Tero,
> >>
> >> What about the dts fixes in this series? DSS DT depends on those fixes.
> >> I'd like the dts fixes to be either merged for v3.14, or I can add them
> >> to my DSS DT series (with acks).
> > 
> > Well, I am not a maintainer of any sort, so you are asking wrong person
> > here. I am just tossing my acks around as my approval for the patches in
> > case someone cares. :) You need to ask Benoit here (or maybe Tony.)
> 
> Ok.
> 
> Benoit, Tony, can we get the dts fixes in this series to v3.14, or is it
> ok if I merge them via DSS DT branch for 3.15?

It's best that you take those four dts changes into your DSS branch.
They don't seem to conflict with anything I have queued, so:

Acked-by: Tony Lindgren <tony@atomide.com>
