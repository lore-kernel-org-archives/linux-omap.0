From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFT/RFC/PATCH 00/31] arm: omap: irq: cleanup INTC driver
Date: Fri, 3 Jan 2014 10:40:55 -0600
Message-ID: <20140103164055.GA18722@saruman.home>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
 <20131219184815.GU27438@atomide.com>
 <20131219232153.GE707@saruman.home>
 <20131221005309.GH26054@atomide.com>
 <20131223173409.GA10536@saruman.home>
 <20140102220101.GA8652@saruman.home>
 <52C6A939.70708@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60398 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbaACQmJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jan 2014 11:42:09 -0500
Content-Disposition: inline
In-Reply-To: <52C6A939.70708@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 03, 2014 at 05:42:41PM +0530, Rajendra Nayak wrote:
> []..
>=20
> >>> so a bit more work is needed. Maybe also rebase these against
> >>> omap-for-v3.14/dt too?
> >>
> >> Will do.
> >=20
> > Rebased on top of omap-for-v3.14/omap3-board-removal. Patches are on my
> > k.org tree:
> >=20
> > git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git wip/omap-fi=
x-intc
>=20
> It needs a minor build fix though..
>=20
> diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-i=
ntc.c
> index b58c5d5..d03b5a3 100644
> --- a/drivers/irqchip/irq-omap-intc.c
> +++ b/drivers/irqchip/irq-omap-intc.c
> @@ -151,7 +151,7 @@ static void omap_mask_ack_irq(struct irq_data *d)
>  static void omap_suspend_irq(struct irq_data *d)
>  {
>         omap_intc_save_context();
> -       omap3_intc_prepare_idle();
> +       omap_intc_prepare_idle();

fixed now, thanks. Wonder how come I didn't see that, I was building
every commit with omap2plus_defconfig :-( Oh well...

--=20
balbi

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSxugXAAoJEIaOsuA1yqREKUMP/1hiawAP2KiiPhQCK2dUxOpv
j94H0IyLnMrHEI09FsBaGfI8up92yu4QHbx1w6ZGvLQWbGwUCg96KDVCOyEcxAZP
Yxf64sYsPfqnuOCobwkiBAbAqk98DsLfffB3kqyl73MbP+UB/WqyDFPhIj4Xssuj
SkszJCJ2H/J9mAnMAKXG8lNNQx3bKvUk+wIlwoihFztaTyg8TNh4NMgFhhR9UfKC
3+p3UWjIqZ/2YjefC8I6ggvx4yWQDrSqQ8ulyxw/YmDypFVmYtXE47q2m2KoDuoL
CUu6dIjcApCY8VWg52Sb5+QPdwygE3FGnD0RjxWH/r0Baq0yKIVBXRVBpfBhlkmK
xcOkUZXi6bRFXiJDw7w0Dzc48udl3BD5t/OMIKDVquCg+6OQGDOyTexPFU0FASlz
Z1notBD+8Kr/h15piYUEFZ7spRKptNwiehr2WjW38XCpTirFm8LI+fRqHg51KHKD
746T2O+K6A5YRgnLrsyA7X8AERRwckZtDOg5SJerlO97ZD3PYVZ/H80Mp2kx67JC
n2m5Lxubs5FSirm200UuAxAJHNJr6seolFATP9qbQ2jzxe0R4h2isVfQ2wUkWy9+
kfmRCV7/sFbrsQm0bMzZR+EPSiaz8zxZeNKoYj2VwQC/P9rF/GfRerETilpN3I7q
z1h8raXtT2T2p9Jj4DMI
=dj3z
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
