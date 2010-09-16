From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs
Date: Thu, 16 Sep 2010 12:10:06 -0500
Message-ID: <4C924F6E.6040804@ti.com>
References: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com>	<1284587799-9637-2-git-send-email-khilman@deeprootsystems.com>	<AANLkTimC9NOJ5TSqkb1ekBQ_ei2-Ci2ewL66+4aCnyk=@mail.gmail.com>	<87sk19eneu.fsf@deeprootsystems.com>	<4C92386F.2070600@ti.com>	<87vd65bsfs.fsf@deeprootsystems.com> <AANLkTim1DD5FOqqxfdV+BoMiq2wmzz6ZuDV6u5_=zUeb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41652 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753139Ab0IPRKK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Sep 2010 13:10:10 -0400
In-Reply-To: <AANLkTim1DD5FOqqxfdV+BoMiq2wmzz6ZuDV6u5_=zUeb@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Linus Walleij had written, on 09/16/2010 12:07 PM, the following:
> 2010/9/16 Kevin Hilman <khilman@deeprootsystems.com>:
> 
>> lib/opp/* seems more appropriate to me with the header at
>> include/linux/opp.h as Linus suggested.
> 
> I second this. I would love to see the generic OPP stuff in
> lib/opp/* so we put it in the right place from the beginning and
> don't have to painfully refactor everything later (clk.h
> especially comes to mind.)
cool.. digging a bit deeper into lib directory, I propose the following:
lib/opp.c
include/linux/opp.h

any soc specific data (for registration etc) -> goes to 
arch/<arch>/mach-<soc>/oppdata_xyz.c or what ever they choose

the intent being lib/ is no place to put mach or arch specific data 
definitions.. it is just noise..

if folks are ok with this, will post a new rev soonish..

-- 
Regards,
Nishanth Menon
