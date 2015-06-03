From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING] HACK: add global/private timers for A9
Date: Wed, 3 Jun 2015 16:28:21 -0500
Message-ID: <20150603212821.GH6042@saruman.tx.rr.com>
References: <1433363565-17725-1-git-send-email-balbi@ti.com>
 <2466648.WjMxjIpAUG@wuerfel>
 <20150603210455.GD6042@saruman.tx.rr.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4BlIp4fARb6QCoOq"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54257 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374AbbFCVbM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2015 17:31:12 -0400
Content-Disposition: inline
In-Reply-To: <20150603210455.GD6042@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>

--4BlIp4fARb6QCoOq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2015 at 04:04:55PM -0500, Felipe Balbi wrote:
> On Wed, Jun 03, 2015 at 10:55:27PM +0200, Arnd Bergmann wrote:
> > On Wednesday 03 June 2015 15:32:45 Felipe Balbi wrote:
> > >=20
> > > Hi Tony and Russell,
> > >=20
> > > AM43xx, even though it's a single processor A9, it still has TWD and =
global
> > > timer. I was doing some profiling with RT v4.0 and latency is 3.5x lo=
wer just
> > > by switching from gptimer to twd/global.
> > >=20
> > > The only problem is that currently, is_smp() check prevents me from u=
sing twd
> > > with AM43xx (that's why it's commented below, for testing purposes).
> > >=20
> > > In the hopes that we can start a, hopefully, small thread around the =
subject,
> > > I'm sending this HACK which I used to get TWD and global timer enable=
d so I
> > > could measure latencies with cyclictest.
> > >=20
> > > Is it so that TWD shouldn't be available on UP integrations of ARM's =
Cortex-A
> > > processors ?
> > >=20
> > >=20
> >=20
> > I wondered about this recently when looking at something unrelated
> > and noticed that the check had been introduced as part of
> > 904464b91eca8 ("ARM: 7655/1: smp_twd: make twd_local_timer_of_register()
> > no-op for nosmp").
> >=20
> > I suspect this was just the wrong fix at the time, and that the
> > real culprit is either alloc_percpu() or request_percpu_irq()
> > getting called too early on a machine without SMP support.
> >=20
> > Possibly the problem is already resolved independently, if you
> > didn't run into it.
>=20
> no, no splats, nothing at all. See [1]
>=20
> [1] http://hastebin.com/helekubutu

Adding Shawn

--=20
balbi

--4BlIp4fARb6QCoOq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVb3F1AAoJEIaOsuA1yqRERvUP/irbowNMuAYUHKwJjR33cDPu
3uoNe6dwf3zX8T5J9yepSyR567gKL6TPzZ4gSsWVzyOUJmxZk4VkGg3IEZ3RN6Z2
b4Rhva0JDbcFzyBFBo3MentxiRLprxerFBH/+U0/EJO5MbDWAXuG1Ak3qrhr5ePN
dvu+jZOmtLp0L/jw+Fp3vez2QnJiqQX0PUNhASq5Id/P/llbysQaJ2Wd83ucsAJo
S2xzLS0UApBdf4F3lIhbz6vi4xNcpHfv93BtMvkqzCHYCc8Kxu/Kou1Ax+Pdc6Hm
RiBMD5b3GCnI8cLyMhWk0fd81sB8X3L2z8n9LcOQGalS7JYOaJpKuKKOTeNc9Ooe
AAdCtjfMDKmWJD9u7SFhc43CPi+gdtCE4wqCTQx96qq/Be2BEn2NngKhVHF+3fcY
3GXgwVEj/4w7U+8ZNX5ct3seWN1584Gwgj+Y2VWrIe08pvghFQT1xYBVGyPurYyf
//TJ327GVIui+c70HsTQMW10jYUHLtTjpsNmmote1iHq3ep6lnS5i508TXOzwYtR
rmEcu5MRFe0MuE3kiizvZ5NmWMRxR1XKkymBW6mUMqS3tjwFC1sNHMcRQRFMOY4D
tTQhZSlvCIGs127JJr5FoS7ReSl7bfp56Ir5B/DYi7vs9CXRL2hDVkj7ezLDNYfm
TeOdZSbah/JjZB2P4zWM
=ZkHU
-----END PGP SIGNATURE-----

--4BlIp4fARb6QCoOq--
