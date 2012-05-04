From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: v3.4-rc4 DSS PM problem (Was: Re: Problems with 3.4-rc5)
Date: Fri, 04 May 2012 17:54:41 +0300
Message-ID: <1336143281.2552.21.camel@deskari>
References: <WC20120502115251.8503FF@terrafix.co.uk>
	 <4FA12775.1090206@ti.com> <WC20120502124638.320406@terrafix.co.uk>
	 <1336033721.14378.2.camel@deskari> <WC20120503084938.900446@terrafix.co.uk>
	 <1336050442.14378.10.camel@deskari>
	 <WC20120504091902.970499@terrafix.co.uk> <1336139415.2552.4.camel@deskari>
	 <1336140072.2552.6.camel@deskari> <WC20120504140943.7604D0@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-7jmeFmcVL17SjLQNpfwC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:48379 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753641Ab2EDOyr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 10:54:47 -0400
Received: by lagy4 with SMTP id y4so2612925lag.36
        for <linux-omap@vger.kernel.org>; Fri, 04 May 2012 07:54:44 -0700 (PDT)
In-Reply-To: <WC20120504140943.7604D0@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>, Paul Walmsley <paul@pwsan.com>, khilman@ti.com
Cc: Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org


--=-7jmeFmcVL17SjLQNpfwC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kevin, Paul,

On Fri, 2012-05-04 at 15:09 +0100, Joe Woodward wrote:

> > > Ok, I can replicate it now. It seems to be somehow PM related. I
> > > normally have USB gadget stuff compiled into kernel so that I can
> > boot
> > > via nfsroot with usb. After disabling USB support from the kernel, I
> > can
> > > see synclosts.
> > >=20
> > > I have no idea yet what could be causing this. I've also tried adding
> > > the couple of DSS patches which are in queue for next merge window,
> > that
> > > force OPP100 when DSS is enabled. They don't seem to help.
> >=20
> > Also, at least on my setup, the sync lost doesn't happen very quickly
> > after starting the video output, but (I think) only when the system
> > starts to idle. My init scripts generate keys for sshd and some other
> > stuff, and no sync lost there, only just before the shell prompt do I
> > get a sync lost.
> >=20
> >  Tomi
> >=20
>=20
> That sounds like the same as I'm seeing. It seems that the sync lost jump=
s=20
> around a bit, from almost immediately (when the graphics are enabled), to=
=20
> up to 3 or 4 seconds later (still just before the shell prompt).
>=20
> I'm assuming that setting the FIFO low and high points fixes your sync lo=
sts=20
> as well (as in the first patch you sent)?
>=20
> I've also noted that doing things in different orders can sometimes fix t=
he=20
> sync lost (such as disabling or enabling DVI output), but this all seems =
a bit=20
> random.
>=20
> I'm just glad someone else has been able to replicate the problem :p

Kevin, Paul, there seems to be a problem with DSS on v3.4-rc4 running on
omap3, causing DSS losing sync. I didn't notice this earlier as I have
USB gadget compiled into my kernel. Removing USB support from the kernel
causes the problem to appear, which more or less hints at a PM related
issue.

I don't see the problem with v3.3, but as there has been a lot of DSS
changes also, it could as well be a DSS change that has triggered the
problem.

It also looks that the sync lost happens when the system idles a bit. I
compared count and time files in debugfs/pm_debug/ for both working
(i.e. usb compiled in) and non-working cases, but they seem similar for
the relevant parts. core_pwrdm is always ON, mpu_pwrdm has both RET and
ON states, dss_pwrdm both RET and ON states (identical counts).

Do you have anything in mind related to PM that has changed for v3.4
which could affect DSS? Any idea what effect USB gadget has? My
understanding is that it keeps usbhost_pwrdm forcibly alive, maybe also
something else, but I'm not sure why it would affect DSS.

I also tested with my DSS OPP100 patches, which try to force OPP100 when
DSS is enabled by adding a PM constraint for bus tput of 1000000000, but
it doesn't seem to have any effect. And, I guess, the constraint affects
only core_pwrdm, and as seen it's anyway always on in both cases.

Any debugging ideas are welcome.

 Tomi


--=-7jmeFmcVL17SjLQNpfwC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPo+2xAAoJEPo9qoy8lh71n8AP/3WbuCBhw1OYdhwJswBpxywH
qIO3gKldQ8aTAOE37kp6I7PdjJD/ZjoyYaC8KO5fuJO3P7n92hLvcAKnYs4oh2lW
OgQX8qx8555z163Ysn3zinXVMZ3Y0HKf+QmAXFBXS4/hxIWg8EuPy083Pk8wMHpW
mnD0QMQCU5M8tVEDG0xzyH/yfKcTOpIxdeih+otBRT+QSn83ZnBzbRm6RmRs5/At
MCEAFJWeTgFHbiAqrJguuYMcKYy5GgtYrhBa6TAab84+pNmpUqgV50mNwrM8eY7y
jO2jUMFHJX+R+ZpzYBX3HwVtlgvJHWMDFf07puLX06dwpaZ0qxGNQixkwf8u3A/O
FD33x8CNxWOsEx5Wzqi2kLFw/aKdH5QYsZxCNv7Z4XinmVrN4Q6f0l0bXhRLnvPu
hIglZPWev8sEU1lCgjC3ningaEtpYd2hkfedJtc0P6KunwuC0+zy2KGR23rLs0t9
L42dvu9XazEiAt9Q8Q/IblNbD6e6MDMy2nghdLplHIesK4J/KP3srPjxtJUYZ6pp
u3uJ84sFiS+Mj+H/NG61+/ByEreXK7fFZah1lCWGcafgagp0+yNxxcLHafWhH7IB
85gUn+l619pKohbDHxq/Sd2FEIUIMyrrGaOgZm2lh+oa0IDGLToynh05GjzGNoE2
Ay+qtRuf7wtU4162ndVW
=6wjI
-----END PGP SIGNATURE-----

--=-7jmeFmcVL17SjLQNpfwC--

