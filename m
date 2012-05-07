From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/13] ARM: OMAP5: l3: Add l3 error handler support for
 omap5.
Date: Mon, 7 May 2012 10:34:30 -0700
Message-ID: <20120507173430.GC5088@atomide.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-8-git-send-email-r.sricharan@ti.com>
 <20120504225153.GZ5613@atomide.com>
 <CAJ7qFSek4h78wHdwdb-h6UZNqUofT03PTm8LN66WQgdKyp5Y+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:34994 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756665Ab2EGRed (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 13:34:33 -0400
Content-Disposition: inline
In-Reply-To: <CAJ7qFSek4h78wHdwdb-h6UZNqUofT03PTm8LN66WQgdKyp5Y+A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "R, Sricharan" <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, b-cousson@ti.com

* R, Sricharan <r.sricharan@ti.com> [120506 00:42]:
> Hi Tony,
>=20
> >> - =C2=A0 =C2=A0 if (!(cpu_is_omap44xx()))
> >> + =C2=A0 =C2=A0 if ((!(cpu_is_omap44xx())) && (!cpu_is_omap54xx())=
)
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
> >>
> >> =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < L3_MODULES; i++) {
> >
> > Isn't there some unnecessary parens here?
>=20
>  You mean in this above for loop?.
>  There are multiple statements .

No, both the old (!(cpu_is_omap44xx())) and the added one.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
