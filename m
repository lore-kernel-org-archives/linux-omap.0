From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/RFT PATCH 0/2] SERIAL: OMAP: Remove idle handling from
 driver
Date: Mon, 18 Feb 2013 12:45:41 +0200
Message-ID: <20130218104541.GD32688@arwen.pp.htv.fi>
References: <1360929970-31934-1-git-send-email-santosh.shilimkar@ti.com>
 <5121FCC8.7090604@ti.com>
 <20130218101032.GA32688@arwen.pp.htv.fi>
 <20130218101113.GB32688@arwen.pp.htv.fi>
 <5122019D.9030100@ti.com>
 <20130218104216.GC32688@arwen.pp.htv.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+KJYzRxRHjYqLGl5"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42140 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048Ab3BRKqB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Feb 2013 05:46:01 -0500
Content-Disposition: inline
In-Reply-To: <20130218104216.GC32688@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org

--+KJYzRxRHjYqLGl5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2013 at 12:42:16PM +0200, Felipe Balbi wrote:
> Hi,
>=20
> On Mon, Feb 18, 2013 at 03:55:33PM +0530, Santosh Shilimkar wrote:
> > >>I wonder what are your ideas to sort that part out, I mean, how do you
> > >>plan to implement ->set_wake() for the tty port ?"
> > >
> > >[1] http://marc.info/?l=3Dlinux-omap&m=3D136093334914275&w=3D2
> > >
> > The main need for uart wakeup is the io_ring() trigger and that needs
> > to happen via generic pin control API. SYSC wakeup bit isn't something
> > needs to be toggled so that can be decoupled. So again the idea is
> > to make SYSC handling transparent to UART drivers and let driver toggle
> > the io_ring() based on ->set_wake() as it is done today.
>=20
> We're either reading different code bases or not understanding each
> other. Currently this is how ->set_wake() is implemented:
>=20
> serial_omap_set_wake()
>  serial_omap_enable_wakeup()
>   omap_uart_enable_wakeup()
>    omap_hwmod_enable_wakeup()
>     if (SYSC_HAS_ENAWAKEUP) {	/* true for UART */
>      _enable_wakeup()
>      _write_sysconfig()
>     }
>     set_idle_ioring_wakeup()
>      if (!oh->mux || !oh->mux->enabled)
>       return;
>=20
> If I read the code correctly there's nothing setting oh->mux during DT
> boot. The only caller to omap_hwmod_mux_init() (which allocates and
> returns omap_hwmod_mux_info pointer) is
> arch/arm/mach-omap2/devices.c::omap4_keyboard_init(). This has nothing

actually arch/arm/mach-omap2/serial.c::omap_serial_init_port() also
calls that, but it's also not used during DT boots.

--=20
balbi

--+KJYzRxRHjYqLGl5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRIgZVAAoJEIaOsuA1yqREt8YP/AywQmNKa0JFxcfoZbl6pydG
X1F5hLnnmFzY1fRoW/odqfO9az28jC/Qj1/bSrrex9aNvaZMc/Hsd5IzAHKAduFx
MxvrlrXONLCtImICtSB4PapsYCrqGih7fFZKxvC9V5FYad9G5X/N6NXYahq8A/fB
NCEZrpjHGSnX/Xqz0WwandOaCddfqcKN8WoIT4N4NrVfqd9ETLp7YcVWp7YigJhf
Hcc9YUmAjJu9AO2czcXz3p1dSoBMLYtMRT/PNBxXS25cHOeyYUQpRXFcpRtBKgrR
7e7+HEFokDX5IP6caCQjAAt15bwPN3yUi9Cpj+rhkn1kYF9002gvAf52IBqvwl1i
XG5Iu/RMtTreeutFQh+RZhcaPnvUuN7ER4tNKBCs35Ubd+wPXszxjXdhbEe6F03h
d+k2M8h+u3odhrNwpInGv5vitJ0mjFe6lNQJPs5c7TtKWI9WkoLMWNgdLb+oyIOY
WzbYAkbvVO5fQC8wXua0gzeIQs+STO05jW5MejG6Ly6eWyJgWcq6ME1zT+CWG7Ux
VMsed3tM2A3p+/1nPZuqlYqivhut9OAWzEdYu/YZShPYCDK5heoRhPGyjiLtO7To
9Cjx8CVS4+IdR3YRNo4pUzEzUpkrhclUzHbQXObJ6FtaUhoeXvJykO44Qm0GflDH
UyST9nSTEE0wqr14/CHY
=0QKQ
-----END PGP SIGNATURE-----

--+KJYzRxRHjYqLGl5--
