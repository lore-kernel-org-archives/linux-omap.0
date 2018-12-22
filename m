From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 00/14] Add support for FM radio in hcill and kill TI_ST
Date: Sat, 22 Dec 2018 03:47:53 +0100
Message-ID: <20181222024753.d4mge5m3x3vqfrt6@earth.universe>
References: <20181221011752.25627-1-sre@kernel.org>
 <20181221180205.GH6707@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3hrdbokkqizipcn6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181221180205.GH6707@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, linux-bluetooth@vger.kernel.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--3hrdbokkqizipcn6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 21, 2018 at 10:02:05AM -0800, Tony Lindgren wrote:
> * Sebastian Reichel <sre@kernel.org> [181221 01:18]:
> > The new code has been tested on the Motorola Droid 4. For testing the a=
udio
> > should be configured to route Ext to Speaker or Headphone. Then you nee=
d to
> > plug headphone, since its cable is used as antenna. For testing there i=
s a
> > 'radio' utility packages in Debian. When you start the utility you need=
 to
> > specify a frequency, since initial get_frequency returns an error:
>=20
> Nice, good to see that ti-st kim stuff gone :) I gave this a quick
> try using fmtools.git and fmscan works just fine. No luck yet with
> fm though, it gives VIDIOC_G_CTRL: Not a tty error somehow so
> maybe I'm missing some options, patch below for omap2plus_defconfig.

I only did a few quick tests with 'radio' utility. I could scan
for stations and I could listen to some station. I suppose the
wl128x-radio driver has some buggy code paths, but that are
unrelated to this patchset.

> Hmm so looks like nothing to configure for the clocks or
> CPCAP_BIT_ST_L_TIMESLOT bits for cap for the EXT? So the
> wl12xx audio is wired directly to cpcap EXT then and not a
> TDM slot on the mcbsp huh?

For FM radio it's directly wired to EXT with no DAI being required.
I think that EXT is only used by FM radio and not by bluetooth. BT
seems to use TDM.

> > Merry Christmas!
>=20
> Same to you!
>=20
> Tony
>=20
> 8< --------------------------------
> From tony Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony@atomide.com>
> Date: Fri, 21 Dec 2018 07:57:09 -0800
> Subject: [PATCH] ARM: omap2plus_defconfig: Add RADIO_WL128X as a loadable
>  module
>=20
> This allows using the FM radio in the wl12xx chips after modprobe
> fm_drv using radio from xawt, or fmtools.

Mh. I suppose I forgot to add alias to support autoloading the
FM module.

> Note that the firmware placed into /lib/firmware/ti-connectivity
> directory:
>=20
> fm_rx_ch8_1283.2.bts
> fmc_ch8_1283.2.bts

There is also a TX firmware. The Droid 4's chip should support this,
but I don't know if there is audio routing for this feature.

-- Sebastian

> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/configs/omap2plus_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap=
2plus_defconfig
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -126,6 +126,7 @@ CONFIG_AF_RXRPC=3Dm
>  CONFIG_RXKAD=3Dy
>  CONFIG_CFG80211=3Dm
>  CONFIG_MAC80211=3Dm
> +CONFIG_RFKILL=3Dm
>  CONFIG_DEVTMPFS=3Dy
>  CONFIG_DEVTMPFS_MOUNT=3Dy
>  CONFIG_DMA_CMA=3Dy
> @@ -343,12 +344,14 @@ CONFIG_IR_GPIO_TX=3Dm
>  CONFIG_IR_PWM_TX=3Dm
>  CONFIG_MEDIA_SUPPORT=3Dm
>  CONFIG_MEDIA_CAMERA_SUPPORT=3Dy
> +CONFIG_MEDIA_RADIO_SUPPORT=3Dy
>  CONFIG_MEDIA_CEC_SUPPORT=3Dy
>  CONFIG_MEDIA_CONTROLLER=3Dy
>  CONFIG_VIDEO_V4L2_SUBDEV_API=3Dy
>  CONFIG_V4L_PLATFORM_DRIVERS=3Dy
>  CONFIG_VIDEO_OMAP3=3Dm
>  CONFIG_CEC_PLATFORM_DRIVERS=3Dy
> +CONFIG_RADIO_WL128X=3Dm
>  # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
>  CONFIG_VIDEO_TVP5150=3Dm
>  CONFIG_DRM=3Dm
> --=20
> 2.19.2

--3hrdbokkqizipcn6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwdpdIACgkQ2O7X88g7
+pog9RAAicrkY0H2lCVIlUA9qSrLEkeVDH3Vt9v1L6ulOHpoHU1QHCoBFmUTkWCx
QPYrdi4zPunE9eht+RwqiMUwIqiIz4x33GF+bgEXSMXFTqzIcgvKFjYBVGTIGZgz
umyuN0qgrkYWaW1Jl/L0zHCG7FjrR8WQb6s5P62uayWRY6kT9tIbyHOQz8g1320j
wOhJ3ChUlc9sLIy91wxU9zAInDq7CkonXJwJ+InNhuptr13G5QfPZGEg72805vkI
Y8julEZNZvFbCh8OqY5K90aj7Jhn0qUFxorZ7WaA7+hcJZI9ThdiK9ZAAIjnulB1
zA3SOyO7oazvDdHJhKhHw10b9kcJLwDjnPrHpWHlVYdwt+61AkKdivqjxYyA14JN
Yk/2SxFvfss2lnXfvWjeGJXEnQ/ngSF6iZDPSLTNjhEg39o4TdvvMI5YTqNzkFFV
H42M02AWxkxXM72UOaM1nUEpqQcD1r+e8MZWPeH0CbWoMso2OGVw2fYxvXQ/01kx
2TK6jx7fZ7RNZQj1ID+fqvIegvj/8q5LFK0LZnEbGEK9kPiixLU9ZWuoK1IHbvLC
Km35L0wnHcs3ovhA+T08iAhL1y4Ti/0sWJP+s21RIIxj+p/O8UZq0xe4Dusm+sjL
nTUBKayxzha0ZVVz7qKMTGN2ekjDSCIahxrO4aCUMZx82GKnQGM=
=C94d
-----END PGP SIGNATURE-----

--3hrdbokkqizipcn6--
