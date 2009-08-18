From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: SDP support seems broken in LO
Date: Tue, 18 Aug 2009 18:30:43 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0309BD5C0A@dbde02.ent.ti.com>
References: <ce9ab5790908180519t644723cbw6876901066f1f213@mail.gmail.com>
 	<EAF47CD23C76F840A9E7FCE10091EFAB02B9DCC60E@dbde02.ent.ti.com>
 <ce9ab5790908180558m184fd48euece1093575160c0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34483 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312AbZHRNAt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Aug 2009 09:00:49 -0400
In-Reply-To: <ce9ab5790908180558m184fd48euece1093575160c0c@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vimal singh <vimal.newwork@gmail.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> >> LO seems broken on OMAP3430 SDP platform. I compile latest kernel =
with
> >> 'omap_3430sdp_defconfig' config options.
> >>
> >> Booting hangs after kernel uncompressed and last message which app=
ears
> >> is 'booting the kernel'
> >>
> >>
> >> Thanks and regards,
> >> vimal
> >>
> >> See below log:
> >>
> >> ## Booting image at 80000000 ...
> >> =A0 =A0Image Name: =A0 Linux-2.6.31-rc5-omap1-05896-ge0
> >> =A0 =A0Image Type: =A0 ARM Linux Kernel Image (uncompressed)
> >> =A0 =A0Data Size: =A0 =A02520992 Bytes =3D =A02.4 MB
> >> =A0 =A0Load Address: 80008000
> >> =A0 =A0Entry Point: =A080008000
> >> =A0 =A0Verifying Checksum ... OK
> >> OK
> >>
> >> Starting kernel ...
> >>
> >> Uncompressing Linux...............................................=
=2E.....................
> >>=20
> ..............................................................
> ............
> >> ..................
> >> done, booting the kernel.
> > Mainly because of frame-buffer and musb. You can try disabling thes=
e two and see if it boots.
>=20
> I disabled frame-buffer and usb support fully:
> # CONFIG_FB is not set
> # CONFIG_USB_SUPPORT is not set
>=20
> I still get same message.
>=20
> -vimal
>=20


Do you have CONFIG_DEBUG_LL enabled? If so, could you enable that pleas=
e to
see if we have a crash somewhere?

- Anand
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
