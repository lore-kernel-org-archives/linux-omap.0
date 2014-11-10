From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] w1: omap-hdq: support device probing with device-tree.
Date: Mon, 10 Nov 2014 15:59:14 -0800
Message-ID: <20141110235914.GH31454@atomide.com>
References: <20141108103032.5426db7a@notabene.brown>
 <17841415578204@web5g.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <17841415578204-RAIFsGP/6J5uio3avFS2gg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?utf-8?B?0JXQstCz0LXQvdC40Lkg0J/QvtC70Y/QutC+0LI=?= <zbr-i6C2adt8DTjR7s880joybQ@public.gmane.org>
Cc: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, GTA04 owners <gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* =D0=95=D0=B2=D0=B3=D0=B5=D0=BD=D0=B8=D0=B9 =D0=9F=D0=BE=D0=BB=D1=8F=D0=
=BA=D0=BE=D0=B2 <zbr-i6C2adt8DTjR7s880joybQ@public.gmane.org> [141109 16:11]:
> Hi
>=20
> 08.11.2014, 02:30, "NeilBrown" <neilb-l3A5Bk7waGM@public.gmane.org>:
> > This driver has no 'compatible' string and so is not found when
> > using device-tree.
> >
> > Add one with value to match
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0hdqw1w: 1w@480b2000 {
> > device in omap3.dtsi.
> >
> > Signed-off-by: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
>=20
> Looks good to me
> Acked-by: Evgeniy Polyakov <zbr-i6C2adt8DTjR7s880joybQ@public.gmane.org>

Applying into omap-for-v3.19/drivers branch thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
