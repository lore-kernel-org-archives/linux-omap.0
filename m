From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: dts: am437x-gp-evm: Do not reset gpio5
Date: Mon, 24 Mar 2014 14:22:13 -0500
Message-ID: <20140324192213.GG12500@saruman.home>
References: <1395379213-15451-1-git-send-email-lokeshvutla@ti.com>
 <20140321055242.GA1959@saruman.home>
 <53304F76.8090703@ti.com>
 <20140324185027.GC12500@saruman.home>
 <5330810A.3090004@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YrQNB5Deg1WGKZi3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47752 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753811AbaCXTYe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Mar 2014 15:24:34 -0400
Content-Disposition: inline
In-Reply-To: <5330810A.3090004@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: balbi@ti.com, Dave Gerlach <d-gerlach@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com, tony@atomide.com, devicetree@vger.kernel.org, nsekhar@ti.com, rnayak@ti.com, mark.rutland@arm.com

--YrQNB5Deg1WGKZi3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 24, 2014 at 02:01:30PM -0500, Nishanth Menon wrote:
> On 03/24/2014 01:50 PM, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Mon, Mar 24, 2014 at 10:29:58AM -0500, Dave Gerlach wrote:
> >> On 03/21/2014 12:52 AM, Felipe Balbi wrote:
> >>> On Fri, Mar 21, 2014 at 10:50:13AM +0530, Lokesh Vutla wrote:
> >>>> From: Dave Gerlach <d-gerlach@ti.com>
> >>>>
> >>>> Do not reset GPIO5 at boot-up because GPIO5_7 is used
> >>>> on AM437x GP-EVM to control VTT regulators on DDR3.
> >>>> Without this some GP-EVM boards will fail to boot because
> >>>> of DDR3 corruption.
> >>>>
> >>>> Reported-by: Nishanth Menon <nm@ti.com>
> >>>> Tested-by: Nishanth Menon <nm@ti.com>
> >>>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> >>>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> >>>
> >>> every now and again we see a patch like this because yet another board
> >>> is using a GPIO to toggle DDR regulators.
> >>>
> >>> Instead of constantly patching things like this, how about we try
> >>> something like below (build-tested only):
> >>
> >> Why should we change all of them? Is it correct to leave every single =
GPIO
> >> at the mercy of the bootloader in every situation? The reason we see t=
hese
> >=20
> > it's not leaving anything at the mercy of the bootloader. It's simply
> > looking at the HW itself and asking "what's the current state of this
> > GPIO ?"
>=20
> And you assume here that every GPIO pin left in what ever state by
> bootloader is the correct state for kernel to function in? that is not
> exactly a good idea from even power consumption perspective - example

right, it's a much better idea to reset the IP which, well, enables the
f-ing DDR. Congrats!

> GPIOs used by bootloader to detect board revision is not used in
> kernel, leaving such GPIOs active is not optimal, certain other GPIOs
> used by external peripherals might even be wrongly configured by
> bootloader issues -> the idea of ti,no-reset-on-init is to ensure that
> we *know* which instances "need special handling" and we depend on
> bootloader configuration.

or you can just make your driver smarter and for GPIOs which are not
used by the kernel, you ignore context save-restore.

The problem is that our GPIO driver is so fucked up that nobody really
cares about fixing it. If you really wanted to fix it, it wouldn't be
really difficult to make use of pm_runtime's (and clock API's) usage
counters to avoid keeping certain blocks up when not necessary.

> Taking it a step further, why is "not doing IP module kernel reset"
> just a constraint for GPIO then? Why not leave every IP module in what
> ever state bootloader left it at?

yeah, that's exactly what I suggested. Thanks for clarifying what *I*
*SAID*.

> >> patches only every now and again is because it's a special case that s=
hould
> >=20
> > I wouldn't call it "special". A GPIO block is pretty dumb, its registers
> > only give you current pin state, there's virtually no state machine
> > involved whatsoever.
> >=20
> >> be handled only for that situation. I also don't think it makes sense
> >> to make gpio's a unique case that never gets reset while every other
> >> IP does by default.
> >=20
> > Well, if it doesn't need to be reset, why would you spend that time
> > resetting it ? In the GPIO case, you gain nothing by resetting the IP,
> > nothing at all, other than "now I'm sure the IP is in
> > no-standby/no-idle" but that can be easily read back from SYS[SC]
> > registers anyway.
>=20
> because, you do not know how else the system might be used. instead of
> assuming the bootloader or host OS (in a virtualized environment) will
> always be doing the right thing, kernel takes responsibility of
> peripherals and exceptions are clearly marked (such as with
> ti,no-reset-on-init;).

yada, yada, yada...

> > The point is that we have two choices here:
> >=20
> > a) every time a new board comes around using GPIO as an enable signal
> > for DDR, we spend a few days debugging why it's not booting.
>=20
> yeah - read the darned schematics - this is valid for anyone doing
> board/platform bringup - this is the right way to do it.

sure, I'll let you handle that next time, be my guest.

> > b) make sure no GPIO block is ever reset, so we never go through the
> > debugging cycle again.
> >=20
> the holy grail of new bugs! Sigh!

right, our code so god-damned perfect, ain't it ? We better not touch it
anymore. Fair enough, I withdraw my comments, do as you wish.

--=20
balbi

--YrQNB5Deg1WGKZi3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTMIXlAAoJEIaOsuA1yqREYwwQAINALPIMBxAg3lGMaCtcLSMD
LC00ZqGbdDoOBz4iSYFR020SHOHFfhiZxBLcjN/Gac+9+7CjgtcHAeuBloKpgf3t
y6p7e0wWdbe3HTGDFmY5K6PTbpxp99OLKy7DMVJWvRLE5C2BzwohLyuFDemq6jZ9
K5ZEN38I7JFQAdFwneNJufr1ZYkpoHTH8KRuFXGKJ0eKqtika33YFU8c4+EM8Wfk
0E+pG0RrFwdzb/kXsR03rxTFH9v0Ip1GFLFhad/Y0grhS+YnQi0BHBb9zwhGLalR
t1rKH6lkHeDDORZV3b465gACD8X/t4tMT7Dh54QIp7UiLBUVExZ7Us9hzg/bh9QY
glAAiGp+S+UqMWmSMyNzxn0Tt+x7ysOZSRsaKiGIQEnMRc3/FU+xAUA2XJTsM+Hy
799NiCQSES8uWwKxa18rpKH79Bh2AhXy8bLaVS6jnIZ5GNWt10RzJCEk95+4A5sY
BQhGKTXWtw5H4SDTNsDp9MrQ2qRkSvgDHg9xb/zbpW7ldIRXP4bz0fMiAs0VFsbG
S4EAMFUji4R2fyhgG3FBbITRj5sfFoXrQuycfTSbYmJNEQW/Wmp9e80LSmftYz9T
e4aUTCBrVPl3ah9lsaz+Wm5D5LIP0031kIPSOF+oJ1n29DSwtNYh3JeY/gPF6h7D
mlXAAoz/POWipk3PRyY4
=G323
-----END PGP SIGNATURE-----

--YrQNB5Deg1WGKZi3--
