From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 10/10] mtd: nand: omap2: use gpmc provided irqs
Date: Tue, 11 Sep 2012 11:21:07 -0700
Message-ID: <20120911182106.GK23092@atomide.com>
References: <cover.1344609341.git.afzal@ti.com>
 <c5a608a70a875191e1323958c74fb2ac8dfa34b3.1344609341.git.afzal@ti.com>
 <1345895326.1815.4.camel@kyv>
 <20120830195349.GW1303@atomide.com>
 <20120911001710.GD1303@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9E1905@DBDE01.ent.ti.com>
 <20120911054227.GF1303@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9E1A11@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11752 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752593Ab2IKSVN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 14:21:13 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9E1A11@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "ivan.djelic@parrot.com" <ivan.djelic@parrot.com>

* Mohammed, Afzal <afzal@ti.com> [120910 23:40]:
> Hi Tony,
> 
> On Tue, Sep 11, 2012 at 11:12:27, Tony Lindgren wrote:
> > * Mohammed, Afzal <afzal@ti.com> [120910 22:36]:
> 
> > > I was not careful enough, sorry. Thanks for fixing it.
> > > 
> > > Another hunk as follows would also be required for error
> > > path even though compiler didn't complain.
> > > 
> > > Not sure whether you can fixup or I should post as a
> > > separate patch.
> > 
> > Oh OK, please just post a separate patch as I've
> > already pushed it out.
> 
> I have posted a separate patch, please consider for
> inclusion in your tree.
> 
> BTW, you original commit that fixes the compiler
> warning has some strange characters.

Ah thanks, that's a copy paste UTF-8 issue. I'll just fold
in the fixes and push them out to a new devel-gpmc-fixed
branch.

Regards,

Tony
