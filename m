From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PM-SR] [PATCH 5/7] omap3: sr: device: add unlikely checks
Date: Fri, 09 Jul 2010 16:12:28 +0300
Message-ID: <1278681148.9953.110.camel@localhost>
References: <1277502400-9915-1-git-send-email-nm@ti.com>
	 <1277502400-9915-6-git-send-email-nm@ti.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58096 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755535Ab0GINQ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jul 2010 09:16:59 -0400
In-Reply-To: <1277502400-9915-6-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>

On Fri, 2010-06-25 at 16:46 -0500, Nishanth Menon wrote:
> Add unlikely checks to better optimize the rare occurrance of
> erroneous conditions.
>=20
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Thara Gopinath <thara@ti.com>
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>

unlikely and friends make sens only in realy hot path places. In other
places like you touch, they are pointless - better let gcc make a choic=
e
of how to arrange code. And they only make the code less readable by
adding extra braces and making ifs longer.

Thus, NACK for this from my side.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
