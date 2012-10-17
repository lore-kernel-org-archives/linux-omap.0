From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] OMAP-GPMC generic timing migration
Date: Wed, 17 Oct 2012 08:53:32 -0700
Message-ID: <20121017155330.GS15569@atomide.com>
References: <cover.1349450723.git.afzal@ti.com>
 <5076B166.2020006@gmail.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9FBC41@DBDE01.ent.ti.com>
 <20121011144756.GB12552@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9FCEC9@DBDE01.ent.ti.com>
 <20121015160154.GB15569@atomide.com>
 <507D050D.2090402@ti.com>
 <507E455F.7060703@ti.com>
 <507ECB31.8030006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:45638 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932304Ab2JQPxq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Oct 2012 11:53:46 -0400
Content-Disposition: inline
In-Reply-To: <507ECB31.8030006@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Afzal Mohammed <x0148406@ti.com>, Paul Walmsley <paul@pwsan.com>, David Woodhouse <David.Woodhouse@intel.com>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, "Hunter, Jon" <jon-hunter@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Daniel Mack <zonque@gmail.com> [121017 08:15]:
> Hi Afzal,
> 
> On 17.10.2012 07:42, Afzal Mohammed wrote:
> > On Tuesday 16 October 2012 12:26 PM, Afzal Mohammed wrote:
> >> I certainly don't think it is easier, rather tougher, cleaner
> >> as well. One thing that worried me was, if we pursue the
> >> auxdata path (a last resort option) and later if it is
> >> objected, we would be back to square one.
> > 
> > I commented on auxdata usage without visualising in more
> > detail how it can be implemented, it was bad of me.
> > 
> > I doubt whether auxdata would help here, it seems using
> > compatible field alone would help in deciding relevant
> > custom timing routine. Whether we want this kind of
> > peripheral knowledge in gpmc driver instead of using
> > generic timing routine has to be decided though.
> 
> Maybe slightly off-topic, but still:
> 
> When GPMC is used for driving NAND chips that comply to CFI, the timings
> could actually be derived from the connected peripheral as well. I
> believe a slowest-possible-mode will have to be selected first for the
> identication phase.

I wish.. Just getting things working to the identification phase
requires quite a bit of configuration for the timings.
 
> Another thing that might be worth thinking about is that apart from the
> GPMC host controller and the peripherals, there could be other
> components like level shifters or series resistors on the board that
> limit the maximum speed of transactions. So in fact we might be better
> off storing all that timing details in the DT, as they are in fact
> highly application specific.

Yes and the level shifters affect timings too.

Regards,

Tony
