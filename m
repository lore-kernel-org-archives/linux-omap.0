From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Shouldn't DT preserve pdev name and id to allow platform_match to work?
Date: Wed, 3 Aug 2011 17:43:55 +0100
Message-ID: <CACxGe6vg5NTyiDZqqztjtFEfb7si+-=Y7nEy1Y+YMgA5PVXScw@mail.gmail.com>
References: <4E396361.3060307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49438 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077Ab1HCQoR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Aug 2011 12:44:17 -0400
Received: by eyx24 with SMTP id 24so869648eyx.33
        for <linux-omap@vger.kernel.org>; Wed, 03 Aug 2011 09:44:16 -0700 (PDT)
In-Reply-To: <4E396361.3060307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nayak, Rajendra" <rnayak@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "G, Manjunath Kondaiah" <manjugk@linaro.org>

On Wed, Aug 3, 2011 at 4:04 PM, Cousson, Benoit <b-cousson@ti.com> wrot=
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

Yes, I know.  It is written that way on purpose so that it doesn't get
used to avoid adding a match table to the device driver because
auxdata is a stop-gap solution.  It is *not* intended to be used long
term (with one exception for passing platform callbacks when there is
no other solution).

auxdata passes platform_data and overrides the device name when there
is no way easy way to make the driver work without it.  It handles the
the current implementation of clocks and regulators which aren't yet
populated from the device tree.  It will go away when clock &
regulator bindings are implemented.

By implementing it the way it is, it ensures that no drivers
inadvertently depends on auxdata, and will thus break when the auxdata
entries are removed.  Manjunath mentioned that there is a patch that
allows the id to be set, but it still doesn't set the driver name in a
way that will allow existing drivers to bind using the old method, and
that is by design.

I understand what you are asking for, but the DT matching mechanism is
absolutely required.  Adding it to drivers is certainly not any more
onerous that maintaining a bunch of auxdata tables for boards.
Besides, part of the point of the move to DT is to eliminate device
and device data tables at the board file level, which is another
reason why auxdata is a temporary solution.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
