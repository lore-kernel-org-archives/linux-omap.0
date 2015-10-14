From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: musb: communication issue with more than 12 FTDI ports
Date: Wed, 14 Oct 2015 10:56:29 -0500
Message-ID: <87h9ltbg0i.fsf@saruman.tx.rr.com>
References: <CAGm1_ku3d4q3jQ6ZZYaLktd182O_WY5Hvu-Z877N31e5wN2_NA@mail.gmail.com> <CAGm1_kvwLu=4R1G8+bXEhmU4298B-+XGKQRaOjZOz15eU1StFw@mail.gmail.com> <87r3kyd3xw.fsf@saruman.tx.rr.com> <561E7639.40506@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <561E7639.40506-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> writes:
> Hi,
>
> On 10/13/2015 01:22 PM, Felipe Balbi wrote:
>> Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> writes:
>>> On Mon, Oct 12, 2015 at 11:34 AM, Yegor Yefremov
>>> <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
>>>> We have a problem, when using more than 12 FTDI ports. Kernels tried:
>>>> 3.18.1, 4.2.3 and 4.3-rc5. SoC am335x 600MHz
>>>>
>>>> Below the USB topology:
>>>>
>>>> # lsusb -t
>>>> /:  Bus 02.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dmusb-hdrc/1p, 480M
>>>> /:  Bus 01.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dmusb-hdrc/1p, 480M
>>>>      |__ Port 1: Dev 2, If 0, Class=3D, Driver=3Dhub/4p, 480M
>>>>          |__ Port 1: Dev 9, If 0, Class=3D, Driver=3Dhub/4p, 480M
>>>>              |__ Port 1: Dev 10, If 0, Class=3D, Driver=3Dftdi_sio, 12M
>>>>              |__ Port 2: Dev 11, If 0, Class=3D, Driver=3Dftdi_sio, 48=
0M
>>>>              |__ Port 2: Dev 11, If 1, Class=3D, Driver=3Dftdi_sio, 48=
0M
>>>>              |__ Port 2: Dev 11, If 2, Class=3D, Driver=3Dftdi_sio, 48=
0M
>>>>              |__ Port 2: Dev 11, If 3, Class=3D, Driver=3Dftdi_sio, 48=
0M
>>>>              |__ Port 3: Dev 12, If 0, Class=3D, Driver=3Dftdi_sio, 48=
0M
>>>>              |__ Port 3: Dev 12, If 1, Class=3D, Driver=3Dftdi_sio, 48=
0M
>>>>              |__ Port 3: Dev 12, If 2, Class=3D, Driver=3Dftdi_sio, 48=
0M
>>>>              |__ Port 3: Dev 12, If 3, Class=3D, Driver=3Dftdi_sio, 48=
0M
>>>>          |__ Port 2: Dev 4, If 0, Class=3D, Driver=3Dftdi_sio, 480M
>>>>          |__ Port 2: Dev 4, If 1, Class=3D, Driver=3Dftdi_sio, 480M
>>>>          |__ Port 2: Dev 4, If 2, Class=3D, Driver=3Dftdi_sio, 480M
>>>>          |__ Port 2: Dev 4, If 3, Class=3D, Driver=3Dftdi_sio, 480M
>>>>          |__ Port 3: Dev 7, If 0, Class=3D, Driver=3Dftdi_sio, 480M
>>>>          |__ Port 3: Dev 7, If 1, Class=3D, Driver=3Dftdi_sio, 480M
>>>>          |__ Port 3: Dev 7, If 2, Class=3D, Driver=3Dftdi_sio, 480M
>>>>          |__ Port 3: Dev 7, If 3, Class=3D, Driver=3Dftdi_sio, 480M
>
> How many EPs does each FTDI device require? at least one INT EP, right?=20
> If I read it right, the topology above has 2 hubs, and 16 high-speed=20
> FTDI and 1 full-speed FTDI. So it requires at least 18 high-speed INT=20
> EPs. MUSB driver only has 11 high-speed EPs for mode-4 which is the EP=20
> configuration used by default. I am wondering how those devices got=20
> enumerated properly.

dynamic EP allocation, but that has its own limitations.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWHnsuAAoJEIaOsuA1yqRE0R8P/1a9nNQmH2sivdoKvCEVC4Hc
9yO0n8X2lMkNPIMdwIK6T/n3FX3m8FYcbd5TLGSUJ+0k4aXCVeT/LMq0Rg1IfKuk
nY3k8MF0uEUdgCU6RcwVkgTtztF7YlYdtv62PRlG9v1WiKvt2Fg5hg1gbEhI9pbB
5y1tYsGPQNmGNasjesNAHJIer3JnptSrFjs/kuFnosYakx1xDijRk7dTqV0QImS5
QDAo16zGDBf0ZDx1wMmJTWL6dhu/ac5m+FOSV/c7OG9dbVOK+TgDLQszYn/1q5jD
TLlu4AS700QvJLWt60pSQJvHQHGpEpVNiNdVmOGLOYqacDRkQT7+qHkqvtv81wW1
yldkOLY4s40zmxN9Ucm7wgoYMYGL42MJCB3hO/krFX2sNdW1UgGCRD3jFQ/pQrX1
UdOUkgU4ozQo+95aexlJOH78UhURQsfmQmtAQlLMfoBVk6LblEDofzKZ/kxCt+8U
wjizFoUCVuXWV7K7SQR3Bl1iFYP4yFcigOAduODruN8BtXnpWQhu5sep5YS0nuB0
Rhqxn1sCD/pAP9GBNo6AMYRoMgU2+4U7FcVNxp6j/By6LK+vpZVvnn7r4I5oRjt4
YW11dpXGjmEQKEf2EYxnWgsU8IN/+8ASlsmO+KaMi+sFvye2wr27X9lst1c7zXgC
VWF6i8MAAxLVAd/c6r9F
=Aauy
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
