From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: PM(?) problems on v3.3-rc1 on OMAP3
Date: Fri, 20 Jan 2012 17:00:09 +0200
Message-ID: <1327071609.1921.82.camel@deskari>
References: <1327055619.1921.57.camel@deskari>
	 <CAAL8m4zYQmKAnzjfP2eQUyO3hJ3pig2H_jenC_WAWAogQ1JTbw@mail.gmail.com>
	 <1327060886.1921.63.camel@deskari>
	 <CAORVsuVenz_fUPp3o_x+xrN3JJXDUyreMNvqjCPGzLrQf71EnQ@mail.gmail.com>
	 <1327063256.1921.68.camel@deskari>
	 <CAORVsuVGT1AaMzo0r6T4vWe7zz7Uk=o-DydAcGdMzE+utDoUww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Xyj0/mRkiK5hiaaRPlse"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:53557 "HELO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753590Ab2ATPAO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jan 2012 10:00:14 -0500
Received: by mail-lpp01m010-f53.google.com with SMTP id s8so404644lah.12
        for <linux-omap@vger.kernel.org>; Fri, 20 Jan 2012 07:00:13 -0800 (PST)
In-Reply-To: <CAORVsuVGT1AaMzo0r6T4vWe7zz7Uk=o-DydAcGdMzE+utDoUww@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Govindraj <govindraj.ti@gmail.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, t-kristo@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, Joe Woodward <jw@terrafix.co.uk>


--=-Xyj0/mRkiK5hiaaRPlse
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-01-20 at 14:36 +0100, Jean Pihet wrote:
> Tomi,
>=20
> On Fri, Jan 20, 2012 at 1:40 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> > On Fri, 2012-01-20 at 13:34 +0100, Jean Pihet wrote:
> >> Tomi,
> >>
> >> On Fri, Jan 20, 2012 at 1:01 PM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
> >> > On Fri, 2012-01-20 at 17:26 +0530, Govindraj wrote:
> >> >> On Fri, Jan 20, 2012 at 4:03 PM, Tomi Valkeinen <tomi.valkeinen@ti.=
com> wrote:
> >> >
> >> >> > Is there a way to lock the OPP to the full power OPP?
> >> >> >
> >> >>
> >> >> btw,
> >> >>
> >> >> I think enabling cpu_idle and performance governor to should ensure=
 that.
> >> >>
> >> >> However enabling performance governor boot fails.
> >> >
> >> > I thought so too, and tried it but got the same crash as you.
> >> >
> >> > However, I'd imagine that if I don't enable CPU idle or the governor=
s,
> >> > the board would stay in full power mode always. But this doesn't see=
m to
> >> > be the case.
> >> >
> >> > Then again, I don't see how CPU power management could affect the DS=
S
> >> > directly. So it's probably something like: cpu goes to RET -> someth=
ing
> >> > else is allowed go to lower power state (L3?) -> DSS breaks.
> >> It is probably related to the CORE state. Can you check if CORE goes
> >> to low power mode when CPU_IDLE is enabled?
> >
> > This is without CPU_IDLE, i.e. when I'm having problems:
> >
> > # cat /debug/pm_debug/count |grep -i core
> > core_pwrdm
> > (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMB=
ANK2-OFF:0
> >
> > According to that, core is always on.
> >
> >> To prevent the CORE from going into a too-low power mode you need to
> >> request a PM QoS constraint, as Govindraj explained here above.
> >
> > What different power modes there are? With the clock configs I'm using
> > (small display, low clock rates), both OPP100 and OPP50 should work
> > fine.
> CPU_IDLE is not about the OPP (i.e. frequencies), it is about the
> power domains states (ON, RET ...).
> Without CPU_IDLE enabled the power domains will try to transition to
> the default power states (programmed in the PRCM registers). By
> default all power states are programmed to RET or OFF.
> In all cases CPU_IDLE should be enabled to ensure the proper
> interaction between the cpuidle and PM QoS frameworks.

Hmm, So CPU_IDLE is also about other power domains than mpu? What does
it do? The CONFIG_CPU_IDLE help text doesn't say much.

And I'm still confused about why it would be needed. If I enable DSS,
that should enable and keep dss powerdomain in ON state, and the
pm/hwmod framework (or something =3D) should also enable core when DSS is
enabled.

And with low func clock frequencies DSS should operate in all OPPs.

So everything should be in order, with or without CPU_IDLE, right? Or
does core go to sleep even if DSS is enabled? But then again,
pm_debug/count shows that core is always ON.

> You can try the following in order to isolate the problem:
> 1. check if the CORE and DSS are hitting a low power state. The MPU
> state should not have a direct impact on the DSS; the CORE state has a
> direct effect on DSS since it drives the memory controller,

According to pm_debug/count file, core and dss are ON.

> 2. use a fixed frequency for the MPU, by enabling the userspace or the
> performance cpufreq governor. This should rule out an MPU performance
> problem.

Yep. But that'll have to wait until enabling cpufreq doesn't crash the
kernel. But I can't see how MPU could affect DSS, as after DSS is
enabled, the MPU doesn't do anything about it.

 Tomi


--=-Xyj0/mRkiK5hiaaRPlse
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPGYF5AAoJEPo9qoy8lh718+sQAI6wpUkigUG8Mdu1mocOPtn4
DE+d6Hu9G/VTUqHRKz5shByhwMeZVlH9HqWCwUJY9L4kzwFzoX56WBAnj16yuFeT
l4jOSzsYhEOisqkIe9/0EJqMBlxexoxWZdSAUIS9p8xWv2DN2AT6GT/yveyPxnbx
AKITl8ClGbRvR3g5eV5d4Rsuct7MRQ+goCqRy8v8L68UPHS8KuzpVNBGY9I2adVB
Ak6Yx1onbAG3GguSdBux6GYNGhYodRJKmwVAwwEaEMwYbBUBdfYJyIuVF08VskIW
rHidl5vgwowrJ7fEHZQMJ/y/PlCNBnIoecgqNYclYJ6rLuLlLmuAlw1tmTfCia3k
J4Lch3LN4LNb/BxQmYMJtlPj85/7Ty9iZXNvXXpiNuyBHv0s2EMCHUQ4KDpG5gN2
IUkQRzfCJbhntf3fTjXLxRf7v7HF4hbMcNfQPE/t1H1hOGrPN+C2ibyCCYhZhX4s
xUZpoj1jfJvjhhfLm7pzIqXUrQ9cJxy/h3wLDpqqGypNdoI9X3mi4puOdiLzBb6y
jZsNOUpXCGjNx7ipqchvdhitZC26GmPAyc7u0j6cEw46ok3hoaUJjXOOvlIkxwPo
KRxin6Ub8/AC3teDdSkdZRFMj2SqmN6N0LG3eSBaVhxrIEfU3nZdEteiqZvbIvwl
wdDiM0vSdKxGQNeQPNOU
=I7cW
-----END PGP SIGNATURE-----

--=-Xyj0/mRkiK5hiaaRPlse--

