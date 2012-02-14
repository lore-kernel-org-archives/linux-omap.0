From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] usb: host: ehci: allow ehci_* symbols to be unused
Date: Tue, 14 Feb 2012 18:01:17 +0200
Message-ID: <20120214160114.GA11841@legolas.emea.dhcp.ti.com>
References: <1329210895-32513-1-git-send-email-balbi@ti.com>
 <Pine.LNX.4.44L0.1202140959320.1544-100000@iolanthe.rowland.org>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:47621 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751147Ab2BNQBW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 11:01:22 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1202140959320.1544-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Felipe Balbi <balbi@ti.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 14, 2012 at 10:06:47AM -0500, Alan Stern wrote:
> On Tue, 14 Feb 2012, Felipe Balbi wrote:
>=20
> > not all platforms will use all of those ehci_*
> > symbols on their hc_driver structure. Sometimes
> > we might need to provide a modified version of
> > a certain method or not provide it at all, as is
> > the case with OMAPs which don't support port handoff
> > feature.
> >=20
> > Whenever we compile a kernel for an OMAP board with
> > EHCI enabled, we get compile warnings:
> >=20
> > drivers/usb/host/ehci-hub.c:1079: warning: 'ehci_relinquish_port' \
> > 	defined but not used
> > drivers/usb/host/ehci-hub.c:1088: warning: 'ehci_port_handed_over' \
> > 	defined but not used
> >=20
> > In order to cleanup those warnings, we're adding
> > __maybe_unused annotation to those functions. We're
> > also trying to cope with other platforms which might
> > have similar issues with different methods by adding
> > the same annotation to all ehci_* functions.
> >=20
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >=20
> > Alan, what do you think about this patch ? It fixes our warnings
> > and tries to cope with other possible such cases.
>=20
> Some of this makes sense: ehci_port_change, ehci_relinquish_port,=20
> and ehci_port_handed_over are fine.
>=20
> The others are questionable.  What reason could there be for not=20
> implementing ehci_bus_suspend and ehci_bus_resume?  Neither of those=20
> should involve much platform-specific work, if any.

you never know what kind of silicon erratas might come up, right ? :-)

> ehci_hub_status_data, ehci_hub_descriptor, and ehci_hub_control are=20
> even more puzzling.  These are things that _have_ to be implemented for=
=20
> the driver to work at all.  Platform code shouldn't replace them; it=20
> most it should call them as subroutines and override the results when=20
> necessary.

There's no doubt it needs to be implemented, but the fact is that in
some situations we might need to implement it differently because of
whatever reason.

See for example that I have a pending workaround to implement for
OMAP3 EHCI where we need to reparent a clock before handling
SetFeature(port_suspend) so I would need to reimplement
echi_hub_control() in order not to expose that detail to core ehci.

Because clock reparenting is something so ARCH-specific it makes no
sense to come up with a "quirk" flag for that.

Granted, the way I had envisioned, I would reimplement the particular
request that needs special handling and call the generic
ehci_hub_control() otherwise, but still. Like I said, you never know
what kind of erratas could pop up.

--=20
balbi

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPOoVKAAoJEIaOsuA1yqRE5ssP/2pUUtpGKS30aqFDhX+6Lecj
AplbrofE8hShb9Qwxd83PpHICBoaRZTMvg50qWx0mVydWnh72gM7z1le1cfrTbAO
MKNnTHHMnhgBCHDX9S+wfY2ksYiXzaq+nftRcvs9UHDnJQxU3iUSSUnjpWbtg2Pr
NT83HA7BVGlwQ6a2bWlz1+SJz7F8mRyv0PEB7dvwBOspQZHGyOJ3v0l8Wj54yUSS
JjGaV7SFqGE/fRQ3C/cH7ZllBPFgTM5UKOj3opy7QNUgKEly8gTD9vmJtZhX9fMs
xAbIudXtxJlhfOkJEtoP92SWZOwiBVaHPfpf5PDow3IlqiCYmONTzqYSrsqZU5bc
DIQCt2Y6poAeg2ydtwGO7oM0FBdJSlAm29f4ehEqtsTGzn+e4yxH8oy4oIxsKrvz
4x/nEdfudum9CPGrm6RY9gX0Ntk9kMbximEACubQWEUPv8DkKdyxAHSxamgvORFk
lcamiMsAxDT7wKQ+BMUuMapjHOmaN2zimkiVzJeawTElsnkJbp87jJ6s/g3Ehojp
Fw2Q8ZIRVigijOgTGd23CX47caNBD+nf5Ye3MXAhm3XajcKiqX6AbKiIMbhT3pHG
1dgedniZVKQwLJmk2PBAa0R/7E8N3TALeptQh6M3hAhmtc3464dE8McsRNoYeEW/
fjkG3h4VV9ueMRlh7tA5
=IFnu
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
