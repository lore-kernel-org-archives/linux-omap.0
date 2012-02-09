From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/16] rmk's patch series for fixing OMAP
Date: Thu, 09 Feb 2012 09:02:49 +0200
Message-ID: <1328770969.1909.11.camel@deskari>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
	 <4F32DBB5.4010004@gmx.de>  <20120209005334.GG25414@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-ADDqB3tPKAPbL60WPRVh"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:34794 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752501Ab2BIHC4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 02:02:56 -0500
In-Reply-To: <20120209005334.GG25414@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-omap@vger.kernel.org, =?ISO-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>


--=-ADDqB3tPKAPbL60WPRVh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-02-09 at 00:53 +0000, Russell King - ARM Linux wrote:

> Moreover, only last Monday did I enable the OMAP2 DSS subsystem on the
> 4430 SDP platform, _including_ the HDMI code, and looking at the commit
> it could be one of those platforms which is affected.
>=20
> As I don't have a HDMI cable connected to the system, and I ran that
> kernel overnight, and I tried opening each /dev/fb* device, what I'm now
> wondering is: have I destroyed the HDMI PHY on my 4430SDP?

Probably not. I don't know the exact details of the HW bug (I wrote the
patch as it took too long for the person responsible for it to come up
with a decent patch), but my understanding is that the cable needs to be
plugged in at some point, and then removed.

Thinking about this now, I guess I should've sent queries to get a
proper description of the situation where the bug happens.

> However, you raise another point, a much more serious one at that.  Is
> this problem also present in 3.2?  The patch seems to apply almost cleanl=
y
> to that kernel version, so I guess it is.  It fails to apply to v3.1
> because of missing files, so I guess 3.1 is unaffected.
>=20
> So, why isn't this patch copied to the stable people?

Good point, I'll take it to the stable people.

The problem is present in all kernels where we have the HDMI driver, so
2.6.39+.

> For hardware destruction issues, once the problem has been identified, it
> should be shouted about very loudly to get it upstream as quickly as
> possible.  I'm sure Linus would've even taken it in patch form.
>=20
> (You do realise that Linus does apply patches as well as pulling trees?)

Yes, I should've taken this directly to Linus.

 Tomi


--=-ADDqB3tPKAPbL60WPRVh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPM2+VAAoJEPo9qoy8lh71oK8P/Ar+i1xmvQnx1QPU6XbzfP8S
DF8FasC+g7ooBA+2pLSnLMbilzdz7iAtWrZV8u1g56y5GOP4jK/LZyNlwshbCCX7
6zgxZ8yddqaAK3LfwLKI33MfioN/cGg0SZIuBHlJVYCbUp+N1lYGbOuxV1pBJ3zp
TiU8h1yuBz5D/abvYU9Jst2Hqh3eakobsd5zTH8VAsx6pNO0e/inyIWyx+GBPpY9
9EBBEi/Id6Ze8Ba/0EvvgX9Mk8Lsdogb/fzQ3fSDVakN3YBrpS8JBqWg1jZw2TMD
R6zn3GPuoWspVb023AgwbkaFcsPKsmwZEjJo3ZoyEz62bo1Zg0CIwdPXilZY/nx5
3b1O8w+8NDXjXfebRB3CxwiJ4W3D8GWmYFntZyHIHFxvDAvzgy2aYwdNQZi1yJOV
+qs33WCwYUFb4bGUyiyfJPzlooCuXv18Da4kWhu0Dk7HvgWoxbLn/OmlMkCWpcR8
ZTWy2xdYYcLaGMgV2HOh/KbLtLFVk2hCEriz4ofO6rFOXhufQARnGjD4Kf56+QdS
nv9HmzNlRQpn5rNdjwi46MIm+PB5HZhgJd2FRB9ixkRZUWaMJrQVsndPH/bjnQ67
BF2D5q1Udn/724eYKmjneD4TN9LsMyHziJYY0C6hOBiVRwK0blJ2v4+M5WU89OvM
n8DBRYGG3iHOsOiPssgj
=21xI
-----END PGP SIGNATURE-----

--=-ADDqB3tPKAPbL60WPRVh--

