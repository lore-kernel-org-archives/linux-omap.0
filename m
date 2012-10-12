From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/3] usb: dwc3: Add the suspend/resume functionality
Date: Fri, 12 Oct 2012 13:35:12 +0300
Message-ID: <20121012103512.GE2031@arwen.pp.htv.fi>
References: <1349877949-18872-1-git-send-email-vikas.sajjan@linaro.org>
 <1349877949-18872-2-git-send-email-vikas.sajjan@linaro.org>
 <20121011074702.GJ10030@arwen.pp.htv.fi>
 <CAD025yS8sgTu=euBGErgysR0Xe135u=rv88how6z=dhVMEDniw@mail.gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n+lFg1Zro7sl44OB"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAD025yS8sgTu=euBGErgysR0Xe135u=rv88how6z=dhVMEDniw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vikas Sajjan <vikas.sajjan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--n+lFg1Zro7sl44OB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 12, 2012 at 02:29:39PM +0530, Vikas Sajjan wrote:
> > > @@ -339,49 +390,9 @@ static int __devinit dwc3_core_init(struct dwc3
> > > *dwc)
> > >       }
> > >       dwc->revision =3D reg;
> > >
> > > -     /* issue device SoftReset too */
> > > -     timeout =3D jiffies + msecs_to_jiffies(500);
> > > -     dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
> > > -     do {
> > > -             reg =3D dwc3_readl(dwc->regs, DWC3_DCTL);
> > > -             if (!(reg & DWC3_DCTL_CSFTRST))
> > > -                     break;
> > > -
> > > -             if (time_after(jiffies, timeout)) {
> > > -                     dev_err(dwc->dev, "Reset Timed Out\n");
> > > -                     ret =3D -ETIMEDOUT;
> > > -                     goto err0;
> > > -             }
> > > -
> > > -             cpu_relax();
> > > -     } while (true);
> > > -
> > > -     dwc3_core_soft_reset(dwc);
> > > -
> > > -     dwc3_cache_hwparams(dwc);
> > > -
> > > -     reg =3D dwc3_readl(dwc->regs, DWC3_GCTL);
> > > -     reg &=3D ~DWC3_GCTL_SCALEDOWN_MASK;
> > > -     reg &=3D ~DWC3_GCTL_DISSCRAMBLE;
> > > -
> > > -     switch (DWC3_GHWPARAMS1_EN_PWROPT(dwc->hwparams.hwparams1)) {
> > > -     case DWC3_GHWPARAMS1_EN_PWROPT_CLK:
> > > -             reg &=3D ~DWC3_GCTL_DSBLCLKGTNG;
> > > -             break;
> > > -     default:
> > > -             dev_dbg(dwc->dev, "No power optimization available\n");
> > > -     }
> > > -
> > > -     /*
> > > -      * WORKAROUND: DWC3 revisions <1.90a have a bug
> > > -      * where the device can fail to connect at SuperSpeed
> > > -      * and falls back to high-speed mode which causes
> > > -      * the device to enter a Connect/Disconnect loop
> > > -      */
> > > -     if (dwc->revision < DWC3_REVISION_190A)
> > > -             reg |=3D DWC3_GCTL_U2RSTECN;
> > > -
> > > -     dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> > > +     ret =3D dwc3_core_reset(dwc);
> > > +     if (ret < 0)
> > > +             goto err0;
> > >
> > >       ret =3D dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
> >
> > I would rather move dwc3_alloc_event_buffers() outside of
> > dwc3_core_init() and use that directly on ->resume(). dwc3_core_init()
> > shouldn't be doing any memory allocations, so we can re-use it, and it
> > doesn't matter when we allocate the event buffers anyway.
> >
> dwc3_alloc_event_buffers() was already inside the dwc3_core_init() in
> the existing code, the only change I made is, a common function called
>  dwc3_core_reset() is added which will be used both in probe and
> resume.
> so basically resume only does dwc3_core_reset() and
> dwc3_event_buffers_setup() as dwc3_alloc_event_buffers() is done in
> probe.

we already have too many functions call *reset*, adding another one will
just make code more difficult to follow and it will be error-prone.

This is what I suggested:

