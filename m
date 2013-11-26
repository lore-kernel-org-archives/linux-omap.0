From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 6/6] OMAPDSS: use runtime PM's autosuspend
Date: Tue, 26 Nov 2013 12:27:47 +0200
Message-ID: <529477A3.3050301@ti.com>
References: <1384779009-10512-1-git-send-email-tomi.valkeinen@ti.com> <1384779009-10512-7-git-send-email-tomi.valkeinen@ti.com> <5292A7F4.8030106@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="aTb0CmkDH5hihAtOGLJt2WfhcWmTrtux8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54216 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755345Ab3KZK1t (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Nov 2013 05:27:49 -0500
In-Reply-To: <5292A7F4.8030106@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

--aTb0CmkDH5hihAtOGLJt2WfhcWmTrtux8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-11-25 03:29, Archit Taneja wrote:
> On Monday 18 November 2013 06:20 PM, Tomi Valkeinen wrote:
>> Use runtime PM's autosuspend support with delay of 100ms.
>>
>> This will prevent the driver from turning the DSS modules off and on
>> multiple times e.g. when loading the module.
>=20
> Could you explain this a bit more?

First of all, I'm not quite sure if this is even needed. Things are
probably simpler without autosuspend, and we don't have much on/off
cycles going on in DSS, so I don't think autosuspend helps much.

Maybe it's even bad if somebody wants to enable/disable the DSS HW very
quickly. So in the minimum, autosuspend should be made configurable. For
now, I think I'll just leave it out.

> Are you saying that when we insert the omapdss module, we have a lot of=

> runtime_get/put pairs in probe, which leads to us excessive writing of
> DISPC the registers during resume, and the autosuspend feature would
> delay the effect of runtime_put() for a while?

For example, first DSS is probed. the dss.c driver will enable dss_core
(i.e. the whole DSS hw block), do some register reads/writes, and
disable dss_core. Then DISPC is probed, and things go very much like
with DSS. And so on. Each submodule will enable and disable the whole
DSS, because nothing is keeping the DSS enabled between the probes.

With autosuspend, the DSS HW block will stay enabled long enough so the
next probe gets ran.

> Also, do we need to do this for all the platform devices? Could we use
> autosuspend only for the parent platform device, and the children
> platform devices don't use it? Or am I understanding things wrongly her=
e?

In theory, yes. In practice, if I'm not mistaken, no. When a device is
enabled, it'll enable the parent device. When the device is disabled,
its parent device will be immediately disabled (if nothing is using it),
so autosuspend doesn't have an effect there.

So we need to use autosuspend for the child devices.

 Tomi



--aTb0CmkDH5hihAtOGLJt2WfhcWmTrtux8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSlHejAAoJEPo9qoy8lh71PusP/3S4afaNgtXtMXkzlfmuSNLX
MSqEVwAnG33bY6m7kNggSex3ISGJjsyqOBeYouzaqYCDviFNKbR9mUauB3DyHADQ
E3YrdLpwItx2Nza6mwXBlmlCFCHspDU+PRWZhhYAjnbibWBYUEUngRcjUUsNQVR3
llzGVyEHErIb6RXy4Y/SiVF8cSFJbv3D5ehqRoMPg7/9ghPHNU1taEivWFfLWdf4
GxKr3SAzHMWW64oV00cAfL6p7EaHRs5LmBuFm2HDzKBod6fin4t2gCHNNDoEDhYp
aHx8zECyBFWReBlH2qpSyQDLowsIDZWXdb3ZtokTy5G6IMjWAuPqoPV9vGghqNiA
HzJKBOxS/hFnAHpo8DBmooWhcvKOE+XWNO5lzvuU0fFH3kNFHbXstBqMDp65APAw
MfL6LzKSZH3UTueOd5KkOS7C0vFRdUUSUpsl9M/EDWElu2ALaHeEZkWASCzLeen0
zV/IavKDpiH3AuOcwjhTOcu14iNh0JM145LGOivQN/D+qF9/TU+BLXtI4Kj7ANf2
mZ934dFfK+SrT4f1Ew5TAMwcGDIfkYvUnuqmdvTIRTWT0lN/bW4ae6x5ewhiEr/c
E5t/w6U5T63/ecqGzxejB/B1Rpya3XBjjiKpSusgcuArycRwybIor0NI2izLvV+1
9xOYHnZijg9CnGwk1sXL
=iFL+
-----END PGP SIGNATURE-----

--aTb0CmkDH5hihAtOGLJt2WfhcWmTrtux8--
