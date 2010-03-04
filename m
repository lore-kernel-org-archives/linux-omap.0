From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: OMAPFB: cannot parse default modes
Date: Thu, 4 Mar 2010 21:24:40 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DC534C2@dbde02.ent.ti.com>
References: <70c9a9111003040725j63355a27j38e3f7b07e7ba43a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59934 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751406Ab0CDPyr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Mar 2010 10:54:47 -0500
In-Reply-To: <70c9a9111003040725j63355a27j38e3f7b07e7ba43a@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?Enric_Balletb=F2_i_Serra?= <eballetbo@gmail.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Enric Balletb=F2 i Serra
> Sent: Thursday, March 04, 2010 8:55 PM
> To: Tomi Valkeinen
> Cc: linux-omap@vger.kernel.org
> Subject: OMAPFB: cannot parse default modes
>=20
> Hello,
>=20
> Testing the Linux Omap master branch on IGEP v2 board I get this feat=
ure
>=20
> [   17.565155] omapfb omapfb: cannot parse default modes
>=20
> My kernel command line is something like  '..
> omapfb.mode=3Ddvi:1280x720MR-24@60' which works without problems with
> latest 2.6.33-rc8. Any idea about this ? There is something different
> between 2.6.33 and 2.633-rc8 ? I'm missing something ?
>=20
[Hiremath, Vaibhav] Please make sure that the mode you are specifying i=
s present in modedb.c file., unless it won't work.

Thanks,
Vaibhav

> Thanks in advance,
>=20
> Enric
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