commit 9aba985696690c1e8c2cf4f34e35b3f5b296175d
Author: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Date:   Thu Oct 11 13:54:36 2012 +0300

    usb: dwc3: core: move event buffer allocation out of dwc3_core_init()
   =20
    This patch is in preparation for adding PM support
    dwc3 driver. We want to re-use dwc3_core_init and
    dwc3_core_exit() functions on resume() and suspend()
    callbacks respectively.
   =20
    Moving even buffer allocation away from dwc3_core_init()
    will allow us to reuse the event buffer which was allocated
    long ago on our probe() routine.
   =20
    Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 8d543ea..b923183 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -381,24 +381,14 @@ static int __devinit dwc3_core_init(struct dwc3 *dwc)
=20
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
=20
-	ret =3D dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
-	if (ret) {
-		dev_err(dwc->dev, "failed to allocate event buffers\n");
-		ret =3D -ENOMEM;
-		goto err1;
-	}
-
 	ret =3D dwc3_event_buffers_setup(dwc);
 	if (ret) {
 		dev_err(dwc->dev, "failed to setup event buffers\n");
-		goto err1;
+		goto err0;
 	}
=20
 	return 0;
=20
-err1:
-	dwc3_free_event_buffers(dwc);
-
 err0:
 	return ret;
 }
@@ -406,7 +396,6 @@ err0:
 static void dwc3_core_exit(struct dwc3 *dwc)
 {
 	dwc3_event_buffers_cleanup(dwc);
-	dwc3_free_event_buffers(dwc);
 }
=20
 #define DWC3_ALIGN_MASK		(16 - 1)
@@ -509,10 +498,17 @@ static int __devinit dwc3_probe(struct platform_devic=
e *pdev)
 	pm_runtime_get_sync(dev);
 	pm_runtime_forbid(dev);
=20
+	ret =3D dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
+	if (ret) {
+		dev_err(dwc->dev, "failed to allocate event buffers\n");
+		ret =3D -ENOMEM;
+		goto err0;
+	}
+
 	ret =3D dwc3_core_init(dwc);
 	if (ret) {
 		dev_err(dev, "failed to initialize core\n");
-		return ret;
+		goto err0;
 	}
=20
 	mode =3D DWC3_MODE(dwc->hwparams.hwparams0);
@@ -584,6 +580,9 @@ err2:
 err1:
 	dwc3_core_exit(dwc);
=20
+err0:
+	dwc3_free_event_buffers(dwc);
+
 	return ret;
 }
=20

please write your patches on top of this change. I will push it to my
kernel.org tree, branch dwc3. Note that it will still rebase that branch
on top of v3.7-rc1 once it's out, I'm pushing that patch now so you can
use it on your PM changes. Note that it will still rebase that branch on
top of v3.7-rc1 once it's out, I'm pushing that patch now so you can use
it on your PM changes. Note that it will still rebase that branch on top
of v3.7-rc1 once it's out, I'm pushing that patch now so you can use it
on your PM changes.

--=20
balbi

--n+lFg1Zro7sl44OB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQd/JgAAoJEIaOsuA1yqRE/BgP/iPQXoZdl2kX7D1u3reBOLC0
bCJPCHqhjDfAbTG6FtrXwRm5fljkwpdV2I8mpXPlf5iKMfZMEPeHPWGGWXeAfuNf
6n0JlJNWIRGEiTG1izqYjtOUc/O2jZKnxLf1oj/SV2cnsuIDiGM4wyoK3Q8snCRT
DqsLIRAKrRuzPMmrfTni3jJPeBe9Cl1OQ9UF5DFYVRurLjL+fe3jX03fy5o5U3K/
rtc3AFyM/2k7muwZsGtR8qj/Qzy1otSlwf18/28HLnpIGirEFA0HdHsdckG72bJk
2lEOGtfU1/eltafD/dAHqYzdL6j1cxN6I90b2/0vDRAdYvx2Fqtcr4HAVx9wxQ9z
s4s21eM11GJFj/YFhlsXlDYx0fizJdu/oJ7N0xODroz32kE8V0OjYYB41yr+hjH1
sxcGXm859REARgyMjOLHCwrieSmx+yGGrsp5C+GmaEQwAaCGs7E2dRtoOCs7wIxx
IOr54x2rGWpNgs+0b0xisRAs/VPfnwkk8mJKvo7shHzyPOub5pLxZBpTAGYOdY0O
ysUoS2tz48htFfXTo0y7ygp6P87A2olcVWInCk9/qsPm2ZWypVsd279xDiMxgAHb
cNpgKUGmxPpEkKNGcmQtCY6N3DntJMK9EHMpvQ/Rxca9camzYq/wg/t6c/BF0pMM
sY0iZnUDjm+7j2jKx8wp
=U8WQ
-----END PGP SIGNATURE-----

--n+lFg1Zro7sl44OB--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
