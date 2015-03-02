From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH RFC 6/6] ARM: dts: am335x-boneblack: Use new binding for
 HDMI
Date: Mon, 2 Mar 2015 19:08:39 +0200
Message-ID: <54F49917.6070608@ti.com>
References: <cover.1424961754.git.jsarha@ti.com> <6d6653416fd87c678a80df1d422420877261c4a5.1424961754.git.jsarha@ti.com> <54F45778.6050406@ti.com> <20150302160629.GB29584@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="K2tQwhlBGP73abaKGcDOUVGxD1tn7Qc1O"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37851 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756236AbbCBRI6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Mar 2015 12:08:58 -0500
In-Reply-To: <20150302160629.GB29584@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jyri Sarha <jsarha@ti.com>, dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, detheridge@ti.com, moinejf@free.fr

--K2tQwhlBGP73abaKGcDOUVGxD1tn7Qc1O
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 02/03/15 18:06, Russell King - ARM Linux wrote:

>> This is missing the output of tda998x. It should have two ports, input=

>> and output, output going to hdmi-connector.
>=20
> We don't have that kind of level of modelling in DRM right now - as far=

> as DRM is concerned, the tda998x is both the encoder _and_ the connecto=
r
> since it supplies both functionalities.

That's fine, but these are DT bindings which should reflect the
hardware, not the SW stack.

> We did discuss this ages ago, but afaik no concensus was reached how to=

> model physical connectors in DT, so it never moved forward in DRM (and

I don't know about consensus, but omapdss is using connectors in DT, and
they were discussed in lists, and everyone seemed to be ok with that
model (Documentation/devicetree/bindings/video/hdmi-connector.txt). If I
recall right, the only real question was how the links should be modeled
(two way, one way, something else), but that's not specific to connectors=
=2E

So while it's open how they should be implemented in the DRM, I don't
see why we couldn't/shouldn't specify them in the .dts.

That said, if and when DRM supports connectors defined in .dts, we can
just assume that if tda998x does not have an output defined in the .dts,
it's connected to a HDMI connector. So we should do just fine even if we
end up not defining the connectors at this time.

> besides, everyone seems to be off doing their own thing when it comes
> to writing DT descriptions for video hardware.)

Yep... I've been trying to push the video ports/endpoints system which
afaik covers about all the use cases that have been raised. But the
counter argument usually is that "it's too complex".

 Tomi



--K2tQwhlBGP73abaKGcDOUVGxD1tn7Qc1O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU9JkXAAoJEPo9qoy8lh71meQP/j6OCUd/ImEEn04dyE7nvqpa
JR/pbiGwtrRsGrAtmJmof3t3U6rVMHoqDhuKNPfkthAzZu7zyvCvCdUJOhofoVoX
pulmLwpq3dl2VFsUAz+P2mKOZQ5kcDTyozKF6Ww5E7M8g6mn/pFhznMaf5G5tVFC
W1LyryZ8c3zp9zCqjHLD+Y5qiIBAN25M6OYkhMMujgbH3U81dE0X5tW9WbDnAbXd
dkn/NIgLb7whvA/qsJqjVveSbHHZJdknDR7bz8snq30H4XqXKbh4On+FUT8LWTqV
DO+86SflI5FTZIhMTpQ0bH5wb3you87R6R4AACB5RXB/sXxGb15mxTZ8j8gvMIAy
L+nYhxxiOmF7jOQPCiD5w0PprNoQQYISFWrlcgJZUIC4o972yM1e1JP0LAWQOZg1
122TdQmjDRXwGVOpJNH6CgH0rqLog1a/PyHSBYWiB2Dd0IRXMvjoGRs8fMbQeyIi
ZWtAWpa+VUS/cBQLfQXxGg8lk+J44kmQPwAjxrgIoENBuIQ52A/+QJZmVHW1BCmN
PqZ2kfDIIkwh/UViFNYOgx0FxGrC3af86QIK6oMel5aFIfu2wlImI0dIBp2gQxTr
Z13TSp3ddS0yU6SffYRH9vrqVufMx4ujXw6YWP6iAS/+dMxT0WVR+yBwYga7k+J7
aDCwB0+UMLpBBEENQ93C
=F9hx
-----END PGP SIGNATURE-----

--K2tQwhlBGP73abaKGcDOUVGxD1tn7Qc1O--
