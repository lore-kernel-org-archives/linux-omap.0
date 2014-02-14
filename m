From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 03/12] mfd: omap-usb-host: Use clock names as per
 function for reference clocks
Date: Fri, 14 Feb 2014 13:33:30 +0000
Message-ID: <20140214133330.GC13293@lee--X1>
References: <1392200333-28397-1-git-send-email-rogerq@ti.com>
 <1392200333-28397-4-git-send-email-rogerq@ti.com>
 <20140214100915.GD7380@lee--X1>
 <52FE164F.80503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52FE164F.80503@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, bcousson@baylibre.com, balbi@ti.com, nm@ti.com, khilman@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

> >> Use a meaningful name for the reference clocks so that it indicate=
s the function.
> >>
> >> CC: Lee Jones <lee.jones@linaro.org>
> >> CC: Samuel Ortiz <sameo@linux.intel.com>
> >> Signed-off-by: Roger Quadros <rogerq@ti.com>
> >> ---
> >>  drivers/mfd/omap-usb-host.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-ho=
st.c
> >> index 60a3bed..ce620a8 100644
> >> --- a/drivers/mfd/omap-usb-host.c
> >> +++ b/drivers/mfd/omap-usb-host.c
> >> @@ -714,21 +714,21 @@ static int usbhs_omap_probe(struct platform_=
device *pdev)
> >>  		goto err_mem;
> >>  	}
> >> =20
> >> -	omap->xclk60mhsp1_ck =3D devm_clk_get(dev, "xclk60mhsp1_ck");
> >> +	omap->xclk60mhsp1_ck =3D devm_clk_get(dev, "refclk_60m_ext_p1");
> >=20
> > You can't do that. These changes will have to be in the same patch =
as
> > the core change i.e. where they are initialised.
>=20
> I'm not touching them anywhere in this series. When core changes are =
you
> referring to?

The ones in:
  arch/arm/mach-omap2/cclock3xxx_data.c

> >>  	if (IS_ERR(omap->xclk60mhsp1_ck)) {
> >>  		ret =3D PTR_ERR(omap->xclk60mhsp1_ck);
> >>  		dev_err(dev, "xclk60mhsp1_ck failed error:%d\n", ret);
> >>  		goto err_mem;
> >>  	}
> >> =20
> >> -	omap->xclk60mhsp2_ck =3D devm_clk_get(dev, "xclk60mhsp2_ck");
> >> +	omap->xclk60mhsp2_ck =3D devm_clk_get(dev, "refclk_60m_ext_p2");
> >>  	if (IS_ERR(omap->xclk60mhsp2_ck)) {
> >>  		ret =3D PTR_ERR(omap->xclk60mhsp2_ck);
> >>  		dev_err(dev, "xclk60mhsp2_ck failed error:%d\n", ret);
> >>  		goto err_mem;
> >>  	}
> >> =20
> >> -	omap->init_60m_fclk =3D devm_clk_get(dev, "init_60m_fclk");
> >> +	omap->init_60m_fclk =3D devm_clk_get(dev, "refclk_60m_int");
> >>  	if (IS_ERR(omap->init_60m_fclk)) {
> >>  		ret =3D PTR_ERR(omap->init_60m_fclk);
> >>  		dev_err(dev, "init_60m_fclk failed error:%d\n", ret);
> >=20
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
