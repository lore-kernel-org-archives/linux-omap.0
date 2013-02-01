From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 3/3] arm: omap2: gpmc: add DT bindings for OneNAND
Date: Fri, 1 Feb 2013 14:12:10 -0800
Message-ID: <20130201221209.GA22517@atomide.com>
References: <1359116591-32730-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1359116591-32730-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130125155633.GC16795@e106331-lin.cambridge.arm.com>
 <CALF0-+X2qsF5OETerRSVsJbjkC-JdVXsZhyw1sxQYR+PWX6LHA@mail.gmail.com>
 <20130128115339.GD7754@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:58566 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757839Ab3BAWMQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Feb 2013 17:12:16 -0500
Content-Disposition: inline
In-Reply-To: <20130128115339.GD7754@e106331-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Ezequiel Garcia <elezegarcia@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "zonque@gmail.com" <zonque@gmail.com>, "matthias.bgg@googlemail.com" <matthias.bgg@googlemail.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "b-cousson@ti.com" <b-cousson@ti.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "jon-hunter@ti.com" <jon-hunter@ti.com>, Artem Bityutskiy <dedekind1@gmail.com>

* Mark Rutland <mark.rutland@arm.com> [130128 03:57]:
> 
> So if I've understood correctly, the first address cell is the CS, and the
> second the offset within this (as the comment in the onenand@0 node hints)?
> 
> If so, the code now makes sense to me :)

Sounds like further checking can be added as needed, so applying this
series into omap-for-v3.9/gpmc.

Regards,

Tony
