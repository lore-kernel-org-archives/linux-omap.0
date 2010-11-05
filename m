From: Tony Lindgren <tony@atomide.com>
Subject: Re: How to add an expansion board on IGEP v2 board.
Date: Fri, 5 Nov 2010 14:45:23 -0700
Message-ID: <20101105214523.GY9264@atomide.com>
References: <AANLkTi=_nQu2YZT0+Nq-vGOfu=YufAGC9k+g6GBzYHZH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49356 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab0KEVpj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 17:45:39 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=_nQu2YZT0+Nq-vGOfu=YufAGC9k+g6GBzYHZH@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric =?utf-8?B?QmFsbGV0YsOy?= i Serra <eballetbo@gmail.com>
Cc: linux-omap@vger.kernel.org

* Enric Balletb=C3=B2 i Serra <eballetbo@gmail.com> [101027 01:23]:
> Hello all,
>=20
> I would ask some technical questions, maybe someone can help me. I
> would add support for a new expansion board for IGEP v2 board,
>=20
> The expansion board comes with a EEPROM, the EEPROM is used to
> identify the expansion board, my idea is create a new file for
> expansion board ( board-igep0020-expansion.c ) and
>=20
> * on board-igep0020.c
>   - Add extern void __init igep2_expansion_init(void);
>   - Call igep2_expansion_init on igep2_init()
>=20
> * on board-igep0020-expansion.c
>   - Create  igep2_expansion_init, inside this funciton
>     - Add e2prom device and read board id
>     - If board ID exists then init all expansion devices
>=20
> I'm in the right way ? Comments ?

Sounds good to me. Runtime detection is the best way to go.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
