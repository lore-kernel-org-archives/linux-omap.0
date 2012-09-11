From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 10/10] mtd: nand: omap2: use gpmc provided irqs
Date: Mon, 10 Sep 2012 22:42:27 -0700
Message-ID: <20120911054227.GF1303@atomide.com>
References: <cover.1344609341.git.afzal@ti.com>
 <c5a608a70a875191e1323958c74fb2ac8dfa34b3.1344609341.git.afzal@ti.com>
 <1345895326.1815.4.camel@kyv>
 <20120830195349.GW1303@atomide.com>
 <20120911001710.GD1303@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9E1905@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:26632 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752882Ab2IKFmd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 01:42:33 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9E1905@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "ivan.djelic@parrot.com" <ivan.djelic@parrot.com>

* Mohammed, Afzal <afzal@ti.com> [120910 22:36]:
> Hi Tony,
> 
> On Tue, Sep 11, 2012 at 05:47:10, Tony Lindgren wrote:
> 
> > FYI, looks like a new warning got introduced, so I've
> > committed the following trivial patch on top of this series.
> 
> I was not careful enough, sorry. Thanks for fixing it.
> 
> Another hunk as follows would also be required for error
> path even though compiler didn't complain.
> 
> Not sure whether you can fixup or I should post as a
> separate patch.

Oh OK, please just post a separate patch as I've
already pushed it out.

> As an aside, there was compiler warning before this
> series, but I didn't dare to touch it, so a warning
> was seen but thought it was due to the earlier one.
> And now Arnd has fixed the original warning.

OK

Regards,

Tony
