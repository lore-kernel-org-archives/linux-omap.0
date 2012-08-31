From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/3] ARM: OMAP2/3: DSS HWMOD fixes
Date: Fri, 31 Aug 2012 11:30:46 +0300
Message-ID: <1346401846.32389.7.camel@deskari>
References: <1336645264-909-1-git-send-email-tomi.valkeinen@ti.com>
	 <alpine.DEB.2.00.1206271416420.27496@utopia.booyaka.com>
	 <alpine.DEB.2.00.1207040610310.6760@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-4GGGuF6ASeOJL6HT1HJF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:48915 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751185Ab2HaIaw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 04:30:52 -0400
Received: by lagy9 with SMTP id y9so2114022lag.19
        for <linux-omap@vger.kernel.org>; Fri, 31 Aug 2012 01:30:49 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1207040610310.6760@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, archit@ti.com


--=-4GGGuF6ASeOJL6HT1HJF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-07-04 at 06:11 -0600, Paul Walmsley wrote:
> Hi Tomi
>=20
> On Wed, 27 Jun 2012, Paul Walmsley wrote:
>=20
> > On Thu, 10 May 2012, Tomi Valkeinen wrote:
> >=20
> > > These patches fix DSS hwmod data related to sysc flags. I haven't see=
n any
> > > problem produced by these missing bits, but by looking at the TRM it'=
s clear
> > > that they should be defined.
> > >=20
> > > However, applying these will cause additional warnings to show during=
 boot:
> > >=20
> > > omap_hwmod: dss_dispc: softreset failed (waited 10000 usec)
> > > omap_hwmod: dss_rfbi: softreset failed (waited 10000 usec)
> > >=20
> > > Most likely the softreset fails even now, but as there's no check to =
verify it,
> > > no warnings are visible.
> > >=20
> > > I think the reason for the failing softreset is the same problem as w=
e have on
> > > OMAP4: dss_core hwmod should be enabled before other dss hwmods can b=
e enabled
> > > (and reset).
> >=20
> > Thanks, queued for 3.6.
> >=20
> > Not sure what to do about the softreset issues at the moment, due to=
=20
> > competing priorities.  But for sure the data should match the hardware.
>=20
> I've dropped these for 3.6 since they cause a PM regression during a=20
> system suspend test:
>=20
> [   39.721282] Powerdomain (dss_pwrdm) didn't enter target state 1
>=20
> Probably before we can pull these in, we need to figure out what's going=
=20
> on there.

Just tested with current mainline
(155e36d40cf31c17f2b629fc2f2f5527e4cfc324) on omap3 overo, with DSS,
USB, MMC disabled in the kernel config:

# echo mem > /sys/power/state=20
[   14.140472] PM: Syncing filesystems ... done.
[   14.154205] Freezing user space processes ... (elapsed 0.02 seconds)
done.
[   14.184173] Freezing remaining freezable tasks ... (elapsed 0.02
seconds) done.
[   14.234283] PM: suspend of devices complete after 13.977 msecs
[   14.244567] PM: late suspend of devices complete after 4.028 msecs
[   14.257110] PM: noirq suspend of devices complete after 6.011 msecs
[   14.263885] Disabling non-boot CPUs ...
[   15.986541] Powerdomain (iva2_pwrdm) didn't enter target state 1
[   15.992858] Powerdomain (dss_pwrdm) didn't enter target state 1
[   15.999084] Powerdomain (per_pwrdm) didn't enter target state 1
[   16.005310] Powerdomain (core_pwrdm) didn't enter target state 1
[   16.011627] Powerdomain (usbhost_pwrdm) didn't enter target state 1
[   16.018188] Could not enter target state in pm_suspend
[   16.026580] PM: noirq resume of devices complete after 2.807 msecs
[   16.037597] PM: early resume of devices complete after 2.655 msecs

[   16.054870] PM: resume of devices complete after 10.620 msecs
[   16.065643] Restarting tasks ... done.

So things don't look correct even without my patches. Does the suspend
work for you?

 Tomi


--=-4GGGuF6ASeOJL6HT1HJF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQQHY2AAoJEPo9qoy8lh71cg4P/jTzMvORCXo05Tn6JG7h9FrD
QzrgcYyGliZLmmhTLUG4gq96/BmRuLbDgYRld/T9D0W8WzkBJ0hDqlVisXIkJ2rK
nKlMt/u3UiLX4LUyguST7dSzU4v6rHTmQMhWFdATy8nIo0KjFUhI0KimeYfmP1KO
eJXS7hS6XhFEikCs6CO5Zxz4LmK0YjUdqSqvayKUwzGSvDnLtDLGhNc841MCnpdl
TdxofRM4MXCKcMOCBQxVyNDnIYof//pGmN+LwsIIar5usXf2zhmQQ8rmSw3sELBk
b7IHpwHNk8rhSyhpFssSh1g49Jf5nRCaU/DBCrhArJepZ1rKHIH8tp1QdRUwJ1JG
5B04vKBfmu86Jw7JfsfBU97pmlANlElfc1QCMASAovWfxmSyY5FLlk5Lo0Mpo1vQ
aW0PPvxRkQTF/gKpeaHk6z6jMqeMNYiX5WbY6T9UWNVhMYYBPzDUiJdg6SD74whd
LLnaCD0VDSO/XI+X1Em1O1qDXHrzeIIjc620bys8VHCHmbvPi9Ow/imGfcOm4AuD
Vo84e9m69C8Lii4exwmtQgRn+/+xfDI6TyXvSAtMPycCZchEQvtqqBhP9H2+OaHT
5zMq/RC2MLhv76taouGeKqwg/4oWsXo5n5w5mKHksBE3U+uNLdYEaf0He547yu/V
A9XOFujCuPUo0PohYtf2
=NbYj
-----END PGP SIGNATURE-----

--=-4GGGuF6ASeOJL6HT1HJF--

