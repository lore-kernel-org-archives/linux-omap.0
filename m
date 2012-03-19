From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: arm-soc + rmk's tree boot failure on OMAP4430SDP
Date: Mon, 19 Mar 2012 14:41:04 +0200
Message-ID: <1332160864.2144.66.camel@deskari>
References: <20120316231158.GA9970@n2100.arm.linux.org.uk>
	 <20120317004706.GF7276@atomide.com>
	 <20120317211505.GA4720@n2100.arm.linux.org.uk>
	 <1332149601.2144.15.camel@deskari>
	 <20120319123006.GC16389@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-5z3EFKT4OMWj71cLrCE4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:58852 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754368Ab2CSMlJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Mar 2012 08:41:09 -0400
Received: by mail-lpp01m010-f44.google.com with SMTP id j5so7396945lag.17
        for <linux-omap@vger.kernel.org>; Mon, 19 Mar 2012 05:41:07 -0700 (PDT)
In-Reply-To: <20120319123006.GC16389@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>


--=-5z3EFKT4OMWj71cLrCE4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-03-19 at 12:30 +0000, Russell King - ARM Linux wrote:
> On Mon, Mar 19, 2012 at 11:33:21AM +0200, Tomi Valkeinen wrote:
> > But that's a bigger work item, so what I did in the series above is tha=
t
> > I changed platform_driver_register()s to platform_driver_probe()s. All
> > the DSS subdevices are present at boot time and are non-hotpluggable, s=
o
> > I think that should work fine.
>=20
> platform_driver_probe() is just a wrapper around platform_driver_register=
() -
> the difference between the two is that _probe() will temporarily set the
> probe method in the passed driver structure, call platform_driver_registe=
r(),
> and then NULL the probe method out.

I meant that platform_driver_probe() solves the issue with the
initialization order of the dss subdrivers.

The deadlock is solved in the series by moving the driver registration
to module_init.

> So, merely changing platform_driver_register() for platform_driver_probe(=
)
> won't solve the deadlock.
>=20
> I'm not sure what's caused this regression, as I can't see any DSS change=
s,
> nor core driver model changes which would account for this.  Has somethin=
g
> changed in hwmod to cause this?
>=20
> It is _very_ important that we discover what has caused this regression
> and prevent it going upstream until the problem is resolved.  Until we
> know that, I suggest that _no_ OMAP changes go upstream during this
> merge window until we understand what's caused this.

I didn't try yet, but it could be this:

commit 3ec2decbb6dfcdbbb6e6a8ddf5adc7edbc429ed7
Author: Kevin Hilman <khilman@ti.com>
Date:   Wed Feb 15 11:47:45 2012 -0800

    ARM: OMAP: omap_device: remove omap_device_parent
   =20
    Currently all omap_devices are forced to have the dummy device
    'omap_device_parent' as a parent.  This was used to distinguish
    omap_devices from "normal" platform_devices in the OMAP PM core code.
   =20
    Now that we implement the PM core using PM domains, this is no longer
    needed, and is removed.
   =20
    This also frees up omap_devices to have a more complex parent/child
    relationships that model actual device relationships.
   =20
    The only in-tree user of omap_device_parent was the OMAP PM layer to
    handle lost-context count for omap_devices.  That is now converted to
    use the presence of the omap_device_pm_domain instead.
   =20
    Signed-off-by: Kevin Hilman <khilman@ti.com>

Tomi


--=-5z3EFKT4OMWj71cLrCE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPZylgAAoJEPo9qoy8lh71PMsP/0V/3+MA3erSIBAFEiGuikNX
8podk4n/PRx4tvlmGHvZ18aHYiGQ78TzLjvzYU9Gy1CD7oezSpby3eorax0eZGPU
lSdwOgwQ2o6O8Q+/pKu3GNMKqGMq++uFJrn4HZc4DTt4a65TLsidJ6I+DuSCZri1
dvBI5JGC5bhaNel96Fc5m0TXxAwLlvEiY/wdPxi9BDYV8PByIOVH/PlIPn54Pf5f
ELnmaxfGPe5roiE/IYJ7Wf18SAHQuNb/80YkNWYLXiTQ3zB42mKjyhzEac5+dcxc
sVPge4LRGd7M+CoF6hXR9t47Hn4ZsFY3c/5///DzIOCfFUXQqLXxpOHH3E/MzE+R
BcRs6LSrCTHVOol9UDr1T7c8AkEm11Hn96iriB09qoOt2eqoiB7sHhOgnNDh8LjK
B8EeeuFXG+r8h0fzsfYrCqh8ZBObexNfuR7cgRmaAMetCITkmp/TtdE0U1L3+Uvi
TRo/Zg0EbY7IUSEOqlmp6X31PN18GaSW0z1cTwqnAdrmojax/h2zLzkdWHPm6BAy
XO1od2vWYmAGCgih5x/tsvBBhYh11qae1Rm75e6KDcE+TPWKPa8iffHHqDKwBIPT
L5/AndsjyGE1/+Jzgk3xnBXkeylb3pY8TxPa4O7tmNI5tGXjatQ98oK3BRF6dBDE
8BA1UCBWIKiOispiqz0V
=Bhe8
-----END PGP SIGNATURE-----

--=-5z3EFKT4OMWj71cLrCE4--

