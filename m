From: Patrick <kpa_info@yahoo.fr>
Subject: Re : [DSS2] kernel freeze with panel driver
Date: Tue, 31 Jan 2012 12:02:25 +0000 (GMT)
Message-ID: <1328011345.70354.YahooMailNeo@web29010.mail.ird.yahoo.com>
References: <1328007381.86237.YahooMailNeo@web29017.mail.ird.yahoo.com> <4F27CE83.3070608@ti.com>
Reply-To: Patrick <kpa_info@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm19-vm0.bullet.mail.ird.yahoo.com ([77.238.189.92]:45757 "HELO
	nm19-vm0.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753065Ab2AaMC1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jan 2012 07:02:27 -0500
In-Reply-To: <4F27CE83.3070608@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>Hi,
>
>On Tuesday 31 January 2012 04:26 PM, Patrick wrote:
>> Dear mailing-list,
>>
>>
>> I am working with a vanilla 3.0.17 kernel with some patch for my Oma=
p4430 based board.
>>
>> I am using the driver video/omap2/panel-lgphilips-lb025q02.c with a =
very similar screen.
>> I have added on my board init file the init code for both the SPI an=
d the panel, like below.
>>
>> static struct omap_dss_device sb_dpi_device =3D {
>>=A0 =A0 =A0 =A0 =A0 .type=A0 =A0 =A0 =A0 =A0 =A0 =A0  =3D OMAP_DISPLA=
Y_TYPE_DPI,
>>=A0 =A0 =A0 .name=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0  =3D "lcd35",
>>=A0 =A0 =A0 .driver_name=A0 =A0 =A0 =A0 =A0 =A0 =3D "lgphilips_lb035q=
02_panel",
>>=A0 =A0 =A0 .phy.dpi.data_lines=A0 =A0  =3D 24,
>>=A0 =A0 =A0 .platform_enable=A0 =A0 =A0 =A0 =3D sb_panel_enable_lcd,
>>=A0 =A0 =A0 .platform_disable=A0 =A0 =A0  =3D sb_panel_disable_lcd,
>> };
>>
>
>You have to add a channel field in this, like:
>
>=A0=A0 .channel =3D OMAP_DSS_CHANNEL_LCD2,
>
>On OMAP4, the DPI interface is connected to LCD2 interface and not LCD=
=20
>interface. That's why you get the error 'display 'lcd35' does not=20
>support manager 'lcd''
>
>Can you try with this change and see what happens?
>
>Archit

Yes it works, the kernel boot correctly up to the end.=20
The display doesn't display what I want but this is another problem ;-)

Thanks for your help.

Patrick

----- Mail original -----

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
