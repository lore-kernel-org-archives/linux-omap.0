From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT
 revision
Date: Wed, 6 May 2015 12:37:52 +0200
Message-ID: <20150506103752.GG30910@pali>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <1430902142-17035-2-git-send-email-pali.rohar@gmail.com>
 <3577431.y872Foi4kj@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3577431.y872Foi4kj@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 06 May 2015 11:31:15 Arnd Bergmann wrote:
> On Wednesday 06 May 2015 10:49:01 Pali Roh=C3=A1r wrote:
> > With this patch "revision" DT string entry is used to set global sy=
stem_rev
> > variable. DT "revision" is expected to be string with one hexadecim=
al number.
> > So "Revision" line in /proc/cpuinfo will be same as "revision" DT v=
alue.
> >=20
> > Signed-off-by: Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Acked-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
>=20
> +devicetree mailing list
>=20
> The property needs to be specified in a binding somewhere.
>=20
> > @@ -246,5 +247,14 @@ const struct machine_desc * __init setup_machi=
ne_fdt(unsigned int dt_phys)
> >  	/* Change machine number to match the mdesc we're using */
> >  	__machine_arch_type =3D mdesc->nr;
> > =20
> > +	/* Set system revision from DT */
> > +	prop =3D of_get_flat_dt_prop(dt_root, "revision", &size);
> > +	if (prop && size > 0) {
> > +		char revision[11];
> > +		strlcpy(revision, prop, min(size, (int)sizeof(revision)));
> > +		if (kstrtouint(revision, 16, &system_rev) !=3D 0)
> > +			system_rev =3D 0;
> > +	}
> > +
> >  	return mdesc;
> >  }
> >=20
>=20
> What is the reason for doing it this early? I think it would be nicer=
 to do
> it after unflattening the DT.
>=20

It needs to be done in this code, so "system_rev" variable is set
properly...

> Also, it seems strange to have a string property and then use kstrtou=
int
> to convert it into a number. I think it should either be specified in=
 a DT
> binding to be a string and then have the kernel not assume that it is=
 a number,
> or we should define it to be binary.
>=20
> 	Arnd

Variable "system_rev" is number and it always was. So chaning type will
break more parts.

And it is string DT property to be human readable. Some other developer=
s
suggested for v2 to change it to string (from number).

--=20
Pali Roh=C3=A1r
pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
