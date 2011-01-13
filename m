From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCHv2] omap3: Add basic support for 720MHz part
Date: Thu, 13 Jan 2011 14:58:27 +0530
Message-ID: <AANLkTiknC64=nqG2ch9e9GA=MK0iazvd4tOO5GPxVjgQ@mail.gmail.com>
References: <1294857234-1676-1-git-send-email-premi@ti.com>
	<20110113035355.GA2178@manju-desktop>
	<B85A65D85D7EB246BE421B3FB0FBB593024834A32F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:38244 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932610Ab1AMJ2a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Jan 2011 04:28:30 -0500
Received: by bwz16 with SMTP id 16so1497731bwz.18
        for <linux-omap@vger.kernel.org>; Thu, 13 Jan 2011 01:28:28 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024834A32F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Jan 13, 2011 at 12:33 PM, Premi, Sanjeev <premi@ti.com> wrote:
>> -----Original Message-----
>> From: G, Manjunath Kondaiah [mailto:manjugk@ti.com]
>> Sent: Thursday, January 13, 2011 9:24 AM
>> To: Premi, Sanjeev
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: [PATCHv2] omap3: Add basic support for 720MHz part
>>
>> Hi Sanjeev,
>>
> [snip]...[snip]
>
>> > =A0 =A0 =A0*/
>> > +
>> > + =A0 /*
>> > + =A0 =A0* Does it support 720MHz?
>> > + =A0 =A0*/
>> multiline style comment
> [sp] This is used many places.

It will be good if we fix that also.

>Don't see any issue with it.
> =A0 =A0 unless you really want to see this on single line.

It is mentioned in http://www.kernel.org/doc/Documentation/CodingStyle

>
>> > + =A0 status =3D (OMAP3_SKUID_MASK & read_tap_reg(OMAP3_PRODID));
>> > +
>> > + =A0 if (status & OMAP3_SKUID_720MHZ) {
>> > + =A0 =A0 =A0 =A0 =A0 omap3_features |=3D OMAP3_HAS_720MHZ;
>> > + =A0 }
>> braces not required
>
> [sp] Will change. forgot to remove after moving code to a
> =A0 =A0 different function.
>
>> > =A0}
>
> [snip]...[snip]
>
>> > + =A0 =A0 =A0 =A0 =A0 r =3D opp_enable(&(oh_mpu->od->pdev.dev), 72=
0000000);
>> > + =A0 =A0 =A0 =A0 =A0 if (r < 0) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Unable to enable=
 OPP for
>> mpu.", __func__);
>> since you have dev pointer, pr_err can be replaced with dev_err
>
> [sp] Idea was to get to this function - in case of error; but can
> =A0 =A0 be changed as well.

you can also use __func__ with dev_err but it may not be required
since dev_err provides
enough information about the error.

>
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> > + =A0 =A0 =A0 =A0 =A0 }
>> > + =A0 }
>> > +
>> > + =A0 if (!oh_iva || !oh_iva->od) {
>> > + =A0 =A0 =A0 =A0 =A0 r =3D -ENODEV;
>> > + =A0 =A0 =A0 =A0 =A0 goto err;
>> > + =A0 } else {
>> > + =A0 =A0 =A0 =A0 =A0 r =3D opp_enable(&(oh_iva->od->pdev.dev), 52=
0000000);
>> > + =A0 =A0 =A0 =A0 =A0 if (r < 0) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Unable to enable=
 OPP for
>> iva.", __func__);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> > + =A0 =A0 =A0 =A0 =A0 }
>> > + =A0 }
>> Can be optimized as(not tested and compiled):
>>
>> =A0 =A0 =A0 struct platform_device *pdev;
>
> [sp] Like this! ... to get to "dev".
>
>> =A0 =A0 =A0 struct omap_hwmod *oh_mpu =3D omap_hwmod_lookup("mpu");
>> =A0 =A0 =A0 struct omap_hwmod *oh_iva =3D omap_hwmod_lookup("iva");
>> =A0 =A0 =A0 int r =3D -ENODEV;
>>
>> =A0 =A0 =A0 if (!oh_mpu || !oh_mpu->od || !oh_iva || !oh_iva->od)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>>
>> =A0 =A0 =A0 pdev =3D oh_mpu->od->pdev;
>> =A0 =A0 =A0 r =3D opp_enable(&pdev->dev, 720000000);
>> =A0 =A0 =A0 if (r < 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Unable to enable OP=
P for mpu.\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 pdev =3D oh_iva->od->pdev;
>> =A0 =A0 =A0 r =3D opp_enable(&pdev->dev, 520000000);
>> =A0 =A0 =A0 if (r < 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Unable to enable OP=
P for iva.\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> =A0 =A0 =A0 }
>>
>> Do you see any issues?
>
> Though it is not considered in this patch, but in the devices that
> don't contain iva, the code related to enabling the iva freq can
> be easily excluded in current flow.

In this case, the function returns error if we have device with no
iva. The API should
enable only mpu opp and return sane value for devices with no iva.

-Manjunath
[...]
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
