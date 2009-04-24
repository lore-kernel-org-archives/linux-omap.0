From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: Problems while designing TPS65023 regulator driver
Date: Fri, 24 Apr 2009 13:42:05 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03051F8572@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FAA91D06@dbde02.ent.ti.com>
 <200904231517.11338.david-b@pacbell.net>
 <5d5443650904232301wb01150eu33e65074cf6223e8@mail.gmail.com>
 <200904232332.32088.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51173 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752713AbZDXIM2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Apr 2009 04:12:28 -0400
In-Reply-To: <200904232332.32088.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Mark Brown <broonie@sirena.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Trilok Soni <soni.trilok@gmail.com>

As you know, some regulator patches were required in linux-OMAP=20
tree to submit the TPS65023 patch, in absence of which it won't=20
have compiled. Since they are available now, I can submit them=20
after doing a refresh.

Moreover, we are working on some restructuring for the different=20
TPS devices so that the board-dependent code can be separated=20
from the rest of the stuff. It should be closed soon and then=20
the new patches would be submitted for review, for both the TPS
devices.

Thanks and Regards,
Anuj Aggarwal

Thanks and Regards,
Anuj Aggarwal
=20
Platform Support Products
Texas Instruments Incorporated
PSP Products RSS Feed

> -----Original Message-----
> From: David Brownell [mailto:david-b@pacbell.net]
> Sent: Friday, April 24, 2009 12:03 PM
> To: Trilok Soni
> Cc: Aggarwal, Anuj; Mark Brown; linux-omap@vger.kernel.org; Tony Lind=
gren
> Subject: Re: Problems while designing TPS65023 regulator driver
>=20
> On Thursday 23 April 2009, Trilok Soni wrote:
> > Thanks but I was requesting tps 6 5 0 2 3 not tps 6 2 3 5 x =A0:).
>=20
> Sorry ... maybe they'll help some other time.  :)
>=20
> I was wondering what happened to the tps6235x drivers,
> which seemed to have gotten lost.  I don't recall having
> seen tps65023 code.
>=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
