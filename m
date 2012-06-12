From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 05/14] ARM: OMAP2+: gpmc: resource creation helpers
Date: Tue, 12 Jun 2012 08:30:57 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E997EE1@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <3b124fd254f5700187a2ec5a423271a7296e0510.1339419492.git.afzal@ti.com>
 <4FD65BA5.4020205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45435 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876Ab2FLIbH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jun 2012 04:31:07 -0400
In-Reply-To: <4FD65BA5.4020205@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Tue, Jun 12, 2012 at 02:27:09, Hunter, Jon wrote:

> > +static __devinit int gpmc_setup_cs_mem(struct gpmc_cs_data *cs,
> > +						struct resource *res)

> > +	return 1;
> > +}
> 
> Nit-pick, CodingStyle chapter 16 states that 0 should be used for
> success when returning from a function.

I doubt whether this falls to the category you are referring.
This function returns number of resources setup, please see
similar for irq too, there it can be 2 also, success or failure
is not sufficient for the other, and with this we have both
functions returning values similar way.

> > +static inline unsigned gpmc_bit_to_irq(unsigned bitmask)
> > +{
> > +	return bitmask;
> > +}
> 
> I have to ask what is the value in this helper function? ;-)

It is to stress the fact that flag user is passing need not be
same as irq bit (here both have same value), this kind of an
arrangement would be required later if waitpin interrupt also
has to be handled, do you still prefer removing it now ?

Regards
Afzal
