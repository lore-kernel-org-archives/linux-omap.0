From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 13/26] ARM: omap3.dtsi: add omapdss information
Date: Fri, 13 Dec 2013 12:18:27 +0200
Message-ID: <52AADEF3.9040808@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <52A9760A.3000801@ti.com> <20131212215913.GB29072@muru.com> <1933495.zHe4JMYZyB@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="5aVIQkVg1o8jbUKfOcRFKlB17XSEOj5G9"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56533 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319Ab3LMKSf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Dec 2013 05:18:35 -0500
In-Reply-To: <1933495.zHe4JMYZyB@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>

--5aVIQkVg1o8jbUKfOcRFKlB17XSEOj5G9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-13 05:27, Laurent Pinchart wrote:
> Hi Tony,
>=20
> On Thursday 12 December 2013 21:59:13 Tony Lindgren wrote:
>> On Thu, Dec 12, 2013 at 10:38:34AM +0200, Tomi Valkeinen wrote:
>>> On 2013-12-12 01:44, Laurent Pinchart wrote:
>>>
>>> So, are they independent? I don't know =3D). I think they lean on the=

>>> independent side. dss_core is always needed for the submodules to wor=
k,
>>> but for example DSI could be used without DISPC, using system DMA to
>>> transfer data from memory to DSI. Not a very useful thing to do, but
>>> still, there are dedicated DMA channels for that.
>>
>> If they have separate hwmod entries, they should be considered separat=
e
>> independent devices for sure.
>>
>> To summarize, here are few reasons why they need to be treated as
>> separate devices:
>=20
> Are you talking generally here, or about the DSS modules in particular =
?
>=20
>> 1. The modules maybe clocked/powered/idled separately and can have the=
ir
>>    own idle configuration so they can do the hardware based idling
>>    separately.
>=20
> I don't think this applies to the DSS modules.

The DSS submodules have their own SYSCONFIG register, and idle settings
can be set per module. So I think they idle separately, even if they are
in a common power domain.

 Tomi



--5aVIQkVg1o8jbUKfOcRFKlB17XSEOj5G9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSqt7zAAoJEPo9qoy8lh71MM0P/2TFaj5hR7AbBT+4MTlnettS
CivDSUs6NxyEybhIb+9WpkVuEouUiQZfuYMr2AE77+/S0V/kymQBOV/eN7c1V8e+
76I4aI4UB5K9FIAohbdoLXBOlJ4koUUBPDH2YKlavnYRAUrZzv33DooGml0Aw5t0
LOpEmsJOdljKaQDgK4gbbcJAHsB+se8q/i8uygGwpPCMi8rgimhobecGZYQtwVvU
Uqpyl1rjLtkb/blxTjGPPfPsUlK6pLwOlaDrIQOO8hPoaD5nIRPlCRsUf0hI2auo
EcnzxODMGp/D3VWaXmp3X1gitvbEALJlTE4einE+x5Y4BP39XphFJdStDM/kdZYF
DD6KYHQQQzXXs2Kyh/XOEoXGCkDd8SklWV6EqUtAeoZtmT+qxkrLTFrm7GkeXoYN
hKpGA57/yMGPNQJCSwSVfc3RsfAJEiPK8BCi43T1WJiVeAx7xQhIHW9MnhAzsirB
sH2Y6xuATR3zrbHpU94TUo9U2SRRLlgHXcrVelUxbg4S5cKEtwnDrrxqR03XnrpN
SQGj9TfEO3YbVdqu0ToXBJWfUr5u6wY2uoo8SyGYMUQW63Ogv/E8G/Y3cz3oDWLK
FggsefdhHRqRa1RhO3/K1WG4SyXgvT2Nb+QoY7uBB54AgWO1YezrtafuGFwDZObW
0YJD3aI82EU8fQjnXLD4
=a/CY
-----END PGP SIGNATURE-----

--5aVIQkVg1o8jbUKfOcRFKlB17XSEOj5G9--
