From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v5 01/46] usb: gadget: encapsulate endpoint claiming
 mechanism
Date: Thu, 20 Aug 2015 12:44:09 -0500
Message-ID: <20150820174409.GB7270@saruman.tx.rr.com>
References: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
 <1438351258-31578-2-git-send-email-r.baldyga@samsung.com>
 <20150820153553.GD1639@saruman.tx.rr.com>
 <55D6001E.3000504@hackerion.com>
 <20150820164808.GB4938@saruman.tx.rr.com>
 <55D60B80.7040800@hackerion.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8273302544958227235=="
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <55D60B80.7040800@hackerion.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Robert Baldyga <r.baldyga@hackerion.com>
Cc: nicolas.ferre@atmel.com, robert.jarzmik@free.fr, m.szyprowski@samsung.com, devel@driverdev.osuosl.org, cernekee@gmail.com, michal.simek@xilinx.com, stern@rowland.harvard.edu, Peter.Chen@freescale.com, dahlmann.thomas@arcor.de, leoli@freescale.com, johnyoun@synopsys.com, Robert Baldyga <r.baldyga@samsung.com>, linux-geode@lists.infradead.org, haojian.zhuang@gmail.com, andrzej.p@samsung.com, linux-omap@vger.kernel.org, petr.cvek@tul.cz, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, linuxppc-dev@lists.ozlabs.org, daniel@zonque.org
List-Id: linux-omap@vger.kernel.org

--===============8273302544958227235==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline

--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 20, 2015 at 07:16:48PM +0200, Robert Baldyga wrote:
> On 08/20/2015 06:48 PM, Felipe Balbi wrote:
> >On Thu, Aug 20, 2015 at 06:28:14PM +0200, Robert Baldyga wrote:
> >>Hi Felipe,
> >>
> >>On 08/20/2015 05:35 PM, Felipe Balbi wrote:
> >>[...]
> >>>just letting you know that this regresses all gadget drivers making th=
em
> >>>try to disable previously disabled endpoints and enable previously
> >>>enabled endpoints.
> >>>
> >>>I have a possible fix (see below) but then it shows a problem on the
> >>>host side when using with g_zero (see further below):
> >>>
> >>>commit 3b8932100aacb6cfbffe288ca93025d8b8430c00
> >>>Author: Felipe Balbi <balbi@ti.com>
> >>>Date:   Wed Aug 19 18:05:27 2015 -0500
> >>>
> >>>     usb: gadget: fix ep->claimed lifetime
> >>>
> >>>     In order to fix a regression introduced by commit
> >>>     cc476b42a39d ("usb: gadget: encapsulate endpoint
> >>>     claiming mechanism") we have to introduce a simple
> >>>     helper to check if a particular is enabled or not.
> >>>
> >>>     After that, we need to move ep->claimed lifetime to
> >>>     usb_ep_enable() and usb_ep_disable() since those
> >>>     are the only functions which actually enable and
> >>>     disable endpoints.
> >>>
> >>>     A follow-up patch will come to drop all driver_data
> >>>     checks from function drivers, since those are, now,
> >>>     pointless.
> >>>
> >>>     Fixes: cc476b42a39d ("usb: gadget: encapsulate endpoint
> >>>     	claiming mechanism")
> >>>     Cc: Robert Baldyga <r.baldyga@samsung.com>
> >>>     Signed-off-by: Felipe Balbi <balbi@ti.com>
> >>>
> >>>diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epau=
toconf.c
> >>>index 978435a51038..ad45070cd76f 100644
> >>>--- a/drivers/usb/gadget/epautoconf.c
> >>>+++ b/drivers/usb/gadget/epautoconf.c
> >>>@@ -126,7 +126,6 @@ found_ep:
> >>>  	ep->address =3D desc->bEndpointAddress;
> >>>  	ep->desc =3D NULL;
> >>>  	ep->comp_desc =3D NULL;
> >>>-	ep->claimed =3D true;
> >>
> >>Removing this line causes autoconfig can return the same endpoint many
> >>times. This probably causes problems with g_zero.
> >>
> >>I will try to fix it ASAP.
> >
> >I was considering the same thing, but the lifetime of ->claimed doesn't
> >look correct to me either way. Note that once the flag is enabled, it
> >won't get disabled by most gadget drivers.
>=20
> And it should not be. This flag is indicator, that endpoint is used by so=
me
> function. It should be set once by usb_ep_autoconfig() and cleared by
> usb_ep_autoconfig_reset().

have you considered switching interfaces and/or alternate settings ?

> I wonder what is reason of this enable/disable regression. Maybe the prob=
lem
> is that we don't set ep->driver_data to NULL in usb_ep_autoconfig_reset()
> (so far it was done). Does this problem occur while gadget is binded to U=
DC
> for the first time, or at any next time? Unfortunately at this moment I
> don't have access to my hardware, so it will take a moment before I will
> setup some testing environment.

yeah, that's okay. We've got time.

--=20
balbi

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV1hHpAAoJEIaOsuA1yqREE+IQAI45exMYwUVmW1eJMoC3y3JY
gnIO01ar4F/Xbgpew0sMF8qoqOLS0Gpdrwhn1ucumfawxt4FNqXMek7gle079WG0
4WSMQiCO8de8Al2Uj5clf8a62pBslmhO4+Slwq1bkmKR7xWCH67GxWqSVqtXeLPS
QIy5bkB3IlmOLAJ1ogZF1q6mSukm8721AziBFGJ8HReWUykMR/jWKrdxmia9n1ZA
8cCjkyjkqMnUpCV6SNVtRn80yK04QfWt0BqogtddAVcGUyIt3lwwAieXJcw20kN6
0V6jVBPSYnM77peSRyh3oYnhVzJDvRMGWBgbTlte4AOUjaKrYNJ8ANqTPSMVrgdH
QijEEcEiM2WfpS6rBMqdybvwOPbHuSsCRDmm1tTyCM58RrdyvdSp5GxLzAbjlXRD
rim6lEGj9WSxvJJw1HcV/BZ+YpB4/BFDWw9F9eGKZcnIFiI2/HB15V4MsDQIEbdN
cn/fK4yBm+0+5jmFDwvrK4mYtW8gCf2WaVexfOkWTzJ5blCHCEydzMAHqlEMqCtd
29N3weEtd694iC47JlozW1oMg+vQJycQw7tHezTmqsWhtubrLrB4qUShntulmNzS
0y9yMOXSBpapirbZlaOgmLSEJhaGpYOCETSODawWJLcWs+idyb0CM6mnoEch1fP+
XOCViUbObbs7sFeKT3y3
=TN/m
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--

--===============8273302544958227235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============8273302544958227235==--
