From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: Request for OMAPDSS testing
Date: Sun, 9 Jun 2013 17:28:16 +0300
Message-ID: <CANOLnONCuV_mXJAx8fahUraypeewug7RjNGyhXqVm8FYRAAUcg@mail.gmail.com>
References: <51AD99F5.7060506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:59260 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928Ab3FIO2R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Jun 2013 10:28:17 -0400
Received: by mail-oa0-f43.google.com with SMTP id i7so3383140oag.2
        for <linux-omap@vger.kernel.org>; Sun, 09 Jun 2013 07:28:16 -0700 (PDT)
In-Reply-To: <51AD99F5.7060506@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Igor Grinberg <grinberg@compulab.co.il>, Thomas Weber <weber@corscience.de>, Mike Rapoport <mike@compulab.co.il>, Steve Sakoman <steve@sakoman.com>, linux-omap <linux-omap@vger.kernel.org>

Hello,

On Tue, Jun 4, 2013 at 10:40 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> I've made some big changes on the omapdss device model, which involve=
s
> converting all the panel drivers. I've got only a bunch of boards, so=
 I
> hope some of you can perhaps do some minimal tests on some other boar=
ds.

Doesn't work on pandora (legacy boardfile boot):

[    1.418823] OMAP DSS rev 2.0
[    1.447448] omapfb omapfb: no displays
[    1.454101] omapfb omapfb: failed to setup omapfb
[    1.459106] platform omapfb: Driver omapfb requests probe deferral
=2E..
[    2.156860] panel-tpo-td043mtea1 spi1.1: failed to get LCD VCC regul=
ator
[    2.164093] spi spi1.1: Driver panel-tpo-td043mtea1 requests probe d=
eferral
=2E..

Needs this small patch:

--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -335,7 +338,7 @@ static struct regulator_consumer_supply
pandora_vdds_supplies[] =3D {
 };

 static struct regulator_consumer_supply pandora_vcc_lcd_supply[] =3D {
-       REGULATOR_SUPPLY("vcc", "display0"),
+       REGULATOR_SUPPLY("vcc", "spi1.1"),
 };

 static struct regulator_consumer_supply pandora_usb_phy_supply[] =3D {

With that it shows Tux and fb console fine, so with above hunk:
Tested-by: Grazvydas Ignotas <notasas@gmail.com>


--
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
