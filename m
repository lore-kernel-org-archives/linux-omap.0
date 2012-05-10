From: Ivan Djelic <ivan.djelic@parrot.com>
Subject: Re: [PATCH v3] ARM: OMAP3: gpmc: add BCH ecc api and modes
Date: Thu, 10 May 2012 17:17:25 +0200
Message-ID: <20120510151725.GA11107@parrot.com>
References: <1335442669-13474-1-git-send-email-ivan.djelic@parrot.com>
 <20120509002927.GF5088@atomide.com>
 <20120509081047.GC17333@parrot.com>
 <20120509153141.GI5088@atomide.com>
 <1336655257.2625.8.camel@sauron.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:33096 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759900Ab2EJPR3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 11:17:29 -0400
Content-Disposition: inline
In-Reply-To: <1336655257.2625.8.camel@sauron.fi.intel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "afzal@ti.com" <afzal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

On Thu, May 10, 2012 at 02:07:37PM +0100, Artem Bityutskiy wrote:
> On Wed, 2012-05-09 at 08:31 -0700, Tony Lindgren wrote:
> > > Note that I could prepare a new MTD patch with BCH ecc code included,
> > > allowing to drop the GPMC BCH ecc api.
> > 
> > OK, let's do that then. I'll drop this patch and you can coordinate
> > your patch with Afzal.
> 
> Ivan, so are you going to send new patches early enough to make them hit
> 3.5? Can you please then re-send all the dependent patches again and
> again describe what depends on what, because I am getting lost :-)

Yes, I agree this has become a bit confusing. I currently have 2 pending patches:

[1] ARM-OMAP3-gpmc-add-BCH-ecc-api-and-modes_v3.patch        (linux-omap)
[2] mtd-nand-omap-add-support-for-hardware-BCH-ecc_v2.patch  (linux-mtd)

They should both be dropped. I will basically merge the two patches and
submit a new single patch on MTD only, with no dependency. I won't need
to patch arch/arm/mach-omap2 anymore.

But in order to do so, I need the changes that Afzal has submitted
(in particular [3]). Those changes (and as a consequence, my new patch)
won't hit 3.5.

So, when Afzal's patches are pushed, I'll submit a new, single MTD patch.

BR,
--
Ivan


[1] http://lists.infradead.org/pipermail/linux-mtd/2012-April/040965.html
[2] http://lists.infradead.org/pipermail/linux-mtd/2012-April/041020.html
[3] http://lists.infradead.org/pipermail/linux-mtd/2012-May/041105.html
