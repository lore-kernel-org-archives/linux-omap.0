From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING] HACK: add global/private timers for A9
Date: Thu, 4 Jun 2015 15:37:32 -0500
Message-ID: <20150604203732.GI5710@saruman.tx.rr.com>
References: <1433363565-17725-1-git-send-email-balbi@ti.com>
 <2466648.WjMxjIpAUG@wuerfel>
 <20150603210455.GD6042@saruman.tx.rr.com>
 <20150603212821.GH6042@saruman.tx.rr.com>
 <556F7493.2060602@codeaurora.org>
 <20150603215445.GK6042@saruman.tx.rr.com>
 <55701E93.60303@free.fr>
 <20150604200850.GF5710@saruman.tx.rr.com>
 <5570B5E8.90300@free.fr>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LG0Ll82vYr46+VA1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40068 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335AbbFDUkY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Jun 2015 16:40:24 -0400
Content-Disposition: inline
In-Reply-To: <5570B5E8.90300@free.fr>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: Felipe Balbi <balbi@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Linux OMAP <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

--LG0Ll82vYr46+VA1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2015 at 10:32:40PM +0200, Mason wrote:
> On 04/06/2015 22:08, Felipe Balbi wrote:
>=20
> > On Thu, Jun 04, 2015 at 11:46:59AM +0200, Mason wrote:
> >> Also, check /proc/timer_list for a "Broadcast device". If you don't
> >> define one, the TWD timers are set to periodic mode, with hrtimers
> >> disabled.
> >=20
> > Did you manage to turn global timer into Broadcast device ?
>=20
> Disclaimer: I am a kernel noob, take everything I say with
> a rock of salt.
>=20
> As far as I can see, the global timer code doesn't handle
> frequency changes, whereas the TWD code does.

All right, but TWD has C3STOP and that prevents it from being used as
broadcast device.

Tony Lindgren had the idea of implementing a timer switch during idle
and that could help us strip the kernel off of C3STOP feature flag. That
means we might be able to use TWD as broadcast until CPU decides to
idle, at which point we need to switch to a different timer.

> Yet all these timers are clocked by PERIPHCLK, which is defined
> as CPUCLK / N. So if a platform enables cpufreq, CPUCLK will
> vary, meaning PERIPHCLK will vary. I don't see how the global
> timer can work in that situation.
>=20
> cf. also this recent thread:
> http://thread.gmane.org/gmane.linux.kernel.cpufreq/15770

I'll have a read, cheers.

--=20
balbi

--LG0Ll82vYr46+VA1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVcLcMAAoJEIaOsuA1yqRE1UwQAIXp9hIDnMRM2Kl12/tm/MMQ
OR27aEwGqMIYKEki9Q1j/23uAcSYI1amUgUbN9Ax5y2YJL0rWjs+HEQXOqBTdJNH
gvcXZj13rt5cCTs8cJUK4j5I/NXOKX1GShI2ZG7IPKMNlYvy5YPMss0K0zHzkdFK
tjczmNylMS4Y7IlaZtcIexLfznDz9QhXl2wdkltb09b0N3/S7bKAgr2g6oUSBbRl
+5EctWjut3lE3hGxE1gOiTgKFPHQoSp9f0V5/pARHcZxf2ffs01FvmMqYhC/PuNI
fLYl1qiD3+3NxjGJkvHAyREsq4j5FspLcJy1Ws+cIzGhmflqmFmmsDZsBpaAM/cn
PhrLt0pHGFTdsYMBAM8hFWEQx/PCj8TBSg6KtXhhAxrAienCoBLHgCjrNZ+0qdxs
oGzfRMSm3vMtzGTU64a32k3Ak/0ugaQf/IvfAKC5HPxfDY5xhF7uVMZpU/7NV9jz
tH4Bn6VtZCogYCjwZ1F0zBR2DM76SkrycyE6DTeBl08Oc1Of2Ob3pmT5ybPNTmkk
1jD2D+1t3oDqqc81lSMTksPJaeEAz7Cz0F+vy4KVBKb7FMPzu5ZfaVgBSFKwE1nC
NaNF4dR7SmW6MnYRPiAEBPVdI3v6zPzG3C88xy4WEklxDUX4w5Sr8RQkTPTNIv8f
hp3jLQIAFnAkzPshACY+
=aQf+
-----END PGP SIGNATURE-----

--LG0Ll82vYr46+VA1--
