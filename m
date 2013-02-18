From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/RFT PATCH 0/2] SERIAL: OMAP: Remove idle handling from
 driver
Date: Mon, 18 Feb 2013 12:42:16 +0200
Message-ID: <20130218104216.GC32688@arwen.pp.htv.fi>
References: <1360929970-31934-1-git-send-email-santosh.shilimkar@ti.com>
 <5121FCC8.7090604@ti.com>
 <20130218101032.GA32688@arwen.pp.htv.fi>
 <20130218101113.GB32688@arwen.pp.htv.fi>
 <5122019D.9030100@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51321 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851Ab3BRKmi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Feb 2013 05:42:38 -0500
Content-Disposition: inline
In-Reply-To: <5122019D.9030100@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org

--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 18, 2013 at 03:55:33PM +0530, Santosh Shilimkar wrote:
> >>I wonder what are your ideas to sort that part out, I mean, how do you
> >>plan to implement ->set_wake() for the tty port ?"
> >
> >[1] http://marc.info/?l=3Dlinux-omap&m=3D136093334914275&w=3D2
> >
> The main need for uart wakeup is the io_ring() trigger and that needs
> to happen via generic pin control API. SYSC wakeup bit isn't something
> needs to be toggled so that can be decoupled. So again the idea is
> to make SYSC handling transparent to UART drivers and let driver toggle
> the io_ring() based on ->set_wake() as it is done today.

We're either reading different code bases or not understanding each
other. Currently this is how ->set_wake() is implemented:

serial_omap_set_wake()
 serial_omap_enable_wakeup()
  omap_uart_enable_wakeup()
   omap_hwmod_enable_wakeup()
    if (SYSC_HAS_ENAWAKEUP) {	/* true for UART */
     _enable_wakeup()
     _write_sysconfig()
    }
    set_idle_ioring_wakeup()
     if (!oh->mux || !oh->mux->enabled)
      return;

If I read the code correctly there's nothing setting oh->mux during DT
boot. The only caller to omap_hwmod_mux_init() (which allocates and
returns omap_hwmod_mux_info pointer) is
arch/arm/mach-omap2/devices.c::omap4_keyboard_init(). This has nothing
to do with UART and, even more importantly, isn't even called during a
DT boot.

So, is there something else setting oh->mux to a valid pointer and
actually making set_idle_ioring_wakeup() do something useful ?

--=20
balbi

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRIgWIAAoJEIaOsuA1yqREZIsQAKxwRd8CqqCukABPR9VEye0B
EnHJKVTVKTq2j4wcTaDstlnL+cAZQyY102jXJEwW+BVY5DEi6A+jQ10ubVmtN0s6
hdZsbcE+nqM6ZErIxs1bzg6/K3NRjoAehzd7ny6elgzhNcsa8MmL22bjKNdGugGo
IpowVx8AlnHK2MHSOvq+4i3jTJ2euISpnJ5pMaw3JAavtkCqW1kJO1yGOLGqNFOB
XBAOlPJEOFXGSnt00ngTPHRe8yhRnolgUa6tWPiiHm36+m4iDbujeF8x3QO7ULmb
BTIg77AJS0MmtTQ7gGJZlXvsP3fZT/2ZWuo1iuN3k+pr7JqDGkRQiChxCUrO3+86
HJVfGjH1jmbxf4Iy0FOqJvT5UUq2AG9hJdGDZQV35z50VwpwCvilgSZI563Z1THe
V19383DDJaTiW8GVD9EXb1JTMspc6FL/2SZ5g3VJl/kcoKg1C60Msh7eki/0RUF5
/m/fUtZDMZy+Cm9725TgzSajXbLTvr+tjkd87JwAcFfSzBT/OXmM97NF5X9GwjLH
jm4IRa0zeoLcBSTabu7689iGV9FaOxc4UuU/N4YAoc8Q7aHnA3YCZYGYDN6xeUYX
fiDAd40N3RJSv1adkVe55hHy909Z+V9I3FYvQVln3p7veupxMEnbBepkZpKkbkqk
xk9ZrP+rlO9RNKwk9cn+
=weEY
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
