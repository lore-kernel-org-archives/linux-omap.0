From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/RFT PATCH 0/2] SERIAL: OMAP: Remove idle handling from
 driver
Date: Mon, 18 Feb 2013 12:10:32 +0200
Message-ID: <20130218101032.GA32688@arwen.pp.htv.fi>
References: <1360929970-31934-1-git-send-email-santosh.shilimkar@ti.com>
 <5121FCC8.7090604@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58523 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754751Ab3BRKLG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Feb 2013 05:11:06 -0500
Content-Disposition: inline
In-Reply-To: <5121FCC8.7090604@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, balbi@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 18, 2013 at 03:34:56PM +0530, Santosh Shilimkar wrote:
> On Friday 15 February 2013 05:36 PM, Santosh Shilimkar wrote:
> >OMAP UART IP needs manual idle modes based on state of the
> >IP. Currently this is handled by the driver with function pointers
> >implemented in platform code.
> >
> >This however breaks in case of device tree because of missing
> >idle handling.
> >
> >The series tries to address the issue
> >
> >Patches has been tested on OMAP4 and OMAP5 devices where the console
> >slugishness was observed without idle mode handling. CPUIDLE and
> >suspend tested ok on these devices.
> >
> >Need help in testing on OMAP2, OMAP3 and AM3XXX devices.
> >
> >Santosh Shilimkar (2):
> >   ARM: OMAP2+: hwmod-data: UART IP needs software control of sidle
> >     modes
> >   SERIAL: OMAP: Remove the idle handling from the driver
> >
> HWMOD_SWSUP_SIDLE flag will is not what will help UART completely.
> Also considering UART also needs async wakeup enabled as it implements
> another such hook and attaches that through function pointer.

this is exactly what I said at [1], which I quote:

"Also, $SUBJECT isn't improving the situation regarding UART Wakeup,
there is still the regression of UART never being wakeup capable.

I wonder what are your ideas to sort that part out, I mean, how do you
plan to implement ->set_wake() for the tty port ?"

> So some more work is needed to get that sorted out at least from
> sysc point of view. That way we can deal with io_ring stuff using
> pin control APIs.
>=20
> Some patches will follow in attempt to address it. Stay tuned !!

good

--=20
balbi

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRIf4XAAoJEIaOsuA1yqREAHUQAKGlmBKzYJQfGCYY4AO2jRQW
BWKkxB4iTJsO3gEdVFe7ctlYuRP4zjJZoEnjSWquFyvgHqUZf7+dYcRsRxTBF4P1
rEAItvfyFF2iqKjU01x2bPpdeCLPMJXqQWljzhCVXs6K0pT7ZA0C5kpbcz5GcghB
GSq8enxKsUxV6RbPgD64ERPhdFyZFMqZMZ1ZlGKVO8fwDsUsQEZc83cX3o8x9yVx
KwEgWM8ZKtdX8wq+P8oVb9yDsf2rqgrDYawp08CY6Qy3iCqbqW5J89Jf11jWrPO0
5mRclreKxag9CiFeW/0eEscv2xcHXBv6dao6YPGC9VqXMZf5XTD3LlnFTRmBa00R
786gmQ1hOg0bckKvDRfi/ewTvMBoTzL6uW6gk4ojmITz/vppeTrtzT8WSthUaD1L
VogTXMRncz0N6IrZD0VwUj5QZVzxstaY1VBcwQ0n3U1Qw/pjrHQLiRLgK8Ahgar9
+0utvg4lOVR/n4xgHH091lmSPvuiEQyB7KElO1vCWIBHh3Flhtu0U1JK1H2/GmqK
inZKSaFASuBvX3X8zW2A0UcUk+GT5uMAp6/rP3CDP3K6bZRuohm7lDj096u6JHpi
HAjce+MKA6HxQzlOPfxvDSERtYEStfJfoDZ+g9nQjUMcUqODkJhkGV0xsBrAYOcn
2z4J4Wx4pzryZzMvN8gq
=gjFV
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
