From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 2/9] mfd: omap-usb-host: Get clocks based on hardware
 revision
Date: Fri, 10 Jan 2014 14:26:40 +0000
Message-ID: <20140110142640.GA32035@lee--X1>
References: <1389269303-30465-1-git-send-email-rogerq@ti.com>
 <1389269303-30465-3-git-send-email-rogerq@ti.com>
 <20140110102251.GH28141@lee--X1>
 <201401101513.40470.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201401101513.40470.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Roger Quadros <rogerq@ti.com>, bcousson@baylibre.com, tony@atomide.com, balbi@ti.com, sre@debian.org, mark.rutland@arm.com, m.paolino@virtualopensystems.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Fri, 10 Jan 2014, Arnd Bergmann wrote:

> On Friday 10 January 2014, Lee Jones wrote:
> > > =20
> > > -     need_logic_fck =3D false;
> > > +     /* Set all clocks as invalid to begin with */
> > > +     omap->ehci_logic_fck =3D omap->init_60m_fclk =3D ERR_PTR(-E=
INVAL);
> > > +     omap->utmi_p1_gfclk =3D omap->utmi_p2_gfclk =3D ERR_PTR(-EI=
NVAL);
> > > +     omap->xclk60mhsp1_ck =3D omap->xclk60mhsp2_ck =3D ERR_PTR(-=
EINVAL);
> >=20
> > I don't think this is the correct error code.
> >=20
> > -EINVAL means 'invalid parameter'.
> >=20
> > You probably want -ENODEV or -ENOSYS ('function not implemented'
> > probably isn't ideal either tbh, but you get the idea). Perhaps you
> > can set them as NULL and check for IS_ERR_OR_NULL() instead?
>=20
> I think ENODEV is ok here, I'd much prefer this over IS_ERR_OR_NULL()=
=2E

Sounds good to me.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
