From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH v4 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
Date: Tue, 31 Mar 2015 09:26:43 +0200
Message-ID: <20150331072643.GB30788@amd>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com>
 <1426022847-30912-4-git-send-email-marek@goldelico.com>
 <20150311152414.GX5264@atomide.com>
 <844740CD-C95B-4411-A2C8-4906F58DBEE8@goldelico.com>
 <20150311164442.GA5264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150311164442.GA5264-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: "Dr. H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi!

> > >> +		io-channels =3D <&twl_madc 1>,
> > >> +	                      <&twl_madc 10>,
> > >> +			      <&twl_madc 12>;
> > >> +		io-channel-names =3D "temp",
> > >> +		                   "ichg",
> > >> +		                   "vbat";
> > >> +	};
> > >=20
> > > Rather than just making platform_data into device tree properties=
=2E.
> > >=20
> > > Can't you hide the these custom properties behind the compatible =
flag?
> > >=20
> > > You can initialize that data in the driver based on the compatibl=
e
> > > flag and the match data.
> > >=20
> > > This makes sense if you can group things to similar configuration=
s.
> >=20
> > Maybe I have not completely understood your proposal.
> >=20
> > Do you mean to go back to have big parameter tables for each device=
/battery
> > combination in the driver code and the compatible flag (e.g. compat=
ible =3D =E2=80=9Cboard17=E2=80=9D)
> > chooses the right data set for the charging map and channels?
>=20
> If you can somehow group them, then yes. Not for every board if there
> are many of them naturally.
> =20
> > I thought this is what the DT was introduced for - to have the same=
 driver=20
> > code but adapt to different boards depending on hardware variations=
=2E
>=20
> Yeah but you also need to consider the issues related to introducing
> new device tree properties. The device tree properties introduced
> should be generic where possible.
>=20
> > And batteries have very different characteristics and vary between =
devices=E2=80=A6
>=20
> Right. Maybe that has been already agreed on to use capacity-uah for
> batteries in general? In that case I have not problem with that as
> it's a generic property :)
> =20
> > The charging maps are depending on the battery type connected to th=
e twl4030
> > and which madc channel is which value is also a little hardware dep=
endent
> > (although the twl4030 doesn=E2=80=99t give much choice).
>=20
> Just to consider alternatives before introducing driver specific
> property for the maps.. Maybe here you could have few different type
> of maps and select something safe by default? Of course it could be t=
his
> is higly board specific, I think some devices may be able to run belo=
w
> 3.3V for example..

As I explained in some other mail, those tables should not be
neccessary at all. They can be computed from li-ion characteristics
and internal resistance, and assumed current during charge and
discharge.

Running below 3.3V.. not really. At that point, the battery is really
_empty_, and voltage is going down really really fast.

Plus, you are damaging the battery at that point.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
