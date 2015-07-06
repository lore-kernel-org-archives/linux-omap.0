From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT
 revision
Date: Mon, 6 Jul 2015 06:55:06 -0700
Message-ID: <20150706135506.GI10705@atomide.com>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <201507061423.23505@pali>
 <20150706123126.GG10705@atomide.com>
 <201507061512.27124@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201507061512.27124@pali>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [150706 06:14]:
> On Monday 06 July 2015 14:31:27 Tony Lindgren wrote:
> > * Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [150706 05:25]:
> > > into which file should I put documentation about new DT propertie=
s?
> >=20
> > If it's Linux generic like linux,revision, then how about
> > Documentation/devicetree/bindings/revision.txt?
> >=20
> > For the ATAGs, Documentation/devicetree/bindings/arm/atag.txt?
>
> Hm... now I'm thinking into which DT field should I put atags and=20
> revision. In previous emails you wrote to use "linux,atags", now=20
> "arm,atags"? And put them into root node? Or other?
>=20
> In arch/arm/boot/compressed/atags_to_fdt.c code I see that most atag=20
> properties are converted into "/chosen" node in DT...
>=20
> So what do you prefer for "revision" and what for "atags"?

I'd prefer linux,revision and arm,atags. Chances are the ATAGs
won't be used on other architectures. I'm find with linux,atags
too if people prefer that.

Regards,

Tony
=20
> Some mentioned examples:
>=20
> "/revision"
> "/chosen/revision"
> "/linux,revision"
> "/chosen/linux,revision"
> ...
>=20
> "/atags"
> "/chosen/atags"
> "/linux,atags"
> "/chosen/linux,atags"
> "/arm,atags"
> "/chosen/arm,atags"
> ...
>=20
> --=20
> Pali Roh=C3=A1r
> pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org


--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
