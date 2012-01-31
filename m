From: Patrick <kpa_info@yahoo.fr>
Subject: [DSS2] kernel freeze with panel driver
Date: Tue, 31 Jan 2012 10:56:21 +0000 (GMT)
Message-ID: <1328007381.86237.YahooMailNeo@web29017.mail.ird.yahoo.com>
Reply-To: Patrick <kpa_info@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm7-vm0.bullet.mail.ird.yahoo.com ([77.238.189.222]:43934 "HELO
	nm7-vm0.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752804Ab2AaLBz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jan 2012 06:01:55 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Dear mailing-list,


I am working with a vanilla 3.0.17 kernel with some patch for my Omap44=
30 based board.

I am using the driver video/omap2/panel-lgphilips-lb025q02.c with a ver=
y similar screen.
I have added on my board init file the init code for both the SPI and t=
he panel, like below.

static struct omap_dss_device sb_dpi_device =3D {
=A0=A0=A0=A0=A0=A0=A0 .type=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=
 OMAP_DISPLAY_TYPE_DPI,
=A0=A0=A0 .name=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=
 "lcd35",
=A0=A0=A0 .driver_name=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D "lgphilips_=
lb035q02_panel",
=A0=A0=A0 .phy.dpi.data_lines=A0=A0=A0=A0 =3D 24,
=A0=A0=A0 .platform_enable=A0=A0=A0=A0=A0=A0=A0 =3D sb_panel_enable_lcd=
,
=A0=A0=A0 .platform_disable=A0=A0=A0=A0=A0=A0 =3D sb_panel_disable_lcd,
};


=2E..


static struct spi_board_info sb_spi_board_info[] __initdata =3D {
=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .modalias=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 =3D "lgphilips_lb035q02_panel-spi",
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .bus_num=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 1,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .chip_select=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =3D 0,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .max_speed_hz=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =3D 500000,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .mode=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D SPI_MODE_3,
=A0=A0=A0=A0=A0=A0=A0 },
};

The init of the SPI is done before the one of the panel.


When my kernel boot he freeze (without error message) at the moment whe=
re it should do the :
"Console: switching to colour frame buffer device..."
But in my case it freeze somewhere just before this print.

Earlier in the boot process I have the following error message:=A0
=A0=A0=A0 OMAP DSS rev 4.0
=A0=A0=A0 omapdss MANAGER error: display 'lcd35' does not support manag=
er 'lcd'

Lcd35 is the name of the screen declared in the board config file.
I use the followings bootargs: omapdss.def_disp=3Dlcd35 omapdss.debug=3D=
y vram=3D10M=A0


I have tried with the video/omap2/panel-generic-display.c driver with t=
he correct timming.=20

The kernel boot but the screen doesn't work correctly (Only one vertica=
l line is colored).

I have tried with panel-lgphilips-lb025q02.c but with initialising only=
 the SPI from the board config file (without calling the display init).=
 The kernel boot but of course the screen doesn't work at all. So it se=
ems that the problem is not from the SPI side.


Do you have any idea why I have this problems ?

Thanks in advance for your help.

Patrick







static struct spi_board_info sb_spi_board_info[] __initdata =3D {
=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .modalias=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 =3D "lgphilips_lb035q02_panel-spi",
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .bus_num=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 1,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .chip_select=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =3D 0,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .max_speed_hz=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =3D 500000,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .mode=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D SPI_MODE_3,
=A0=A0=A0=A0=A0=A0=A0 },
};

I init the SPI before the panel as in your overo board file.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
