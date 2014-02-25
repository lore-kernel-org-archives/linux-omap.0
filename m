From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v8 03/14] mfd: omap-usb-host: Use clock names as per
 function for reference clocks
Date: Tue, 25 Feb 2014 09:18:39 +0000
Message-ID: <20140225091839.GE19099@lee--X1>
References: <1392896409-5101-1-git-send-email-rogerq@ti.com>
 <1392896409-5101-4-git-send-email-rogerq@ti.com>
 <20140225085234.GB19099@lee--X1>
 <530C5C29.1090503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:45182 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbaBYJSt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Feb 2014 04:18:49 -0500
Received: by mail-we0-f176.google.com with SMTP id p61so91801wes.7
        for <linux-omap@vger.kernel.org>; Tue, 25 Feb 2014 01:18:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <530C5C29.1090503@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, bcousson@baylibre.com, balbi@ti.com, nm@ti.com, khilman@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

> >> Use a meaningful name for the reference clocks so that it indicate=
s the function.
> >>
> >> CC: Lee Jones <lee.jones@linaro.org>
> >> CC: Samuel Ortiz <sameo@linux.intel.com>
> >> Signed-off-by: Roger Quadros <rogerq@ti.com>
> >> ---
> >>  drivers/mfd/omap-usb-host.c | 12 ++++++------
> >>  1 file changed, 6 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-ho=
st.c
> >> index 865c276..651e249 100644
> >> --- a/drivers/mfd/omap-usb-host.c
> >> +++ b/drivers/mfd/omap-usb-host.c
> >> @@ -718,24 +718,24 @@ static int usbhs_omap_probe(struct platform_=
device *pdev)
> >>  		goto err_mem;
> >>  	}
> >> =20
> >> -	omap->xclk60mhsp1_ck =3D devm_clk_get(dev, "xclk60mhsp1_ck");
> >> +	omap->xclk60mhsp1_ck =3D devm_clk_get(dev, "refclk_60m_ext_p1");
> >>  	if (IS_ERR(omap->xclk60mhsp1_ck)) {
> >>  		ret =3D PTR_ERR(omap->xclk60mhsp1_ck);
> >> -		dev_err(dev, "xclk60mhsp1_ck failed error:%d\n", ret);
> >> +		dev_err(dev, "refclk_60m_ext_p1 failed error:%d\n", ret);
> >>  		goto err_mem;
> >>  	}
> >=20
> > Will anything break if I were to apply the MFD patches seperately?
> >=20
>=20
> Nothing will break for OMAP3, but OMAP4 USB host will break (e.g. Pan=
da board).
> OMAP5 USB host was never working so it doesn't matter there.
>=20
> To make sure nothing breaks, we need at least these 2 patches to go i=
n together with mfd changes.
>=20
> [PATCH v8 08/14] ARM: dts: omap4: Update omap-usb-host node
> [PATCH v8 09/14] ARM: dts: omap5: Update omap-usb-host node
>=20
> Any suggestions about how we can proceed?

Yes, unfortunately you have to squash each of the patches into one
patch. Applying a patch which breaks a build, then applying another one
immediately after which subsequently fixes the break is not an acceptab=
le
way of working I'm afraid. What would happen if we were to fall into
the middle of the two patches when bisecting?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
