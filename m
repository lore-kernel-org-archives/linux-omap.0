From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs
Date: Thu, 16 Sep 2010 22:43:03 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD26065F@dbde02.ent.ti.com>
References: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com>
	<1284587799-9637-2-git-send-email-khilman@deeprootsystems.com>
	<AANLkTimC9NOJ5TSqkb1ekBQ_ei2-Ci2ewL66+4aCnyk=@mail.gmail.com>
	<87sk19eneu.fsf@deeprootsystems.com>	<4C92386F.2070600@ti.com>
	<87vd65bsfs.fsf@deeprootsystems.com>
 <AANLkTim1DD5FOqqxfdV+BoMiq2wmzz6ZuDV6u5_=zUeb@mail.gmail.com>
 <4C924F6E.6040804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37574 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754291Ab0IPRN3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 13:13:29 -0400
In-Reply-To: <4C924F6E.6040804@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Menon, Nishanth
> Sent: Thursday, September 16, 2010 10:40 PM
> To: Linus Walleij
> Cc: Kevin Hilman; linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH 1/4] OMAP: introduce OPP layer for device-specific
> OPPs
> 
> Linus Walleij had written, on 09/16/2010 12:07 PM, the following:
> > 2010/9/16 Kevin Hilman <khilman@deeprootsystems.com>:
> >
> >> lib/opp/* seems more appropriate to me with the header at
> >> include/linux/opp.h as Linus suggested.
> >
> > I second this. I would love to see the generic OPP stuff in
> > lib/opp/* so we put it in the right place from the beginning and
> > don't have to painfully refactor everything later (clk.h
> > especially comes to mind.)
> cool.. digging a bit deeper into lib directory, I propose the following:
> lib/opp.c
> include/linux/opp.h
> 
> any soc specific data (for registration etc) -> goes to
> arch/<arch>/mach-<soc>/oppdata_xyz.c or what ever they choose
> 
> the intent being lib/ is no place to put mach or arch specific data
> definitions.. it is just noise..
> 
> if folks are ok with this, will post a new rev soonish..
> 
If you like may be you can take this thread over lkml just to get more
wider perspective
