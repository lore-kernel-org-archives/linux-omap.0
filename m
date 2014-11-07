From: NeilBrown <neilb@suse.de>
Subject: [PATCH] ARM: OMAP: serial: remove last vestige of DTR_gpio support.
Date: Sat, 8 Nov 2014 10:42:46 +1100
Message-ID: <20141108104246.1f2da822@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/nBqHWY3RL8t_UFfGuaDwoDd"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

--Sig_/nBqHWY3RL8t_UFfGuaDwoDd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


These fields were added by:
commit 9574f36fb801035f6ab0fbb1b53ce2c12c17d100
    OMAP/serial: Add support for driving a GPIO as DTR.

but not removed by

commit 985bfd54c826c0ba873ca0adfd5589263e0c6ee2
    tty: serial: omap: remove some dead code

which reverted most of that commit.
Time to revert the rest.

Signed-off-by: NeilBrown <neilb@suse.de>

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index a388f8c1bcb3..57dee0c7cd2b 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -263,9 +263,6 @@ void __init omap_serial_init_port(struct omap_board_dat=
a *bdata,
 	omap_up.dma_rx_timeout =3D info->dma_rx_timeout;
 	omap_up.dma_rx_poll_rate =3D info->dma_rx_poll_rate;
 	omap_up.autosuspend_timeout =3D info->autosuspend_timeout;
-	omap_up.DTR_gpio =3D info->DTR_gpio;
-	omap_up.DTR_inverted =3D info->DTR_inverted;
-	omap_up.DTR_present =3D info->DTR_present;
=20
 	pdata =3D &omap_up;
 	pdata_size =3D sizeof(struct omap_uart_port_info);
diff --git a/include/linux/platform_data/serial-omap.h b/include/linux/plat=
form_data/serial-omap.h
index c860c1b314c0..d09275f3cde3 100644
--- a/include/linux/platform_data/serial-omap.h
+++ b/include/linux/platform_data/serial-omap.h
@@ -38,9 +38,6 @@ struct omap_uart_port_info {
 	unsigned int		dma_rx_timeout;
 	unsigned int		autosuspend_timeout;
 	unsigned int		dma_rx_poll_rate;
-	int			DTR_gpio;
-	int			DTR_inverted;
-	int			DTR_present;
=20
 	int (*get_context_loss_count)(struct device *);
 	void (*enable_wakeup)(struct device *, bool);

--Sig_/nBqHWY3RL8t_UFfGuaDwoDd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVF1Y9jnsnt1WYoG5AQJ0GQ/+MKO66kVJoX9g90YxCsyS3+bmFN8t68TZ
O6L5nUFLLzf0GHKzgiL98LOZjsY1Xk+hNN0yjF7meLq8mKLNws4VhDkVXwXSGcHX
KI1U4NcCj43a/gPQEfizeE0yfmZ1nLtqdi+1mHicNTLch++hUCh6t5tg8diN3JpJ
wAGRd+6jDRhcc8SQ8QX2CCUuHkqiFTluzT9n7qyZcq1CzfZpXSfu8g+/Jgwyyqzl
+ulUjlQ+0Crzsy8blhMG/VdSM2d5LU+AhjHLtAGd2r8SG+nC0vOX3rrsP0o8bnMz
ywZDjRkbVvMrIkXK6ntgMAWoH6qdkGz/5m1SzMoL3L6zyj9LEGePhjghvzymvmDe
6d1GHDZn6CfA3R3eG0B1qlkXuWbKhbkkXt8U1JQ5Ea5+68FQZgzieGNeN/KFYpYy
pXVN+MLyL4k4gOmunpGrKroJ4incVX6XNcU0OeOeQmJP5fUAF7im3JxQ3lKaUhTQ
sIVGdwkSyfuBgLL0F0uWeg5DeqTyvJlhsI4PyQP8BL4UhuqrynXxRoKkDCh3lw1P
wefNlgsQ1mXmTshYzRXOgf/VmC9w3QDPy5ijjDXl3rZuuzU7b6YmQG2zCfK9etrN
6+Vsmz/3UR4V+LVtGcHl1c3q7ILKcFp6bwJ3XWpK9LB8xjjnUChtS/zwnYOt33z2
rPEJwwys1+o=
=fPh7
-----END PGP SIGNATURE-----

--Sig_/nBqHWY3RL8t_UFfGuaDwoDd--
