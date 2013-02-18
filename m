From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/RFT PATCH 0/2] SERIAL: OMAP: Remove idle handling from
 driver
Date: Mon, 18 Feb 2013 13:13:08 +0200
Message-ID: <20130218111308.GE32688@arwen.pp.htv.fi>
References: <1360929970-31934-1-git-send-email-santosh.shilimkar@ti.com>
 <5121FCC8.7090604@ti.com>
 <20130218101032.GA32688@arwen.pp.htv.fi>
 <20130218101113.GB32688@arwen.pp.htv.fi>
 <5122019D.9030100@ti.com>
 <20130218104216.GC32688@arwen.pp.htv.fi>
 <20130218104541.GD32688@arwen.pp.htv.fi>
 <512208BE.7060207@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tVmo9FyGdCe4F4YN"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43051 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751598Ab3BRLNc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Feb 2013 06:13:32 -0500
Content-Disposition: inline
In-Reply-To: <512208BE.7060207@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org

--tVmo9FyGdCe4F4YN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 18, 2013 at 04:25:58PM +0530, Santosh Shilimkar wrote:
> >>If I read the code correctly there's nothing setting oh->mux during DT
> >>boot. The only caller to omap_hwmod_mux_init() (which allocates and
> >>returns omap_hwmod_mux_info pointer) is
> >>arch/arm/mach-omap2/devices.c::omap4_keyboard_init(). This has nothing
> >
> >actually arch/arm/mach-omap2/serial.c::omap_serial_init_port() also
> >calls that, but it's also not used during DT boots.
> >
> DT boot, all the function pointers are broken so wakeup as well as slave
> idle-mode is broken. Nothing new here. Serial file does set the pads
> as you noticed and this is what can be offloaded to generic pint control
> which can triggered from driver.

fair enough, understood now.

cheers

--=20
balbi

--tVmo9FyGdCe4F4YN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRIgzEAAoJEIaOsuA1yqRE2nMQAIcStb2SkZVj+pC8hyrQEehh
RmXZsZTKGvK21s9bK2aHi3xDBe5E5WhVJXKHemZX440QGDNB95GtPHYVq8OJ7DyS
4jYoYobXgIjJRsh07vZ7a3U7WdKacTFhrouvZDVmI/q5FF8YNYT2R8uvAhp73C5T
FmI6kpJOMMwPKpB/m8BZikm0Q7xSX3mD85Q2EC428yUj/nekBOk4KIuayeXHQ0Ak
rQb5e/f9G54SP7POSKXTKB9wMchZIzObauoND+yISY4PGqJ85X3U03fpqmm02mNA
5QiDKaDzNkG7/ttD4OhcptTEBVftcu/D0vmLAOqsklyZL4VVOn8DVF8w4aErX7bx
mz+30OlxtLRj7ieECAf+SuRiAdRCuVj1gEh8FmgrUbUcf9l7uIQYvvaBQ4586+iB
fGxhYSFqFXmj6mhxBpeIFjdf+jlkzOv+6bcm4tQvhek8CEdfd8umCbZqBtkdPO10
hbSPg1Wgi6Ul3bYFQnYTqkLOxYPA0i3AYKVNHki0tZ8xmXwGeLfgpHI7t8+p0J/x
L9I3LGDfIS3elndwwXoozkZ0G3UvrWDLe3PZ7o4S3SYiY3FY4GIrlbUUDqFjhveT
cCjj31Zgh2mGsaXpFGQIH+gcRv/ezF0MqsSTbVc5M5H89hjnq8AUyRT1SOAN69vh
NMw/m7TfQPzQddbAcXfZ
=5G6I
-----END PGP SIGNATURE-----

--tVmo9FyGdCe4F4YN--
