From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: dss_pwrdm & core_pwrdm not entering sleep state correctly on
 am37xx
Date: Wed, 7 May 2014 13:16:41 +0300
Message-ID: <536A0809.3050008@ti.com>
References: <CABCN2StgZisw2WH=wQb_iGEDZLo1ysLJ-f8BZ4a_Yf0_Ph_zKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="79I3IHvstVFeL2S02eCAqtsWklfmVef1b"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40479 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754598AbaEGKQp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 May 2014 06:16:45 -0400
In-Reply-To: <CABCN2StgZisw2WH=wQb_iGEDZLo1ysLJ-f8BZ4a_Yf0_Ph_zKQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew LeCain <alecain@google.com>
Cc: linux-omap@vger.kernel.org

--79I3IHvstVFeL2S02eCAqtsWklfmVef1b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/05/14 06:15, Andrew LeCain wrote:
> Hi,
>=20
> I'm trying to backport a display driver for an RFBI panel to 2.6.32, bu=
t
> the dss_pwrdm is complaining about not entering target state:

That is probably some custom kernel, as mainline 2.6.32 didn't even have
omapdss driver.

> root@02AA01AB381207S7# cat /sys/kernel/debug/pm_debug/count | grep dss
> dss_pwrdm (ON),OFF:0,RET:11,INA:0,ON:12
> dss_clkdm->dss_pwrdm (0)
>=20
> root@02AA01AB381207S7# echo -n "mem" > /sys/power/state PM: Syncing
> filesystems ... done. PM: Preparing system for mem sleep Freezing user
> space processes ... (elapsed 0.02 seconds) done. Freezing remaining
> freezable tasks ... (elapsed 0.04 seconds) done. PM: Entering mem sleep=

> spidev spi2.0: ... can't suspend WLAN: Suspend call WLAN_firmware
> Suspend Wake locks are active (count: 0) Shutting Down I&F Clock
> Interface Powerdomain (core_pwrdm) didn't enter target state 0
> Powerdomain (dss_pwrdm) didn't enter target state 0 Could not enter
> target state in pm_suspend
> <snip> #no change after attempted suspend.
> root@02AA01AB381207S7# cat /sys/kernel/debug/pm_debug/count | grep dss
> dss_pwrdm (ON),OFF:0,RET:11,INA:0,ON:12
> dss_clkdm->dss_pwrdm (0)
>=20
>=20
> I was worried it might be the dss clocks not being disabled, but I
> instrumented dss_clk_(en|dis)able to print clock counts and it goes to =
0
> before suspending. I don't really understand what will prevent the dss
> power domain from entering retain state or not, so any pointers would b=
e
> useful.

Hmm. I think the "dss_clkdm->dss_pwrdm (0)" says that there are no users
with references dss_pwrdm. So it sounds to me all the clocks etc are
properly off, but the platform code does not turn the dss powerdomain
off for some reason.

 Tomi



--79I3IHvstVFeL2S02eCAqtsWklfmVef1b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTaggJAAoJEPo9qoy8lh71+p4P/2Geg0Odn4fWzviNzgW1NtTd
+EHnh7h06Ow4HLzAcVMifr0tFdXAEeXrVCXk4LTWBeL2DGEFi002o8E6VYULri0k
Qw7N2Cw0nN4x7RqDo4dzC4V5AfN2pnBSkczoDfqWAWZSoiUMWkJlu8zICETD4+l1
jbW896lmTb69B3NiiyWxCdEdVqVRYUFxUx/eLmwRilR8pIr+W27rCzSrwDxtiWFQ
LzIEDwCag/p8K7Fp69qW3UkcOFNdM3NrWBoBmjFU/dXsXdbKeSV+Revvr+9BJGkq
OsITr+HUNEuEtgPsUFXSntXmUHlX6bV69OzqizOupH7kDriF2+zhorketSskEyQ5
Sz37yCkVtzsWUkPE+R9i1dbrbevS5W4RxO2q6yVTADr73G8PE14LANbpVU6/Nrk9
xFPlSj4aMLXWJRZBRRu2asUy2bmV0uAc9Eya/e30IVh+WlHJbGsKeYz8IThodiJU
Jrx3BX6qL9BEAMLFcmYuuYNgLlbIK07yTSVRADAmRHwtgT/ePUUhxiNcHLpAvyuW
n5S0cNRxg/+dEoQyJ6Ms/lMGpJ1UPhohG4cV8nv19+E46aGn+/BKx4XXi/E4XeL7
ojpepFK3Uy0G/GAHLHDqHj2Qnw/d20MTgVJ6P5DMPry9RUtB0IBuAMjN9EUhK3Pt
oYKwL55v7zzFM+IQj/NM
=anyu
-----END PGP SIGNATURE-----

--79I3IHvstVFeL2S02eCAqtsWklfmVef1b--
