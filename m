From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: Shouldn't DT preserve pdev name and id to allow platform_match to work?
Date: Wed, 3 Aug 2011 21:47:17 +0530
Message-ID: <CAC63_iRa1qc7pO9Eub1A+cC+R=tSkwzigVPDHqcbvOngACYWqQ@mail.gmail.com>
References: <4E396361.3060307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:59305 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753709Ab1HCQRT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Aug 2011 12:17:19 -0400
Received: by mail-ey0-f172.google.com with SMTP id 4so208572eye.31
        for <linux-omap@vger.kernel.org>; Wed, 03 Aug 2011 09:17:17 -0700 (PDT)
In-Reply-To: <4E396361.3060307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, "Nayak, Rajendra" <rnayak@ti.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Benoit,

On Wed, Aug 3, 2011 at 8:34 PM, Cousson, Benoit <b-cousson@ti.com> wrot=
e:
> Hi Grant,
>
> Going further with the usage of OF_DEV_AUXDATA_ID, I realized that th=
is is is not doing what I was expecting. My expectation might be silly,=
 but in order to make platform_match to work without DT matching mechan=
ism, you need to have the driver name in the pdev->name field:
>
> =A0 =A0 =A0 =A0/* fall-back to driver name match */
> =A0 =A0 =A0 =A0return (strcmp(pdev->name, drv->name) =3D=3D 0);
>
> Except that the of_device_add function is doing that:
> =A0 =A0 =A0 =A0pdev->name =3D dev_name(&ofdev->dev);
> =A0 =A0 =A0 =A0pdev->id =3D -1;

This is taken here:
http://git.secretlab.ca/?p=3Dlinux-2.6.git;a=3Dcommitdiff;h=3D04f51955d=
c690666467252015a931d71d5c56696

and it is pending for upstream.

With the above patch, both pdev->name and pdev->id can be set as per
hwmod requirement through aux_data
lookup table. we might have to append pdev->id to pdev->name so that
it can used for device look up in the hwmod
device list.

-Manjunath
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
