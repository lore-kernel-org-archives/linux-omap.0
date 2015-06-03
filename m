From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv4 10/10] arm/dts: am57xx-beagle-x15.dts: add HDMI
Date: Wed, 3 Jun 2015 10:16:28 -0700
Message-ID: <20150603171627.GU30984@atomide.com>
References: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com>
 <1433139798-23450-11-git-send-email-tomi.valkeinen@ti.com>
 <20150601215115.GH30984@atomide.com>
 <556EE463.6000502@ti.com>
 <20150603154438.GS30984@atomide.com>
 <556F24E6.7040003@ti.com>
 <20150603161008.GT30984@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:55657 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965314AbbFCRQb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Jun 2015 13:16:31 -0400
Content-Disposition: inline
In-Reply-To: <20150603161008.GT30984@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [150603 09:11]:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [150603 09:03]:
> > 
> > 
> > On 03/06/15 18:44, Tony Lindgren wrote:
> > > * Tomi Valkeinen <tomi.valkeinen@ti.com> [150603 04:28]:
> > >>
> > >>
> > >> On 02/06/15 00:51, Tony Lindgren wrote:
> > >>> * Tomi Valkeinen <tomi.valkeinen@ti.com> [150531 23:25]:
> > >>>> AM57xx Beagle X15 has a HDMI output. This patch adds the device tree
> > >>>> nodes required for HDMI.
> > >>>
> > >>> This one does not seem to apply to linux next, did not look
> > >>> further where it conflicts.
> > >>
> > >> Looks like the change was also in -rc6. I've rebased my patches on -rc6,
> > >> and added the acks:
> > >>
> > >> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git dra7-dss-arch
> > > 
> > > OK, since there are no other merge conflicts that I'm aware of,
> > > it's best that you merge the whole branch. I've acked the patches,
> > > so for this one too:
> > 
> > Ok, I can do that, but isn't this more linux-arm stuff? All the driver
> > side code is already in the mainline.
> 
> Yes but we're getting so late into merge window that I'd rather not
> take it for v4.2 at this point. And it's all DSS related.
> 
> Please make sure you get an ack for the drivers/clk/omap change from
> Mike or Stephen though.

Naturally I mean "getting so close to the merge window" above :)

Regards,

Tony
