From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/6] OMAPDSS: DISPC: Remove cpu_is_xxxx checks
Date: Tue, 07 Aug 2012 13:57:26 +0300
Message-ID: <1344337046.4091.32.camel@deskari>
References: <cover.1343912532.git.cmahapatra@ti.com>
	 <5344e530a125ef5c5dfeb00e54b7d32df6169aa9.1343912532.git.cmahapatra@ti.com>
	 <20120807084815.GK8468@arwen.pp.htv.fi> <1344330329.4091.16.camel@deskari>
	 <20120807091415.GN8468@arwen.pp.htv.fi> <1344331672.4091.22.camel@deskari>
	 <20120807093207.GO8468@arwen.pp.htv.fi> <1344333436.7216.32.camel@lappyti>
	 <20120807102712.GP8468@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-E9WbgyGgSJLGHf/KYGnh"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:48024 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753651Ab2HGK5b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 06:57:31 -0400
Received: by lboi15 with SMTP id i15so927735lbo.35
        for <linux-omap@vger.kernel.org>; Tue, 07 Aug 2012 03:57:28 -0700 (PDT)
In-Reply-To: <20120807102712.GP8468@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Chandrabhanu Mahapatra <cmahapatra@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>


--=-E9WbgyGgSJLGHf/KYGnh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-08-07 at 13:27 +0300, Felipe Balbi wrote:
> Hi,

> > Yes, they can be overridden, but I think it's still quite difficult to
> > manage. DSS is modeled with multiple blocks, also in DT data. So you'd
> > need to override multiple entries.
> >=20
> > And it'd also require a new dts file for each version of your board wit=
h
> > different ES version.
> >=20
> > Also, I don't really see why this information would need to be present
> > in the DT data (especially as it's not simple). It's all trivially foun=
d
> > out in the code, by using cpu_is & soc_is.
>=20
> Fair enough. I just think we should remove all cpu_is_* and soc_is_*
> from drivers.

I agree, that's part of the idea here. Instead of having cpu_is checks
all around, we'll have them in only certain centralized places. Then
it's easier to implement a way to move them totally out of the driver,
when we come up with a good idea how to accomplish that.

 Tomi


--=-E9WbgyGgSJLGHf/KYGnh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQIPSWAAoJEPo9qoy8lh71yAAP/R81avoKPtGkrC4xuuV3sA7N
yvoTE5/W34gVNsJYPdCx3HZG67OD5bLtw+DkOx71EgeMsjNVJgV2I6J49aVB0JFF
qpqQdyXkL/N4VLFVExM453j/ooqAMnOC+Jy11eCpmGWfN1Vl5oveJhTZL4BWl+Xc
zDIr/lnms4dK++lC1NXuT1b4oWHl6smN7WQwZLI0VnMU50tT66ZpgZKYSz01oybl
qk9AqIlCIJhV0ZSn/1qOjIRnTjtrrEXznDZF13RkasEESwaMhi87XaC6eJ4UZg4k
/+NCcXczgJW/2WEwWzIWOS3yc0omEtwyCKfWNwqmNAnrajxJdldC/JcIyx/iyVYi
ypZXHYoIhM1+96QQyaRXgg0yDf9a35sSXgSR7Vu3Y+OjssdE3zMO4YiAIaYY0IBA
s/XYfze8vH8Q00cii0WcNnB0OQ35/nXAM/S/xhPel3PaW1YJzXmyJQQVpWcPombw
d0swocHxsGaPq3T5se321PReaAlLQJWJSNsY5xo6T3rEuZpF4W1l0ji4jz4xMem6
mGbqQTnCoNdAWIBAyek9lHNm0KJGUimn/q7RgCuj9Des6rXsNaVohUpSl+SpC59o
s/VWKb4EMMM3xHUcujdIczAwrlEkG3g+PtDoDk/Jq+IM1/OVvZz4ZB8IFEsZpdZk
IxbFlRY8Da8R90szc1UP
=j8CA
-----END PGP SIGNATURE-----

--=-E9WbgyGgSJLGHf/KYGnh--

