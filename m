From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: PM(?) problems on v3.3-rc1 on OMAP3
Date: Fri, 20 Jan 2012 14:40:56 +0200
Message-ID: <1327063256.1921.68.camel@deskari>
References: <1327055619.1921.57.camel@deskari>
	 <CAAL8m4zYQmKAnzjfP2eQUyO3hJ3pig2H_jenC_WAWAogQ1JTbw@mail.gmail.com>
	 <1327060886.1921.63.camel@deskari>
	 <CAORVsuVenz_fUPp3o_x+xrN3JJXDUyreMNvqjCPGzLrQf71EnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-EfGgdiQck9E/B33M74iS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:54310 "HELO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750950Ab2ATMlB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jan 2012 07:41:01 -0500
Received: by mail-lpp01m010-f42.google.com with SMTP id m7so817644laa.1
        for <linux-omap@vger.kernel.org>; Fri, 20 Jan 2012 04:40:59 -0800 (PST)
In-Reply-To: <CAORVsuVenz_fUPp3o_x+xrN3JJXDUyreMNvqjCPGzLrQf71EnQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Govindraj <govindraj.ti@gmail.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, t-kristo@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, Joe Woodward <jw@terrafix.co.uk>


--=-EfGgdiQck9E/B33M74iS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-01-20 at 13:34 +0100, Jean Pihet wrote:
> Tomi,
>=20
> On Fri, Jan 20, 2012 at 1:01 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> > On Fri, 2012-01-20 at 17:26 +0530, Govindraj wrote:
> >> On Fri, Jan 20, 2012 at 4:03 PM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
> >
> >> > Is there a way to lock the OPP to the full power OPP?
> >> >
> >>
> >> btw,
> >>
> >> I think enabling cpu_idle and performance governor to should ensure th=
at.
> >>
> >> However enabling performance governor boot fails.
> >
> > I thought so too, and tried it but got the same crash as you.
> >
> > However, I'd imagine that if I don't enable CPU idle or the governors,
> > the board would stay in full power mode always. But this doesn't seem t=
o
> > be the case.
> >
> > Then again, I don't see how CPU power management could affect the DSS
> > directly. So it's probably something like: cpu goes to RET -> something
> > else is allowed go to lower power state (L3?) -> DSS breaks.
> It is probably related to the CORE state. Can you check if CORE goes
> to low power mode when CPU_IDLE is enabled?

This is without CPU_IDLE, i.e. when I'm having problems:

# cat /debug/pm_debug/count |grep -i core
core_pwrdm
(ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2=
-OFF:0

According to that, core is always on.

> To prevent the CORE from going into a too-low power mode you need to
> request a PM QoS constraint, as Govindraj explained here above.

What different power modes there are? With the clock configs I'm using
(small display, low clock rates), both OPP100 and OPP50 should work
fine.

 Tomi


--=-EfGgdiQck9E/B33M74iS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPGWDYAAoJEPo9qoy8lh71WhwP/jPWglPYbOdSes+0tR6gLSqH
qvgEiJWeAWNOA4YJ5XQxYb3q9YtDjZ1pGUreewzbMX7fzIbXq4tKsPsT7OuRMFSX
PoBD9FhHyTcyHQmmMbtz+MOdUbZPvKjPNOiLMIGL2NFhJ1j2GDSerqjQg+Wt4Cql
KJH1WFgmztvZUW5nMXmcpG1Gx0t/qy7iaCeXuNUWmteOq1hNt91p1K1zpgFmFh3M
P8kgfBwW3jl7/60iiaoB5VJlkRuRxXcKlRRMyIKjTWjBdlj4+nB5xIQLHjbbio1S
9vn9nrxn9pSZHigmpM44r+KKzloUz70uokLIXLDyNM5fUmNiDD0b/+S36TekPRlx
VvF4RyPW+mfJpSEh8UFVPsVBJVHJiINsWsExaxq+ttvqKCQHZ+5K5NWDzZC1uVzP
Zi+Qz5VbQ4RI6hKimLhLvpSap7Bi59mj/xESB+fP/JwwTjdORBJ8G1Vzg4yoDC7E
sVf997F49cy8eEip1snwhwox5207akz16AptS1MVQWHdRDvmE9mUH4ktQ9V9kOGC
vzsoxn/ItUHFdorxaL7KFJ6Y1LFMOAifjWB16cZmpag0mp+s57O3N1AK+J2h8BWW
W61JHiQTCYfkgKK5qOpKev8SoYz1YVrauQ17vve+ESbuy4PpVXwIECcjpukmlFva
LxNcun/WwxRkyBnvNXq5
=IBbT
-----END PGP SIGNATURE-----

--=-EfGgdiQck9E/B33M74iS--

