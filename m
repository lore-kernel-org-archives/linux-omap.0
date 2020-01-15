From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] ARM: dts: Configure omap5 AESS
Date: Wed, 15 Jan 2020 13:49:52 +0100
Message-ID: <5E0BF30D-2723-4724-89E1-449230758EE2@goldelico.com>
References: <20200114150937.18304-1-tony@atomide.com> <52905C15-A2D1-4372-9781-D602D0B274B6@goldelico.com> <20200114164613.GR5885@atomide.com> <D51230C4-2642-4388-959F-313A3382AB99@goldelico.com> <20200114171634.GS5885@atomide.com> <632E66D6-47EF-44CF-BF02-B0F5A215D904@goldelico.com> <ACB71118-B121-4CF7-934D-A88654366E8F@goldelico.com> <20200114210039.GT5885@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:8555 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgAOMuB (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jan 2020 07:50:01 -0500
In-Reply-To: <20200114210039.GT5885@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, devicetree@vger.kernel.org, Matthijs van Duin <matthijsvanduin@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tero Kristo <t-kristo@ti.com>


> Am 14.01.2020 um 22:00 schrieb Tony Lindgren <tony@atomide.com>:
>=20
> * H. Nikolaus Schaller <hns@goldelico.com> [200114 18:40]:
>> I have checked our tree and it is already built into a separate =
module with
>>=20
>> sound/soc/ti/aess/omap-aess-core.c:	{ .compatible =3D =
"ti,omap4-aess", },
>>=20
>> So
>>=20
>>> target-module@f1000 {			/* 0x401f1000, ap 32 =
20.0 */
>>> 	...
>>> 	aess: aess {
>>> 		compatible =3D "ti,omap4-aess";
>>> 		status =3D "disabled";
>>> 	};
>>> };
>>=20
>> would be what we will need.
>=20
> OK good to hear.

I have cleaned up my working tree and added your patches and the one
above (without status =3D "disabled" and could
a) boot well
b) see that the (non-working) aess driver module is loaded through child =
node

So you can add my Tested-by: Nikolaus Schaller <hns@goldelico.com>

BR and thanks,
Nikolaus
