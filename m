From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCHv2] omap3: Add basic support for 720MHz part
Date: Thu, 13 Jan 2011 17:16:14 +0530
Message-ID: <AANLkTi=RJPJEKpPgej+DQ7dWkajxx7=K4WR80j9mNxtc@mail.gmail.com>
References: <1294857234-1676-1-git-send-email-premi@ti.com>
	<20110113035355.GA2178@manju-desktop>
	<B85A65D85D7EB246BE421B3FB0FBB593024834A32F@dbde02.ent.ti.com>
	<AANLkTiknC64=nqG2ch9e9GA=MK0iazvd4tOO5GPxVjgQ@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302483D803C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:45615 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932641Ab1AMLqQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Jan 2011 06:46:16 -0500
Received: by bwz14 with SMTP id 14so1388297bwz.16
        for <linux-omap@vger.kernel.org>; Thu, 13 Jan 2011 03:46:15 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302483D803C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Jan 13, 2011 at 4:48 PM, Premi, Sanjeev <premi@ti.com> wrote:
>> -----Original Message-----
>> From: G, Manjunath Kondaiah
>> Sent: Thursday, January 13, 2011 2:58 PM
>> To: Premi, Sanjeev
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: [PATCHv2] omap3: Add basic support for 720MHz part
>>
>
> [....]
>
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> >> =A0 =A0 =A0 }
>> >>
>> >> Do you see any issues?
>> >
>> > Though it is not considered in this patch, but in the devices that
>> > don't contain iva, the code related to enabling the iva freq can
>> > be easily excluded in current flow.
>>
>> In this case, the function returns error if we have device with no
>> iva. The API should
>> enable only mpu opp and return sane value for devices with no iva.
>>
>
> [sp] Don't want to get into details of next patch here, but when ther=
e
> is no IVA, the "if" condition for for iva won't/shouldn't be entered.
exactly
>
> Values returned should just be the status opp_enable. OR am I missing
> something in your comment.
> e.g.
> =A0 =A0 =A0 =A0pdev =3D oh_mpu->od->pdev;
> =A0 =A0 =A0 =A0r =3D opp_enable(&pdev->dev, 720000000);
> =A0 =A0 =A0 =A0if (r < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "Unable to enable =
OPP for mpu.\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if omap3_has_iva()) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0oh_iva =3D omap_hwmod_lookup("iva"); /=
/move from current impl.

This looks fine and it can translate into:
	if (!oh_mpu || !oh_mpu->od)
               goto err_nodevice;

       pdev =3D oh_mpu->od->pdev;
       r =3D opp_enable(&pdev->dev, 720000000);
       if (r < 0)
               goto err_oppenable;

	if (!omap3_has_iva())
		goto err_nodevice;

	r =3D -ENODEV;
	if(!oh_iva || !oh_iva->od)
               goto err_nodevice;

       pdev =3D oh_iva->od->pdev;
       r =3D opp_enable(&pdev->dev, 520000000);
       if (r < 0)
               goto err_oppenable;

	return r;

err_oppenable:
	dev_err(&pdev->dev, "Unable to enable OPP\n");
err_nodevice:
	return r;

-Manjunath

[...]
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
