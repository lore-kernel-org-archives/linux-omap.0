From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Fri, 15 Feb 2013 18:03:28 +0200
Message-ID: <20130215160328.GA20334@arwen.pp.htv.fi>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <1360840554-26901-2-git-send-email-balbi@ti.com>
 <87obfl60x7.fsf@linaro.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37104 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758885Ab3BOQDl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Feb 2013 11:03:41 -0500
Content-Disposition: inline
In-Reply-To: <87obfl60x7.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 15, 2013 at 07:40:04AM -0800, Kevin Hilman wrote:
> Felipe Balbi <balbi@ti.com> writes:
>=20
> > Currently the omap-serial driver will not
> > work properly if booted via DT with CPUIDLE
> > enabled because it depends on function pointers
> > provided by hwmod to change its own SYSCONFIG
> > register.
> >
> > Remove that relyance on hwmod by moving SYSCONFIG
> > handling to driver itself. Note that this also
> > fixes a possible corner case bug where we could
> > be putting UART in Force Idle mode if we called
> > omap_serial_enable_wakeup(up, false) after setting
> > NOIDLE to the idle mode. This is because hwmod
> > has no protection against that situation.
> >
> > NYET-Signed-off-by: Felipe Balbi <balbi@ti.com>
>=20
> Here's another approach to getting rid of the sysconfig twiddling in the
> driver.  I wrote this some time ago at my former company ;) but don't
> think I ever got around to posting it.
>=20
> It doesn't solve the whole problem (e.g. doesn't address the
> context_loss or enable_wakeup func pointers), but at least gets rid of
> the need for any SYSCONFIG access in the driver for the idle modes.

wakeup is still done by setting smart_idle_wakeup right, at least to
some IPs. Following omap_serial_enable_wakeup() calls, I can see that it
turns out to fiddle with sysconfig ;-)

> @@ -229,8 +209,6 @@ static void serial_omap_stop_tx(struct uart_port *por=
t)
>  		serial_out(up, UART_IER, up->ier);
>  	}
> =20
> -	serial_omap_set_forceidle(up);
> -
>  	pm_runtime_mark_last_busy(up->dev);
>  	pm_runtime_put_autosuspend(up->dev);
>  }
> @@ -298,7 +276,6 @@ static void serial_omap_start_tx(struct uart_port *po=
rt)
> =20
>  	pm_runtime_get_sync(up->dev);
>  	serial_omap_enable_ier_thri(up);
> -	serial_omap_set_noidle(up);

this is no different then the patches Santosh has sent just a few
minutes ago, what gives ? It's exactly the same patch...

Anyway, I have exposed a problem with this aproach.

--=20
balbi

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRHlxQAAoJEIaOsuA1yqREn0gP/3Au3DkI3/DlmGMMqSLpEXCH
IDzBNg1KgKYYsnyyFTHno6zywb1NlSl33MV2QDR0eaPlK+dkOJKqvfpGj4Nka7RK
xWPlSZT/sxpWPTC/gowJWlbuzhpS9v25Y2kLhnp5lQTbH71XUtZ10CkFDWMDC//5
GMytaAK4TruCWtM7sGFPcv2Tnq+oPJjWipkGUo0lnex45z7s+ZUilzCJActzJwlO
NtsMKOhpWR0caClqgL0bkse39T9BA8Sj/bwz6nPUZoOhebDWF9eRdoh1E1y67cYt
U50tj9qG2ks0jc0RnX0F/RbIJ277P5+NcgilcVG2ri6qiiQzWDfPwwB5x/EToTdn
D5zLrc6HrH+RP1Ul7FRZub1pB8pIOwl1oXiewj3eKtU9A+jh7RQ23LhHJj8XbGSO
0nr/VmWBp9yROpPCL2i/7ZP8lwPPlnHnhuAOl4wdmQnOfU/VU79cdJBflqZ8U7dm
HfEGaFUXBtvt2AbO9UhFilJce5Yoh+LxT9j1JrmLBX9HFmLQXM9wK4pHUw3IG2ja
mEJcig9MYQBlX3tZ4Pqg93jZsw4zdrFoem3tpln6zYdPTb/3HCWS1EsTVMpc4AVc
YSM9lGML5ewEWkCBUUhcbUUJSKcmaVgv5tNPGZhbCbCYUQn2afh0PSpSFbMPMXa3
JdiG7GdG+FD8ZWD6qgW6
=crtt
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
