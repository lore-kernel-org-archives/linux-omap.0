From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/3] usb: dwc3: add ST dwc3 glue layer to manage dwc3
 HC
Date: Tue, 22 Jul 2014 16:56:45 +0100
Message-ID: <20140722155645.GD23210@lee--X1>
References: <1404541530-27856-1-git-send-email-peter.griffin@linaro.org>
 <1404541530-27856-2-git-send-email-peter.griffin@linaro.org>
 <20140707124627.GG6407@lee--X1>
 <20140722091800.GB8233@griffinp-ThinkPad-X1-Carbon-2nd>
 <20140722145711.GC20588@saruman.home>
 <20140722154503.GC23210@lee--X1>
 <20140722155117.GF20588@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140722155117.GF20588-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peppe.cavallaro-qxv4g6HH51o@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, 22 Jul 2014, Felipe Balbi wrote:

> On Tue, Jul 22, 2014 at 04:45:03PM +0100, Lee Jones wrote:
> > > > > > +static void st_dwc3_init(struct st_dwc3 *dwc3_data)
> > > > > > +{
> > > > > > +	u32 reg =3D st_dwc3_readl(dwc3_data->glue_base, USB2_CLKR=
ST_CTRL);
> > > > > > +
> > > > > > +	reg |=3D aux_clk_en(1) | ext_cfg_reset_n(1) | xhci_revisi=
on(1);
> > > > > > +	reg &=3D ~sw_pipew_reset_n(1);
> > > > >=20
> > > > > 1?  Better to add defines for these magic numbers.  What is 1=
 anyway?
> > > >=20
> > > > They are just bit setting macros, I've converted them over to u=
se BIT macro now,
> > > > so it no longer takes a parameter.
> > >=20
> > > the macros are better, but make them upper case as everybody else=
=2E
> >=20
> > When you say that the macros are better, what do you mean?
> >=20
> > Defines do the job in a manner which is a great deal cleaner:
> >=20
> > #define AUX_CLK_EN        BIT(0)
> > #define SW_PIPEW_RESET_N  BIT(4)
> > #define EXT_CFG_RESET_N   BIT(8)
> > #define XHCI_REVISION     BIT(12)
> >=20
> > reg =3D AUX_CLK_EN | SW_PIPEW_RESET_N | XHCI_REVISION;
> > reg &=3D ~SW_PIPEW_RESET_N
>=20
> this is what I meant ;-) I see what I wrote can be very ambiguous :-p

Okay great, thanks for clarifying. :)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
