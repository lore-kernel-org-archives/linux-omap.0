From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: Add new omap_dss_device after dss_device_registration
Date: Mon, 01 Nov 2010 16:53:05 +0200
Message-ID: <1288623185.5614.50.camel@tubuntu>
References: <AANLkTi=ph99HPyzNunrjKZnQqrndghCV5DVTUizjNN9+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:56475 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528Ab0KAOws (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Nov 2010 10:52:48 -0400
In-Reply-To: <AANLkTi=ph99HPyzNunrjKZnQqrndghCV5DVTUizjNN9+@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Enric =?ISO-8859-1?Q?Balletb=F2?= i Serra <eballetbo@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2010-10-27 at 13:39 +0200, ext Enric Balletb=C3=B2 i Serra wrot=
e:
> Hello all,
>=20
> Can I add a new omap_dss_device after dss_device registration  ?
> Something like add_new_omap_dss_device(lcd_device) or similar ?
>=20
> On IGEP v2 we register only igep2_dvi_device as dss_device, We want t=
o
> add a new dss_device (igep2_lcd_device) after dss registration. Is it
> possible ?
>=20
> For example we want to do something like this :
>=20
>   step 1: register IGEP v2  dss_devices (dvi)
>   step 2: detect if IGEP expansion board is detected.
>   step 3: if it's detected add new dss_devices (lcd)

Hmm... Not quite like that, I think.

I think you have to have both devices in the omap_dss_board_info, and
you have to have the drivers for both devices loaded when omapfb starts=
=2E

But you don't necessarily have to use the second driver, and you could
have its enable() fail if the expansion board is missing.

 Tomi


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
