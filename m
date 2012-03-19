From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: arm-soc + rmk's tree boot failure on OMAP4430SDP
Date: Mon, 19 Mar 2012 11:33:21 +0200
Message-ID: <1332149601.2144.15.camel@deskari>
References: <20120316231158.GA9970@n2100.arm.linux.org.uk>
	 <20120317004706.GF7276@atomide.com>
	 <20120317211505.GA4720@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-P2qDMsfdKLKSJ/D7BEsY"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:48482 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757066Ab2CSJd1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Mar 2012 05:33:27 -0400
Received: by lahj13 with SMTP id j13so6571585lah.33
        for <linux-omap@vger.kernel.org>; Mon, 19 Mar 2012 02:33:24 -0700 (PDT)
In-Reply-To: <20120317211505.GA4720@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>


--=-P2qDMsfdKLKSJ/D7BEsY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2012-03-17 at 21:15 +0000, Russell King - ARM Linux wrote:

> And the reason is that a platform _driver_ (omapdss_dss) is being
> registered while a platform device (omapdss) is being probed.
>=20
> This is a very bad idea.  There is absolutely no reason to register
> drivers from within a probe function - to put it another way, this
> code is absolutely insane.
>=20
> Why?  Because you're destroying the whole idea that drivers only ever
> get registered once.  If you happen to have two omapdss devices (okay
> that probably won't happen yet) then you'll register those device
> structures twice which will cause all hell to break lose.
>=20
> Moreover - and this is why it's failing - when devices are probed, their
> mutex is held.  But not just _their_ mutex, but also their direct parent'=
s
> mutex as well.
>=20
> So, when the omapdss_dss driver is registered while the omapdss device is
> being probed, and there's already an omapdss_dss platform device present,
> the driver model tries to bind the omapdss_dss platform device with the
> newly registered omapdss_dss platform driver.
>=20
> That binding wants to take the mutex on the omapdss device, but wait,
> that's already held by the thread registering the omapdss_dss platform
> driver.  Hence, deadlock.
>=20
> This mess has been created by all those
> 	"DSS2: xxx: create platform_driver, move init, exit to driver"
>=20
> commits, and they're all _wrong_ for the above reason.

Yep, it's totally broken. It's been working by luck, and nobody has paid
attention to it. I noticed this while I was working with device tree
adaptation, and the patches here fix the issue:

http://marc.info/?l=3Dlinux-omap&m=3D133112435224731&w=3D2

I wasn't planning to merge them yet, as it's quite late in the release
cycle, but it seems I have to. I think I'll drop some of the unrelated
patches (taal and tfp410 related) from that series, as they are just
cleanup-churn.

> However, I doubt simply moving the driver registration calls out of the
> probe function will be enough - "OMAP: DSS2: Fix init and unit sequence"
> hints that there's a dependence in the driver initialization order.
> That's another finger pointing at the approach being wrong, because
> there is _no_ guarantee as to the order in which drivers or devices are
> probed by the driver model.

True. I think the best would be to have a dynamic approach, where the
subdrivers would register themselves somewhere, and it the order
wouldn't matter. That would even allow compiling the subdrivers as
separate modules.

But that's a bigger work item, so what I did in the series above is that
I changed platform_driver_register()s to platform_driver_probe()s. All
the DSS subdevices are present at boot time and are non-hotpluggable, so
I think that should work fine.

However, there's one problem with this approach that is present in the
code: we don't know if platform_driver_probe() returns an error because
there are no devices for the driver (e.g. no HDMI on OMAP3), or because
the probe of the driver failed. In the former case we don't need to care
about the error, but in the latter case we should do something.

I'll try to find a quick solution for this also.

 Tomi


--=-P2qDMsfdKLKSJ/D7BEsY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPZv1hAAoJEPo9qoy8lh71Zr0P/3q2G0tXbooMspMpMtsUV+2J
cTVgYhxSP5jaWf0gm5NkxadHiM9OkTxfeFI72oNIqocdQeNbnlofYam6Z0mN7doa
1j1XcXp05IrsumRl9of6uJZBAN4YY0ailB3LBpU+zrHLQNWuMgCUJKWXR7LtGPRW
/S+hSLuWfsa/vcxQ3lRhHhsl0EB0taHwUSfYNM4xYW7feQCQBjWg1hl5d3xfltqn
7AIY/CYNtY0VWTNo6ISd8DumA2XTXN/tlINHqACHCxUyrMf4XwBK+7pF/4NfIKuZ
RpywnrJb739X74rVzWW4lO3usB7od525z3JMFrq5vY6//el0sElGNNjFHG1RDPn4
UtvaoOge4BPf497EZMguYIjU7QWU+JIUz2WvsPSJfQk5jnRx/ezniyiIY/62LJ/Y
PINLMhOpYPWJL22VQe1jrSfm771ofAqaQyLx7a3O25bPQsNsC7SPTAkF9KuVyh1R
LvIu5lJgTGDNqDXqtNBTK7E9xNcK5j7l9tZwde9mgIxJ+boM7BwK98HQuVQQoUne
3H+e46tquNAmv04tcA5tW2ZIN9dKUGGFd8a2B4iY3P3sdamubLsBROMsVql+om/o
sDmB3LFnEZUooGxRXh2BSOT4zQ4cdIEK9QTiPOe3U3RN9QIIWrqmnEwgNIcRb4yo
gxQEQCHKVj6UMmabitpw
=Y569
-----END PGP SIGNATURE-----

--=-P2qDMsfdKLKSJ/D7BEsY--

