From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/3] usb: dwc3: add ST dwc3 glue layer to manage dwc3
 HC
Date: Tue, 22 Jul 2014 16:45:03 +0100
Message-ID: <20140722154503.GC23210@lee--X1>
References: <1404541530-27856-1-git-send-email-peter.griffin@linaro.org>
 <1404541530-27856-2-git-send-email-peter.griffin@linaro.org>
 <20140707124627.GG6407@lee--X1>
 <20140722091800.GB8233@griffinp-ThinkPad-X1-Carbon-2nd>
 <20140722145711.GC20588@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140722145711.GC20588@saruman.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, peppe.cavallaro@st.com
List-Id: linux-omap@vger.kernel.org

> > > > +static void st_dwc3_init(struct st_dwc3 *dwc3_data)
> > > > +{
> > > > +	u32 reg =3D st_dwc3_readl(dwc3_data->glue_base, USB2_CLKRST_C=
TRL);
> > > > +
> > > > +	reg |=3D aux_clk_en(1) | ext_cfg_reset_n(1) | xhci_revision(1=
);
> > > > +	reg &=3D ~sw_pipew_reset_n(1);
> > >=20
> > > 1?  Better to add defines for these magic numbers.  What is 1 any=
way?
> >=20
> > They are just bit setting macros, I've converted them over to use B=
IT macro now,
> > so it no longer takes a parameter.
>=20
> the macros are better, but make them upper case as everybody else.

When you say that the macros are better, what do you mean?

Defines do the job in a manner which is a great deal cleaner:

#define AUX_CLK_EN        BIT(0)
#define SW_PIPEW_RESET_N  BIT(4)
#define EXT_CFG_RESET_N   BIT(8)
#define XHCI_REVISION     BIT(12)

reg =3D AUX_CLK_EN | SW_PIPEW_RESET_N | XHCI_REVISION;
reg &=3D ~SW_PIPEW_RESET_N

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
