From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 00/15] Device Tree schemas and validation
Date: Wed, 2 Oct 2013 19:08:41 +0100
Message-ID: <20131002180841.GG27287@sirena.org.uk>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
 <524A8289.3050107@baylibre.com>
 <524ACB76.1010001@gmail.com>
 <524AE4FB.4080906@baylibre.com>
 <CAL_JsqJ31TGFJCSeSOqgee=OLVfSUTAYdF4nSn7X2DiCequVAw@mail.gmail.com>
 <20131002135450.GH6506@voom.fritz.box>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z+pzSjdB7cqptWpS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:52091 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603Ab3JBSJT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Oct 2013 14:09:19 -0400
Content-Disposition: inline
In-Reply-To: <20131002135450.GH6506@voom.fritz.box>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Rob Herring <robherring2@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Stephen Warren <swarren@wwwdotorg.org>, Tomasz Figa <tomasz.figa@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, fparent@baylibre.com, Benoit Cousson <bcousson@baylibre.com>, Olof Johansson <olof@lixom.net>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--z+pzSjdB7cqptWpS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 02, 2013 at 11:54:50PM +1000, David Gibson wrote:
> On Tue, Oct 01, 2013 at 03:54:20PM -0500, Rob Herring wrote:

> > I would expect the schema to replace
> > Documentation/devicetree/bindings/* over time. I think the thing that
> > needs to be worked out here is how to add free form multi-line text.

> I'm not convinced that's a realistic goal.  As I see it, the
> fundamental difference between a binding document and a formal schema
> is that a binding defines both the syntax required of a node, and its
> semantics, whereas a schema defines only syntax - the semantics still
> need to be defined somewhere.

So long as the schema lets you include free form text to define the
semantics I'm not sure there's an incompatibility there - the same
document can cover both.

--z+pzSjdB7cqptWpS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSTGEmAAoJELSic+t+oim9AcIP/0P2kS3rVyZaWAN+CwvZQeGL
DTfOvx92yl1cY8fguQCPMvsUs44XMrx+m+xIloxmL5v6TXNpm2rSNESTHsmYsgEF
rAwCfApz3eFSg0wfa7OKhuvGebPuPyod1KRorge2wlZdn09aVtpWQjLFAhx/xpUs
ULpVDpTjWgcCSIMfNPZdRdPjKokImoHIYCY2lMmozizJm0kMsqMmo3zA8WNKzWbo
lXYsQ0CyKs2RGKTkRXGCPSyWkgeJl7VEss9cvq92C3sSmnt7/VTsoAR7fo/mdU/b
YDXVD1O+ZAm2ogTvYasIBNljYWh89jq4y7yH8I0BWH50NtzJdOKsmrpd0GJCa3qM
GGsTnil0nMLftXdZIQDUkr8m79VdEBv03hcMdCGdZmLejBKL+lWZgQKZzIeR7tph
ZUXRz12WtqVnUBgIz0lTV8tNcE2Q2WwN2/Lv0hdIaCHnPk+/ur0Uig8OR8Za4hi4
w2VKuxwGW2roLbof91/W8xn2LhhJQ8CPPy7LbbnDyXR9Rs4/XPv3D54bM5sdo2i5
k0n6EwDaYjJtELTM/E1QUxMvgKNj+ryqOBYs6X3EU57w4hJnqYXiN4cPrY0x264w
4OQtUZyfmGK5hQ1IVn0UvKpjJ0NyLQ+sAri6p/JMvAH2FoBHhZ5nFjenO2iaxQzP
yVaq6kOeCfRytSnHdIP+
=AUeA
-----END PGP SIGNATURE-----

--z+pzSjdB7cqptWpS--
