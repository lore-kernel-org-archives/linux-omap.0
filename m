From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 0/2] Device tree support for TWL regulators
Date: Tue, 28 Feb 2012 10:18:50 +0000
Message-ID: <20120228101850.GA3121@opensource.wolfsonmicro.com>
References: <1330338961-31765-1-git-send-email-rnayak@ti.com>
 <4F4B73C8.8070807@ti.com>
 <4F4B7798.6000300@ti.com>
 <20120227134112.GB3191@opensource.wolfsonmicro.com>
 <4F4B8A85.7060603@ti.com>
 <20120227140356.GF3191@opensource.wolfsonmicro.com>
 <4F4B9166.7020909@ti.com>
 <20120227145345.GJ3191@opensource.wolfsonmicro.com>
 <4F4C691C.2000600@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:42255 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753386Ab2B1KSx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Feb 2012 05:18:53 -0500
Content-Disposition: inline
In-Reply-To: <4F4C691C.2000600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, tony@atomide.com, Peter Ujfalusi <peter.ujfalusi@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lrg@ti.com, patches@linaro.org, linaro-dev@lists.linaro.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 28, 2012 at 11:11:48AM +0530, Rajendra Nayak wrote:

> changes have no dependencies with any other DT series. I will repost
> all of Tero/Peter and my changes (to add DT support to the driver) as
> one single series and drop the dts file updates, which I guess can go
> via Tony/OMAP tree.

Yes, that sounds like a good plan - the DTS changes are largely
orthogonal to the code changes and don't need to go via the same path
(this is true in general, the DTSs are pretty horrible for merge
issues).

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPTKoCAAoJEBus8iNuMP3dXUwQAJksUfrnuTiJCJGtLXkOQ5Qz
hEXHt14rxffPtoI/IIWLx6VNTu/p7jRrBiQY+/jVYrmk7PfuWtS26GIoxHj7z7XS
yJGWzaoex2AXqg3YLtJbdkuwF7VfL7l+U5eTZ4Nasr93DlAqMb63zd7IVkploac4
g/++o/Re0JEGAPRI0Q+zL+oc07XdBThAO4tttBpcUwU9prFnOn5sbBRq856hafFi
KEH8hXaC0IXRCyYsZuRZaNZVnx4ar1U2NANotg8Wta/wbRW8gxRI8T2h4/wzSznF
mls/4d7uKyDKxwN3p6N7LLjr9qjhGZyEWgm/niFOeSIpRr0tc9MON5cSMgqp7uj/
GpfnAZsEtz/Gd4GHKJDib8yXrWkwDx6bgqkbOmxOP4LqZABu9neK1q2CAdXYTbnp
4iZqGdJ7sA6s4amC/NBDWaradJJFK46VuxXT2PakssmXI8lcPTHZ0wUYnqqtlSXz
DecTPTbOltd/rF40l17Dkz17G08HV0BDwHTTGOfI5XKcAe0LDTPRPvHegnxw0p+d
9CigLOKNaR3FN8Ph8bFybBPq5HN8HlZmOOzdE6ShPJebQHU+kpr6bMMImcytREJQ
qKBIjR9CLOyehUc0gPq+PZsDDOQVSJRLSdHcn0Z+SHPE81x7W40bdD0pCy1cDhjK
5+Vw4iSZXNMdsFIPtODw
=tnn1
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
