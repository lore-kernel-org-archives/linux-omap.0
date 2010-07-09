From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/5] omap: Allow testing for omap type with
 	omap_has_feature
Date: Fri, 9 Jul 2010 10:04:22 +0300
Message-ID: <20100709070422.GC24913@atomide.com>
References: <20100708093405.16352.11814.stgit@baageli.muru.com>
 <20100708093804.16352.82935.stgit@baageli.muru.com>
 <4C35E8D1.6030504@ti.com>
 <AANLkTimTBT_tNNB4GB7mvy1hAEcMrWsauIvjG_p33TD2@mail.gmail.com>
 <4C35FCBF.4020400@ti.com>
 <AANLkTinoIchxcoG-GBROttjr63ZxIRwFheQwZ4RAxnWn@mail.gmail.com>
 <4C3628FE.5030201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57030 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940Ab0GIHE0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jul 2010 03:04:26 -0400
Content-Disposition: inline
In-Reply-To: <4C3628FE.5030201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Venkatraman S <svenkatr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Nishanth Menon <nm@ti.com> [100708 22:31]:
> >
> >    I think this 'lazy reviewability'  comes at the cost of very
> >abstraction  the features framework is intended to provide, not to
> >mention the question of correct selection (is this a OMAP4 specific
> >feature or is OMAP5 expected to have it ?). and upgradation.
> >
> >    As mentioned before, the surrounding context of the use of
> >omap_has_feature() will provide enough clues about the cpu specific
> >nature of a feature, if at all needed.
>
> Does it really? when a new feature is added, dont we want to know if
> it is generic feature or a omap specific feature? where is the flag?

Yeah I don't know what we should do with these defines.. Kind of just
threw the patch out there.

If we already have omap specific omap_has_feature functions, we don't
need cpu_is_omapxxxx in most cases.

I suggest we only use the generic defines now, then look at it again
when we run out of the bits to define.

Regards,

Tony
