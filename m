From: Felipe Balbi <balbi@ti.com>
Subject: Re: USB Ethernet gadget doesn't work with DM3730
Date: Fri, 29 Jul 2011 12:41:45 +0300
Message-ID: <20110729094143.GD31013@legolas.emea.dhcp.ti.com>
References: <CAFqH_51nn9GoBAKXg-1gLr66OZvXgLSzh2XQGUNKC0NR4jg0KQ@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:47357 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755804Ab1G2Jlu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jul 2011 05:41:50 -0400
Content-Disposition: inline
In-Reply-To: <CAFqH_51nn9GoBAKXg-1gLr66OZvXgLSzh2XQGUNKC0NR4jg0KQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric =?iso-8859-1?Q?Balletb=F2?= i Serra <eballetbo@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 14, 2011 at 01:34:54PM +0200, Enric Balletb=F2 i Serra wrote:
> Playing with USB ethernet gadget on IGEP boards with mainline kernel
> (Linux 3.0.0-rc7) I observed one strange behavior. The ethernet gadget
> works with one board with OMAP3530 but it doesn't with another one
> with DM3730. The log looks like this:
>=20
> root@igep00x0:~# modprobe g_ether
>=20
> [   51.420257] g_ether gadget: using random host ethernet address
> [   51.427886] usb0: MAC da:93:4b:2d:55:e9
> [   51.431915] usb0: HOST MAC 42:47:83:70:46:b6
> [   51.436706] g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
> [   51.443725] g_ether gadget: g_ether ready
> [   51.447906] musb-hdrc musb-hdrc: MUSB HDRC host driver
> [   51.455871] musb-hdrc musb-hdrc: new USB bus registered, assigned
> bus number 1
> [   51.464141] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
> [   51.471313] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,
> SerialNumber=3D1
> [   51.478912] usb usb1: Product: MUSB HDRC host driver
> [   51.484161] usb usb1: Manufacturer: Linux 3.0.0-rc7-00027-g8d86e5f mus=
b-hcd
> [   51.491485] usb usb1: SerialNumber: musb-hdrc
> [   51.498321] hub 1-0:1.0: USB hub found
> [   51.502410] hub 1-0:1.0: 1 port detected
>=20
> root@igep00x0:~# ifconfig usb0 192.168.7.2
>=20
> usb0      Link encap:Ethernet  HWaddr DA:93:4B:2D:55:E9
>           inet addr:192.168.7.2  Bcast:192.168.7.255  Mask:255.255.255.0
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>=20
> root@igep00x0:~# ping 192.168.7.1
> PING 192.168.7.1 (192.168.7.1): 56 data bytes
>=20
> With DM3730 I can't ping the other side (the same configuration with
> OMAP3530 works without problems). Any clue on this ?

DMA problem ?? Can you check if PIO-only works ?

--=20
balbi

--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOMoBXAAoJEAv8Txj19kN1F7QH/0tpNcegZxJznJ7Oz1U2u7W+
plfO0HLXeOwDdTxpomQuBsLtuv9RTzmTq1mIlSTsiAVD+DteJ+PA3PUoXcuBrtLq
ZowI1soxmW84q2vlFY8o2A9Y3u9XE4wFcg0RKLaz2LScj3j17FnNAtH+vb3vfrf/
LrB2whdZh/SgN2QmqMFVUdx5T3AvU9zn/hIC4QAUI4/c4Ut2J/nw9gEpmsVXfsxB
TF/P2kniMHpWjLQ9JweJDR4mMGhTPjVWxqqSMlFLRtVCueZlMziZDyxxZIgIzfzd
XJ8jlex0RQSpuQT3Z5n++pkOt4ogq2xVjPcfs9puYFUAjoIDieg0ot5jINCzEF4=
=UEKW
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--
