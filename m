From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: PCM049: remove vusim regulator
Date: Fri, 15 Jul 2011 11:31:04 +0300
Message-ID: <20110715083103.GF2611@legolas.emea.dhcp.ti.com>
References: <1310554738.18446.12.camel@lws-weitzel>
 <1310554762-10743-1-git-send-email-j.weitzel@phytec.de>
 <4E1D8BCD.5060901@ru.mvista.com>
 <1310561772.18446.14.camel@lws-weitzel>
 <20110714073445.GL5783@atomide.com>
 <1310632792.4008.3.camel@lws-weitzel>
 <20110715075024.GO5783@atomide.com>
 <20110715075825.GB2611@legolas.emea.dhcp.ti.com>
 <20110715082012.GR5783@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+jhVVhN62yS6hEJ8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:51039 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965146Ab1GOIbI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jul 2011 04:31:08 -0400
Received: by mail-gw0-f53.google.com with SMTP id 20so547496gwj.26
        for <linux-omap@vger.kernel.org>; Fri, 15 Jul 2011 01:31:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110715082012.GR5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Jan Weitzel <J.Weitzel@phytec.de>, linux-omap@vger.kernel.org, Sergei Shtylyov <sshtylyov@mvista.com>, linux-arm-kernel@lists.infradead.org


--+jhVVhN62yS6hEJ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 15, 2011 at 01:20:12AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [110715 00:53]:
> > Hi,
> >=20
> > On Fri, Jul 15, 2011 at 12:50:24AM -0700, Tony Lindgren wrote:
> > > * Jan Weitzel <J.Weitzel@phytec.de> [110714 01:34]:
> > > > Am Donnerstag, den 14.07.2011, 00:34 -0700 schrieb Tony Lindgren:
> > > > > * Jan Weitzel <J.Weitzel@phytec.de> [110713 05:51]:
> > > > > > Am Mittwoch, den 13.07.2011, 16:13 +0400 schrieb Sergei Shtylyo=
v:
> > > > > >=20
> > > > > > >=20
> > > > > > >     Have you added that 'i' at the end intentionally?
> > > > > > >=20
> > > > > > Thank you. It was a tribute to vim.
> > > > >=20
> > > > > :i)
> > > > >=20
> > > > > I'll fold the fixed patch into your original patch. Will also
> > > > > keep the new board files in testing-board because of the code
> > > > > coalescing and device tree conversion effort.
> > > >=20
> > > > So there is no way to get the board mainline yet?
> > >=20
> > > Well we can add it even before device tree support if it makes
> > > sense from code coalescing point of view. In this case it would
> > > mean creating board-panda-common.c or similar so the code can
> > > be shared amongst the panda variants.
> > >=20
> > > It seems that some GPIO pins are different and there are some
> > > difference in devices connected, but big parts of the code can be
> > > shared.
> >=20
> > isn't it easier than to just add a few if (machine_is_xxxx()) checks and
> > another MACHINE_START() to board-omap4panda.c rather than creating a new
> > file, shuffling code around and then adding a new board file ??
>=20
> That works too if the init_machine does not get too complicated.

possibly something like this (still missing MACHINE_START a few more
things):

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/b=
oard-omap4panda.c
index 0cfe200..dff174c 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -681,20 +681,44 @@ void omap4_panda_display_init(void)
        omap_display_init(&omap4_panda_dss_data);
 }
=20
+static struct omap_smsc911x_platform_data board_smsc911x_data __initdata =
=3D {
+       .cs             =3D OMAP4_SMSC911X_ETH_CS,
+       .gpio_irq       =3D OMAP4_SMSC911X_ETH_GPIO_IRQ,
+       .gpio_reset     =3D -EINVAL,
+       .flags          =3D SMSC911X_USE_16BIT,
+};
+
+static void __init omap4_panda_smsc91xx_init(void)
+{
+       if (!machine_is_pcm049())
+               return;
+
+       omap_mux_init_gpio(OMAP4_PCM049_ETH_GPIO_IRQ, OMAP_PIN_INPUT);
+       gpmc_smsc911x_init(&board_smsc911x_data);
+}
+
 static void __init omap4_panda_init(void)
 {
        int package =3D OMAP_PACKAGE_CBS;
=20
        if (omap_rev() =3D=3D OMAP4430_REV_ES1_0)
                package =3D OMAP_PACKAGE_CBL;
+
        omap4_mux_init(board_mux, NULL, package);
=20
-       if (wl12xx_set_platform_data(&omap_panda_wlan_data))
-               pr_err("error setting wl12xx data\n");
+       if (machine_is_omap4panda()) {
+               int             ret;
+
+               ret =3D wl12xx_set_platform_data(&omap_panda_wlan_data);
+               if (ret)
+                       pr_err("error setting wl12xx data\n");
+
+               platform_device_register(&omap_vwlan_device);
+       }
=20
+       omap4_panda_smsc91xx_init();
        omap4_panda_i2c_init();
        platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
-       platform_device_register(&omap_vwlan_device);
        board_serial_init();
        omap4_twl6030_hsmmc_init(mmc);

--=20
balbi

--+jhVVhN62yS6hEJ8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOH/rHAAoJEAv8Txj19kN1fUIIAJGtCx3IE7xKmdsHIp7IAiww
bXEergC/tnRMUGy6hfZyJjpYJxxAG+1VIaEf4MrcpVYeEbzjioNFolgKB/mjPfbF
ItVhtqByS5SvUMU9ea6g+Du7j6UDFemS1dJJJNK9JQgmbYz3IjKuIaPz71SitFTI
itPYY40xQBmx2DxpYVLupPhYlPYeFPb5u8TwO2/M5V5qfTRduz6Oy+bAXQNLdnDv
bAFRtIuAVzW0+oLgh0IoPWemtMbSCjye6M6WrKaAW1WXPg9wr6TGRRW65JhcFJex
ce0PM3mbSOfyHbHf1DazvFm6j8VczYCbhQ7p6NQy7XH6lmdXX9mgSH0qLwas1/0=
=uscT
-----END PGP SIGNATURE-----

--+jhVVhN62yS6hEJ8--
