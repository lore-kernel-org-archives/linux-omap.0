From: Felipe Balbi <balbi@ti.com>
Subject: Re: Interaction between USB phy power and MADC driver
Date: Thu, 6 Sep 2012 23:01:06 +0300
Message-ID: <20120906200104.GB32145@arwen.pp.htv.fi>
References: <k2ark9$tdn$1@ger.gmane.org>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:55848 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757851Ab2IFUFo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 16:05:44 -0400
Received: by lbbgj3 with SMTP id gj3so1409708lbb.19
        for <linux-omap@vger.kernel.org>; Thu, 06 Sep 2012 13:05:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <k2ark9$tdn$1@ger.gmane.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Frank Agius <ftagius@yahoo.com>
Cc: linux-omap@vger.kernel.org


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2012 at 02:57:42PM -0400, Frank Agius wrote:
> I'm seeing what I think is an unintended consequence of powering down
> the USB phy.  All the relavent code is in file twl4030_usb.c. My
> system is setup to use the USB in otg mode.  If nothing is connected
> to the USB OTG port, the phy suspension code is called.  In the chain
> of calls that follows, the vusb3v1 regulator is disabled.  However,
> according to the OMAP power management manual, vusb3v1 is used "to
> bias the analog multiplexers on the four MCPC pins between the carkit
> and the MADC". I've seen if there is no bias on this mux, the MADC
> driver returns incorrect counts on these 4 pins that should be in A/D
> mode.  If I plug something into the USB OTG port, the MADC driver
> returns the expected counts.  I also created a debug version of the
> twl4030-usb driver, with the disabling of the vusb3v1 commented out
> and the MADC returns the correct counts regardless of the state of
> the USB OTG port.
>=20
> Since the vusb3v1 regulator is required for the proper operation of
> the mux and by extension the MADC and carkit mode, shouldn't it
> always be enabled?

If MADC needs that regulator, it should request it as well so the
regulator framework has correct usecounts. Also, IIRC there is a
"suspend" mode for the regulator which won't power it down, but it will
consume minimal power while mantaining MADC working.

--=20
balbi

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQSQD/AAoJEIaOsuA1yqRE5Y8P/3zvcEppRlq9i1VEEe6UG24B
cJABKgf5UbnmGqY6eAYSjiJz5biIgN2LNXjP7AX2FcNy8DZs/vVyv0I6qBhKU5wq
2kd09Dmsm30FPWw5N3pVoXl399adTtDBJr6RU4DvQFOMU1gJ/qb2yePjkHHk2g9r
fUkbZe06DIbWoqyahwomKkIaYaY6VgEdj/Jo1bnPRVqy+ERJB72Ke9SXBuHfAFh4
kb529+7RFlZB7wiDjS7P11ik7s25l5AiJ0NcAEVw4y8542QU469jZfrG2GQvhd24
SN5D9CgperIuASFjzHZUiPLgImRXgnA+uF0DQC6KRKRhqaI1gArUwRKBAqWph+mi
Cat0H2Uh6JsB8i7qoE3OX/e/9CsQpqrRbevmpFtzKaYO0ulThbPCIrV3fIjODiEg
hf1G/caHMDGY5Ga37mA9ykoZJQTf3DdDDscDPoYL+38q+WhmEn8YekkyBq6dNA3z
AenrHJTzxlGmxt5ZWUOaF/1w3odkNchQMpxV24MKNfANVsMNsfmGYEauYEUp4hz8
2pPH8fINwFtTjGmZrp6VjbcdVW9I4HJjTLLJ/8F9ZW1e4J2AwRyWVvMz1sfucbdl
di26DD3eUynTd2lNmpcun9pF+pTUSNvLk/WBNMdze7aNcWq8/phQ6zX7+F65inrx
rtOQwyMdaBWq3YCCsx7c
=u3Xn
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
