From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCHv2] omap3: Add basic support for 720MHz part
Date: Thu, 13 Jan 2011 17:21:53 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302483D808D@dbde02.ent.ti.com>
References: <1294857234-1676-1-git-send-email-premi@ti.com>
	<20110113035355.GA2178@manju-desktop>
	<B85A65D85D7EB246BE421B3FB0FBB593024834A32F@dbde02.ent.ti.com>
	<AANLkTiknC64=nqG2ch9e9GA=MK0iazvd4tOO5GPxVjgQ@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302483D803C@dbde02.ent.ti.com>
 <AANLkTi=RJPJEKpPgej+DQ7dWkajxx7=K4WR80j9mNxtc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33503 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932516Ab1AMLwE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jan 2011 06:52:04 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p0DBq0Tt015999
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 13 Jan 2011 05:52:02 -0600
In-Reply-To: <AANLkTi=RJPJEKpPgej+DQ7dWkajxx7=K4WR80j9mNxtc@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: G, Manjunath Kondaiah [mailto:manjugk@ti.com]=20
> Sent: Thursday, January 13, 2011 5:16 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCHv2] omap3: Add basic support for 720MHz part
>=20
> On Thu, Jan 13, 2011 at 4:48 PM, Premi, Sanjeev <premi@ti.com> wrote:
> >> -----Original Message-----
> >> From: G, Manjunath Kondaiah
> >> Sent: Thursday, January 13, 2011 2:58 PM
> >> To: Premi, Sanjeev
> >> Cc: linux-omap@vger.kernel.org
> >> Subject: Re: [PATCHv2] omap3: Add basic support for 720MHz part
> >>
> >
> > [....]
> >
> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> >> >> =A0 =A0 =A0 }
> >> >>
> >> >> Do you see any issues?
> >> >
> >> > Though it is not considered in this patch, but in the=20
> devices that
> >> > don't contain iva, the code related to enabling the iva freq can
> >> > be easily excluded in current flow.
> >>
> >> In this case, the function returns error if we have device with no
> >> iva. The API should
> >> enable only mpu opp and return sane value for devices with no iva.
> >>
> >
> > [sp] Don't want to get into details of next patch here, but=20
> when there
> > is no IVA, the "if" condition for for iva won't/shouldn't=20
> be entered.
> exactly
> >
> > Values returned should just be the status opp_enable. OR am=20
> I missing
> > something in your comment.
> > e.g.
> > =A0 =A0 =A0 =A0pdev =3D oh_mpu->od->pdev;
> > =A0 =A0 =A0 =A0r =3D opp_enable(&pdev->dev, 720000000);
> > =A0 =A0 =A0 =A0if (r < 0) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "Unable to enabl=
e OPP=20
> for mpu.\n");
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err;
> > =A0 =A0 =A0 =A0}
> >
> > =A0 =A0 =A0 =A0if omap3_has_iva()) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0oh_iva =3D omap_hwmod_lookup("iva");=
 //move=20
> from current impl.
>=20
> This looks fine and it can translate into:
> 	if (!oh_mpu || !oh_mpu->od)
>                goto err_nodevice;
>=20
>        pdev =3D oh_mpu->od->pdev;
>        r =3D opp_enable(&pdev->dev, 720000000);
>        if (r < 0)
>                goto err_oppenable;
>=20
> 	if (!omap3_has_iva())
> 		goto err_nodevice;

Not having an IVA is not error! and goto's really aren't saving anythin=
g.

>=20
> 	r =3D -ENODEV;
> 	if(!oh_iva || !oh_iva->od)
>                goto err_nodevice;
>=20
>        pdev =3D oh_iva->od->pdev;
>        r =3D opp_enable(&pdev->dev, 520000000);
>        if (r < 0)
>                goto err_oppenable;
>=20
> 	return r;
>=20
> err_oppenable:
> 	dev_err(&pdev->dev, "Unable to enable OPP\n");
> err_nodevice:
> 	return r;
>=20
> -Manjunath
>=20
> [...]
> --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
