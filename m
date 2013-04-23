From: Tony Lindgren <tony@atomide.com>
Subject: Re: Multiple issues with omap4 panda es in linux next
Date: Tue, 23 Apr 2013 16:16:06 -0700
Message-ID: <20130423231605.GO10155@atomide.com>
References: <20130419171318.GK10155@atomide.com>
 <5174F7A8.7070308@ti.com>
 <20130422180316.GA10155@atomide.com>
 <5176A45B.5@ti.com>
 <20130423172353.GD10155@atomide.com>
 <20130423213151.GM10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:33543 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755894Ab3DWXQK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Apr 2013 19:16:10 -0400
Content-Disposition: inline
In-Reply-To: <20130423213151.GM10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Luciano Coelho <coelho@ti.com>, Roger Quadros <rogerq@ti.com>, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Ravi Babu <ravibabu@ti.com>, Ruslan Bilovol <ruslan.bilovol@ti.com>

* Tony Lindgren <tony@atomide.com> [130423 14:37]:
> * Tony Lindgren <tony@atomide.com> [130423 10:28]:
> > * Kishon Vijay Abraham I <kishon@ti.com> [130423 08:15]:
> > > >>>2. MUSB fails with legacy booting and DT on panda es
> > > >>>
> > > >>>With both legacy and DT booting I get something like:
> > > >>>
> > > >>>HS USB OTG: no transceiver configured
> > > >>>musb-hdrc musb-hdrc.0.auto: musb_init_controller failed with status -517
> > > >>
> > > >>The dt should work fine with https://patchwork.kernel.org/patch/2423061/.
> > > >
> > > >OK thanks for checking that.

Kishon, I think there's also some other issue remaining
in linux next with MUSB and DT. I'm still getting the
"HS USB OTG: no transceiver configured" although the nop
xceiv is compiled in. Maybe give it a try against linux
next?

Regards,

Tony
