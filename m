From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/3] usb: dwc3: Add the suspend/resume functionality
Date: Mon, 15 Oct 2012 15:02:55 +0300
Message-ID: <20121015120255.GC24333@arwen.pp.htv.fi>
References: <1349877949-18872-1-git-send-email-vikas.sajjan@linaro.org>
 <1349877949-18872-2-git-send-email-vikas.sajjan@linaro.org>
 <5077F7B5.9000509@ti.com>
 <CAD025yRKnLWKzVGneMnudSKHasWw-2Qe8b40VpiFJev=zPiVdw@mail.gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAD025yRKnLWKzVGneMnudSKHasWw-2Qe8b40VpiFJev=zPiVdw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vikas Sajjan <vikas.sajjan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: kishon <kishon-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2012 at 07:24:33PM +0530, Vikas Sajjan wrote:
> Hi kishon,
>=20
> On 12 October 2012 16:27, kishon <kishon-l0cyMroinI0@public.gmane.org> wrote:
> > Hi,
> >
> >
> > On Wednesday 10 October 2012 07:35 PM, Vikas C Sajjan wrote:
> >>
> >> From: Vikas Sajjan <vikas.sajjan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >>
> >> Adding the suspend and resume funtionality to DWC3 core.
> >>
> >> Signed-off-by: Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> >> Signed-off-by: Vikas C Sajjan <vikas.sajjan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >> CC: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> >> ---
> >>   drivers/usb/dwc3/core.c |  268
> >> +++++++++++++++++++++++++++++-----------------
> >>   1 files changed, 169 insertions(+), 99 deletions(-)
> >>
> >> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> >> index b415c0c..58b51e1 100644
> >> --- a/drivers/usb/dwc3/core.c
> >> +++ b/drivers/usb/dwc3/core.c
> >>
> >> @@ -70,51 +70,20 @@ MODULE_PARM_DESC(maximum_speed, "Maximum supported
> >> speed.");
> >>
> >>   static DECLARE_BITMAP(dwc3_devs, DWC3_DEVS_POSSIBLE);
> >>
> >> -int dwc3_get_device_id(void)
> >> -{
> >> -       int             id;
> >> -
> >> -again:
> >> -       id =3D find_first_zero_bit(dwc3_devs, DWC3_DEVS_POSSIBLE);
> >> -       if (id < DWC3_DEVS_POSSIBLE) {
> >> -               int old;
> >> -
> >> -               old =3D test_and_set_bit(id, dwc3_devs);
> >> -               if (old)
> >> -                       goto again;
> >> -       } else {
> >> -               pr_err("dwc3: no space for new device\n");
> >> -               id =3D -ENOMEM;
> >> -       }
> >> -
> >> -       return id;
> >> -}
> >> -EXPORT_SYMBOL_GPL(dwc3_get_device_id);
> >> -
> >> -void dwc3_put_device_id(int id)
> >> -{
> >> -       int                     ret;
> >> -
> >> -       if (id < 0)
> >> -               return;
> >> -
> >> -       ret =3D test_bit(id, dwc3_devs);
> >> -       WARN(!ret, "dwc3: ID %d not in use\n", id);
> >> -       smp_mb__before_clear_bit();
> >> -       clear_bit(id, dwc3_devs);
> >> -}
> >> -EXPORT_SYMBOL_GPL(dwc3_put_device_id);
> >> -
> >> -void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
> >> +static void __devinit dwc3_cache_hwparams(struct dwc3 *dwc)
> >>   {
> >> -       u32 reg;
> >> +       struct dwc3_hwparams    *parms =3D &dwc->hwparams;
> >>
> >> -       reg =3D dwc3_readl(dwc->regs, DWC3_GCTL);
> >> -       reg &=3D ~(DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_OTG));
> >> -       reg |=3D DWC3_GCTL_PRTCAPDIR(mode);
> >> -       dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> >> +       parms->hwparams0 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS0);
> >> +       parms->hwparams1 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS1);
> >> +       parms->hwparams2 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS2);
> >> +       parms->hwparams3 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS3);
> >> +       parms->hwparams4 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS4);
> >> +       parms->hwparams5 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS5);
> >> +       parms->hwparams6 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS6);
> >> +       parms->hwparams7 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS7);
> >> +       parms->hwparams8 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS8);
> >>   }
> >> -
> >>   /**
> >>    * dwc3_core_soft_reset - Issues core soft reset and PHY reset
> >>    * @dwc: pointer to our context structure
> >> @@ -160,6 +129,102 @@ static void dwc3_core_soft_reset(struct dwc3 *dw=
c)
> >>         dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> >>   }
> >>
> >> +static int dwc3_core_reset(struct dwc3 *dwc)
> >> +{
> >> +       unsigned long   timeout;
> >> +       u32     reg;
> >> +
> >> +       /* issue device SoftReset too */
> >> +       timeout =3D jiffies + msecs_to_jiffies(500);
> >> +       dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
> >> +       do {
> >> +               reg =3D dwc3_readl(dwc->regs, DWC3_DCTL);
> >> +               if (!(reg & DWC3_DCTL_CSFTRST))
> >> +                       break;
> >> +
> >> +               if (time_after(jiffies, timeout)) {
> >> +                       dev_err(dwc->dev, "Reset Timed Out\n");
> >> +                       return -ETIMEDOUT;
> >> +               }
> >> +
> >> +               cpu_relax();
> >> +       } while (true);
> >> +
> >> +       dwc3_core_soft_reset(dwc);
> >> +
> >> +       dwc3_cache_hwparams(dwc);
> >> +
> >> +       reg =3D dwc3_readl(dwc->regs, DWC3_GCTL);
> >> +       reg &=3D ~DWC3_GCTL_SCALEDOWN_MASK;
> >> +       reg &=3D ~DWC3_GCTL_DISSCRAMBLE;
> >> +
> >> +       switch (DWC3_GHWPARAMS1_EN_PWROPT(dwc->hwparams.hwparams1)) {
> >> +       case DWC3_GHWPARAMS1_EN_PWROPT_CLK:
> >> +               reg &=3D ~DWC3_GCTL_DSBLCLKGTNG;
> >> +               break;
> >> +       default:
> >> +               dev_dbg(dwc->dev, "No power optimization available\n");
> >> +       }
> >> +
> >> +       /*
> >>
> >> +        * WORKAROUND: DWC3 revisions <1.90a have a bug
> >> +        * where the device can fail to connect at SuperSpeed
> >> +        * and falls back to high-speed mode which causes
> >> +        * the device to enter a Connect/Disconnect loop
> >> +        */
> >> +       if (dwc->revision < DWC3_REVISION_190A)
> >> +               reg |=3D DWC3_GCTL_U2RSTECN;
> >> +
> >> +       dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +int dwc3_get_device_id(void)
> >> +{
> >> +       int             id;
> >> +
> >> +again:
> >> +       id =3D find_first_zero_bit(dwc3_devs, DWC3_DEVS_POSSIBLE);
> >> +       if (id < DWC3_DEVS_POSSIBLE) {
> >> +               int old;
> >> +
> >> +               old =3D test_and_set_bit(id, dwc3_devs);
> >> +               if (old)
> >> +                       goto again;
> >> +       } else {
> >> +               pr_err("dwc3: no space for new device\n");
> >> +               id =3D -ENOMEM;
> >> +       }
> >> +
> >> +       return id;
> >> +}
> >> +EXPORT_SYMBOL_GPL(dwc3_get_device_id);
> >> +
> >> +void dwc3_put_device_id(int id)
> >> +{
> >> +       int                     ret;
> >> +
> >> +       if (id < 0)
> >> +               return;
> >> +
> >> +       ret =3D test_bit(id, dwc3_devs);
> >> +       WARN(!ret, "dwc3: ID %d not in use\n", id);
> >> +       smp_mb__before_clear_bit();
> >> +       clear_bit(id, dwc3_devs);
> >> +}
> >> +EXPORT_SYMBOL_GPL(dwc3_put_device_id);
> >> +
> >> +void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
> >> +{
> >> +       u32 reg;
> >> +
> >> +       reg =3D dwc3_readl(dwc->regs, DWC3_GCTL);
> >> +       reg &=3D ~(DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_OTG));
> >> +       reg |=3D DWC3_GCTL_PRTCAPDIR(mode);
> >> +       dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> >> +}
> >> +
> >>   /**
> >>    * dwc3_free_one_event_buffer - Frees one event buffer
> >>    * @dwc: Pointer to our controller context structure
> >> @@ -303,20 +368,7 @@ static void dwc3_event_buffers_cleanup(struct dwc3
> >> *dwc)
> >>         }
> >>   }
> >>
> >> -static void __devinit dwc3_cache_hwparams(struct dwc3 *dwc)
> >> -{
> >> -       struct dwc3_hwparams    *parms =3D &dwc->hwparams;
> >>
> >> -       parms->hwparams0 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS0);
> >> -       parms->hwparams1 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS1);
> >> -       parms->hwparams2 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS2);
> >> -       parms->hwparams3 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS3);
> >> -       parms->hwparams4 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS4);
> >> -       parms->hwparams5 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS5);
> >> -       parms->hwparams6 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS6);
> >> -       parms->hwparams7 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS7);
> >> -       parms->hwparams8 =3D dwc3_readl(dwc->regs, DWC3_GHWPARAMS8);
> >> -}
> >>
> >>   /**
> >>    * dwc3_core_init - Low-level initialization of DWC3 Core
> >> @@ -326,7 +378,6 @@ static void __devinit dwc3_cache_hwparams(struct d=
wc3
> >> *dwc)
> >>    */
> >>   static int __devinit dwc3_core_init(struct dwc3 *dwc)
> >>   {
> >> -       unsigned long           timeout;
> >>         u32                     reg;
> >>         int                     ret;
> >>
> >> @@ -339,49 +390,9 @@ static int __devinit dwc3_core_init(struct dwc3 *=
dwc)
> >>         }
> >>         dwc->revision =3D reg;
> >>
> >> -       /* issue device SoftReset too */
> >> -       timeout =3D jiffies + msecs_to_jiffies(500);
> >> -       dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
> >> -       do {
> >> -               reg =3D dwc3_readl(dwc->regs, DWC3_DCTL);
> >> -               if (!(reg & DWC3_DCTL_CSFTRST))
> >> -                       break;
> >> -
> >> -               if (time_after(jiffies, timeout)) {
> >> -                       dev_err(dwc->dev, "Reset Timed Out\n");
> >> -                       ret =3D -ETIMEDOUT;
> >> -                       goto err0;
> >> -               }
> >> -
> >> -               cpu_relax();
> >> -       } while (true);
> >> -
> >> -       dwc3_core_soft_reset(dwc);
> >> -
> >> -       dwc3_cache_hwparams(dwc);
> >> -
> >> -       reg =3D dwc3_readl(dwc->regs, DWC3_GCTL);
> >> -       reg &=3D ~DWC3_GCTL_SCALEDOWN_MASK;
> >> -       reg &=3D ~DWC3_GCTL_DISSCRAMBLE;
> >> -
> >> -       switch (DWC3_GHWPARAMS1_EN_PWROPT(dwc->hwparams.hwparams1)) {
> >> -       case DWC3_GHWPARAMS1_EN_PWROPT_CLK:
> >> -               reg &=3D ~DWC3_GCTL_DSBLCLKGTNG;
> >> -               break;
> >> -       default:
> >> -               dev_dbg(dwc->dev, "No power optimization available\n");
> >> -       }
> >> -
> >> -       /*
> >> -        * WORKAROUND: DWC3 revisions <1.90a have a bug
> >> -        * where the device can fail to connect at SuperSpeed
> >> -        * and falls back to high-speed mode which causes
> >> -        * the device to enter a Connect/Disconnect loop
> >> -        */
> >> -       if (dwc->revision < DWC3_REVISION_190A)
> >> -               reg |=3D DWC3_GCTL_U2RSTECN;
> >> -
> >> -       dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> >> +       ret =3D dwc3_core_reset(dwc);
> >> +       if (ret < 0)
> >> +               goto err0;
> >>
> >>         ret =3D dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
> >>         if (ret) {
> >>
> >> @@ -622,11 +633,70 @@ static int __devexit dwc3_remove(struct
> >> platform_device *pdev)
> >>         return 0;
> >>   }
> >>
> >> +#ifdef CONFIG_PM
> >> +static int dwc3_core_resume(struct device *dev)
> >> +{
> >> +       struct dwc3     *dwc;
> >> +       int     ret;
> >> +
> >> +       dwc =3D dev_get_drvdata(dev);
> >> +       if (!dwc)
> >> +               return -EINVAL;
> >> +
> >> +       ret =3D dwc3_core_reset(dwc);
> >
> >
> > Do you have to add core_reset because of any issues you observed? In the
> > ideal working case, you shouldn't have to do reset every-time on resume.
> >
> Initially we tested on kernel 3.4 with which we had some issue in detecti=
ng
> USB devices on SS hub. But now as you pointed out, we tested after removi=
ng
> core_reset  during resume, and it seems to be working fine.
> Thanks for pointing out, we shall re-confirm and update the new patch-set=
 soon.
>=20
> > Maybe I have missed your mail so I'm asking Felipe's question again. ho=
w has
> > this patch series been tested?
> >
> We tested the patch series on 'usb-next' on greg's tree after applying
> our local patches
> for exynos5 USB3.0 PHY support and also reverting the patch for dwc3-core
> "usb: dwc3: add basic PHY support" since our USB3.0 PHY driver is underwa=
y.

Yes, the idea of that patch was to simply add basic PHY support to dwc3,
once PHY drivers where actually available, those should be removed and
moved over to use the actual PHY driver.

--=20
balbi

--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQe/tvAAoJEIaOsuA1yqRE4IIP/RmhfBKJVprGRCR4LW/V+ke1
gX+9prL7cj8TWx65A7lZ3SC1jIk5yBJdeiTt3cC8e+3nLx7OMd4gELZE5RmnKprB
YWW80TmlGdavPoAP5Hq4N49b37WHEzwkoNQwc4jeaWuNZzbGefaeL42jChAOZnMa
AyTx7Z98KF/qPAKHS43efmvf/fb3OC5PJjXxo/hE3sYksrc2wvqZFNpjWnWKYCJf
y0m2+su6DQfLkX8qn3eA6435uJASfZH23i54wIPHXaJey6R05cMQRavUgvnLeyEL
N+/TmZhTqP8gD8QBmDaN7FloyuzOB78ez7hua7oWBWqkhMFW+qCHxet5QsZ3acyc
5Eb46IczArsWp8CPZmgAQTFmfgNkKGcmTa2WM2jl/GC5xhx/kinL4c3tx0AnvwA+
+YRuf3aYKa2Gvaiqb8KxFMRhGFuiC0KM+dnphc6AQn4Y5lnhs97Db7wkfv1WCSag
BaZ1vByp8kCwnBNgZT020/9Ehqftb1VgeeCnfc68+TfikpEIjCs3e2F6KV5q3OPO
1TP0EL5rP823TwC1CuFAKARod8ROcpf7SsHF0PRYfpRynPRV6zrNhcG3vVzm42OJ
gK52jYQ4lRzDho8IMWx03yCRylg7kzU+U/7tSSeoLybhV1Rf4n9+t+to2L201ybY
JNjXtjpHOKd6v7CNVKQ5
=+KRf
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
