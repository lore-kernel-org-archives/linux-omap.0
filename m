From: Felipe Balbi <balbi@ti.com>
Subject: Re: Boot hang regression 3.10.0-rc4 -> 3.10.0
Date: Wed, 10 Jul 2013 19:11:58 +0300
Message-ID: <20130710161158.GA19716@arwen.pp.htv.fi>
References: <B5906170F1614E41A8A28DE3B8D121433EE94489@DBDE04.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EE94520@DBDE04.ent.ti.com>
 <20130708112553.GU5523@atomide.com>
 <51DAB394.3050104@ti.com>
 <20130708131033.GA5523@atomide.com>
 <51DABC81.3080409@ti.com>
 <20130708133512.GD31221@arwen.pp.htv.fi>
 <87mwpuakod.fsf@linaro.org>
 <20130710142633.GV5523@atomide.com>
 <20130710160704.GH18966@arwen.pp.htv.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55106 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466Ab3GJQMk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Jul 2013 12:12:40 -0400
Content-Disposition: inline
In-Reply-To: <20130710160704.GH18966@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@linaro.org>, Rajendra Nayak <rnayak@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Jackson <mpfj-list@newflow.co.uk>, Sourav Poddar <sourav.poddar@ti.com>, Paul Walmsley <paul@pwsan.com>

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 10, 2013 at 07:07:04PM +0300, Felipe Balbi wrote:
> how about something like below ? It makes omap_device/hwmod and
> pm_runtime agree on the initial state of the device and will prevent
> ->runtime_resume() from being called on first pm_runtime_get*() done
> during probe.
>=20
> This is similar to what PCI bus does (if you look at pci_pm_init()).
>=20
> commit 59108a500b4ab4b1a5102648a3360276dbf7df6f
> Author: Felipe Balbi <balbi@ti.com>
> Date:   Wed Jul 10 18:50:16 2013 +0300
>=20
>     arm: omap2plus: unidle devices which are about to probe
>    =20
>     in order to make HWMOD and pm_runtime agree on the
>     initial state of the device, we will unidle the device
>     and call pm_runtime_set_active() to tell pm_runtime
>     that the device is really active.
>    =20
>     By the time driver's probe() is reached, a call to
>     pm_runtime_get_sync() will not cause driver's
>     ->runtime_resume() method to be called at first, only
>     after a successful ->runtime_suspend().
>    =20
>     Signed-off-by: Felipe Balbi <balbi@ti.com>

btw, this is RFC, haven't tested at all.

--=20
balbi

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR3YfOAAoJEIaOsuA1yqREyDAQAJczUmOc65Cw5oJDldN2wb65
lAzFxGKXe98R5Od2AlALduoKBRWuIgatn9k/4UUm5kHkK6ST+qd8VnGD9d2s5iAB
YUDU47Zsa2F9sQ3hmtlZIIy/LLadbrYjUuyAfr7B0JRvioFU13qOQoWsI8qM3f7Q
BohT0ut/mrGmebQ2qIRAgg9Kf2D+V0+c5iwwS0hCz4SOueD2NnrrTdqRkstXRnxz
Q0wp0qX63OlL8it/3Faw+YwXvlyv+cjWUQKbA4cO0BWSjzYvScu/cVl0fOJijqaA
O8NedId0s1OtoLUGMOuUrjP/741AEiP86wGu94PKV+9Fn5vcGk5pLvrefujgfREX
z5a7ONT+DWghqixcr/cvbjEkSz+r5ufddv5YKppTYbSluHmnQzP1luYlfvuP8Iym
PSujEiuhixn79A9BbMFETYkjMmf3KCizC8ABm0J2SOe9PYed9385ew9eE4+ogsmM
zDlrnZuY/ybSkRgiEthY8GWQ5I/BImiUSO/xqS7boGfZwa2VCi+m9tfCSiOEwlAi
1F3C1qf0hPJWedVSdTAJc8fBsRCKlLU3E9EhpLuB30mz7vze5kPRxjQ9p0pke9D7
mc0YmqFReSIaMmPbT/HOUaYBHZ+sNybGxBt4UvBfEv1i8FZ+buCFOAHEWaCiuiuX
NQGbEeqs44T1aQrzfdIz
=5X8T
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
