From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCHv2] omap3: Add basic support for 720MHz part
Date: Thu, 13 Jan 2011 16:48:49 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302483D803C@dbde02.ent.ti.com>
References: <1294857234-1676-1-git-send-email-premi@ti.com>
	<20110113035355.GA2178@manju-desktop>
	<B85A65D85D7EB246BE421B3FB0FBB593024834A32F@dbde02.ent.ti.com>
 <AANLkTiknC64=nqG2ch9e9GA=MK0iazvd4tOO5GPxVjgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33479 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756627Ab1AMLS6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jan 2011 06:18:58 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p0DBItHu015597
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 13 Jan 2011 05:18:57 -0600
In-Reply-To: <AANLkTiknC64=nqG2ch9e9GA=MK0iazvd4tOO5GPxVjgQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: G, Manjunath Kondaiah=20
> Sent: Thursday, January 13, 2011 2:58 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCHv2] omap3: Add basic support for 720MHz part
>=20

[....]

> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> >> =A0 =A0 =A0 }
> >>
> >> Do you see any issues?
> >
> > Though it is not considered in this patch, but in the devices that
> > don't contain iva, the code related to enabling the iva freq can
> > be easily excluded in current flow.
>=20
> In this case, the function returns error if we have device with no
> iva. The API should
> enable only mpu opp and return sane value for devices with no iva.
>=20

[sp] Don't want to get into details of next patch here, but when there
is no IVA, the "if" condition for for iva won't/shouldn't be entered.

Values returned should just be the status opp_enable. OR am I missing
something in your comment.
e.g.
	pdev =3D oh_mpu->od->pdev;
	r =3D opp_enable(&pdev->dev, 720000000);
	if (r < 0) {
		dev_err(&pdev->dev, "Unable to enable OPP for mpu.\n");
		goto err;
	}

	if omap3_has_iva()) {
		oh_iva =3D omap_hwmod_lookup("iva"); //move from current impl.

		pdev =3D oh_iva->od->pdev;
		r =3D opp_enable(&pdev->dev, 520000000);
		if (r < 0) {
			dev_err(&pdev->dev, "Unable to enable OPP for iva.\n");
			goto err;
		}
	}

~sanjeev

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
