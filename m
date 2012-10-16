From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 1/3] usb: dwc3: Add the suspend/resume functionality
Date: Tue, 16 Oct 2012 16:53:28 +0300
Message-ID: <20121016135328.GI21801@arwen.pp.htv.fi>
References: <1350380738-32473-1-git-send-email-vikas.sajjan@linaro.org>
 <1350380738-32473-2-git-send-email-vikas.sajjan@linaro.org>
 <20121016100656.GB17416@arwen.pp.htv.fi>
 <CAD025yRD+u+z=SEtJvEY+NAdNtg8_cWcCMWaa347e-idmb6GpQ@mail.gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J+eNKFoVC4T1DV3f"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAD025yRD+u+z=SEtJvEY+NAdNtg8_cWcCMWaa347e-idmb6GpQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vikas Sajjan <vikas.sajjan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--J+eNKFoVC4T1DV3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 16, 2012 at 05:10:39PM +0530, Vikas Sajjan wrote:
> Hi Felipe,
>=20
> On 16 October 2012 15:36, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> > Hi,
> >
> > On Tue, Oct 16, 2012 at 03:15:36PM +0530, Vikas Sajjan wrote:
> >> Adds suspend and resume callbacks as part of the power management
> >> support to DWC3 controller Driver.
> >> This patch facilitates transition of DWC3 controller between D0 and D3
> >> power states during suspend/resume cycles.
> >>
> >> Signed-off-by: Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> >> Signed-off-by: Vikas C Sajjan <vikas.sajjan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >> CC: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> >> ---
> >>  drivers/usb/dwc3/core.c |   44 ++++++++++++++++++++++++++++++++++++++=
++++++
> >>  1 files changed, 44 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> >> index 5db4c76..9f35cf8 100644
> >> --- a/drivers/usb/dwc3/core.c
> >> +++ b/drivers/usb/dwc3/core.c
> >> @@ -621,11 +621,55 @@ static int __devexit dwc3_remove(struct platform=
_device *pdev)
> >>       return 0;
> >>  }
> >>
> >> +#ifdef CONFIG_PM_SLEEP
> >> +static int dwc3_resume(struct device *dev)
> >> +{
> >> +     struct dwc3 *dwc =3D dev_get_drvdata(dev);
> >> +     int     ret;
> >> +
> >> +     ret =3D dwc3_core_init(dwc);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +
> >> +     switch (dwc->mode) {
> >> +     case DWC3_MODE_DEVICE:
> >> +             dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
> >> +             break;
> >> +     case DWC3_MODE_HOST:
> >> +             dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
> >> +             break;
> >> +     case DWC3_MODE_DRD:
> >> +             dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
> >> +     }
> >> +
> >> +     /* runtime set active to reflect active state. */
> >> +     pm_runtime_disable(dev);
> >> +     pm_runtime_set_active(dev);
> >> +     pm_runtime_enable(dev);
> >> +
> >> +     return 0;
> >> +}
> >> +
> >> +static int dwc3_suspend(struct device *dev)
> >> +{
> >> +     struct dwc3 *dwc =3D dev_get_drvdata(dev);
> >> +
> >
> > there is one check you need to do here. If you are playing the
> > peripheral role, you can't allow suspend unless link is in U3 or you're
> > not enumerated.
> >
> > Have you tested running 'echo mem > /sys/power/state' on your device
> > while you're transferring data in a USB session with the Host ?
> >
> we have tested only when DWC3 is in HOST mode.

I'm very sorry but this isn't enough :-( We need to make sure there are
no regressions on peripheral role.

> > I'll ask again, how was this tested ? What did you actually run (which
> > commands, which use cases have you validated) ? I'm not asking only
> > which platform you used, I need to know how you exercised this feature,
> > how did you trigger suspend/resume, in which conditions (enumerated ?
> > bus suspended ? no cable attached ?), etc.
> >
> 1) We have tested by connecting a USB Mouse, USB 2.0 Mass Storage Device =
and
> USB 3.0 Mass Storage Device on a SS hub connected on USB 3.0 port to
> Exynos5250 board, in which DWC3 is configured for HOST mode.

did you have a transfer going through when you suspended ? If you
didn't, then you haven't stressed well enough.

> 2) We tested by running  command
> echo +20  > /sys/class/rtc/rtc0/wakealarm  &&  echo mem > /sys/power/state

that's ok, but try something like:

# dd if=3D/dev/urandom of=3D/dev/sdXX bs=3D1M count=3D99999999 &
# echo +20  > /sys/class/rtc/rtc0/wakealarm  &&  echo mem > /sys/power/state

Better yet, generate a big (and I really mean big :-) file with a known
pattern (make a sequence from 0x00 to 0xff and back to zero, over and
over again) then write that file to the mass storage device, while
transfer is on the fly, suspend, then resume and see if transfer
continues, then later verify the bytes by reading back the data and
comparing with original source file.

Do this for both Host and Peripheral roles. I have a rather big
suspicion that it won't work, in which case we need to make sure to
prevent suspend while transfers are on the fly or do something else.

--=20
balbi

--J+eNKFoVC4T1DV3f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQfWbYAAoJEIaOsuA1yqRERfkP+wWnBcJhBZ9QviKqfKLbKxdc
GpVAecUWo8RWTdMyo7gU//381NwHqHiTIYbsNYOEZdY9jID9C75m+gk8EBY3YuZI
u+pLT5+1MBP1x0NkcrYLo/TGjidoFalovZCp7MNEgVmRteqfay5HTf34WA5vG8We
O1jq8xoG3jApYYOXKKPN099KuWXLBIMoKtGm/ZRd+epGNGIbYXdVkL1NIO5Cvrkp
HkZqovHIoz9zZA2WtTdV75aXH3C5BPijvF55q+vBIONuIdNHaS/7aYRxRtzRFO0N
6NYl+010zCxS0/uaigaoeKbpaM7mYakBVQ0Y37qLOM+LGUTG4+A9yQFUFgEq60k7
VNLi01ID8xRoQQoifDk9s5IlKEOGwg4p1E4A2IC0pngnVUfX5LSEP+5iv8+bT9pJ
BCXPNOTvDLBSBaNHThMvrJVpZmAMDznxvH1EJosEG0pbtQfKsOhkAYUfH4TCm0GM
i3eKG9wJeFKPqUzDwNUoqu+1BptJ6Ezb4x28YiZJLcIbh7e2z4K9bOHmqwuut9yr
YqACWrd+l05lr1DScSVvN9/3fxywDGr8FXTygaqO7ETLEhvZ7PMar+1LSSSb1es7
qA74JR4yb7SDJ4poLlfmgCuTFN8ikpMpT4gMB1y6gWRsUC8ttH9NWFvOYx+eIt87
SWHk75fiKzhvf2uvED63
=/I76
-----END PGP SIGNATURE-----

--J+eNKFoVC4T1DV3f--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
