From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: musb: communication issue with more than 12 FTDI ports
Date: Tue, 13 Oct 2015 13:22:03 -0500
Message-ID: <87r3kyd3xw.fsf@saruman.tx.rr.com>
References: <CAGm1_ku3d4q3jQ6ZZYaLktd182O_WY5Hvu-Z877N31e5wN2_NA@mail.gmail.com> <CAGm1_kvwLu=4R1G8+bXEhmU4298B-+XGKQRaOjZOz15eU1StFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGm1_kvwLu=4R1G8+bXEhmU4298B-+XGKQRaOjZOz15eU1StFw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, b-liu-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> writes:
> On Mon, Oct 12, 2015 at 11:34 AM, Yegor Yefremov
> <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
>> We have a problem, when using more than 12 FTDI ports. Kernels tried:
>> 3.18.1, 4.2.3 and 4.3-rc5. SoC am335x 600MHz
>>
>> Below the USB topology:
>>
>> # lsusb -t
>> /:  Bus 02.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dmusb-hdrc/1p, 480M
>> /:  Bus 01.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dmusb-hdrc/1p, 480M
>>     |__ Port 1: Dev 2, If 0, Class=3D, Driver=3Dhub/4p, 480M
>>         |__ Port 1: Dev 9, If 0, Class=3D, Driver=3Dhub/4p, 480M
>>             |__ Port 1: Dev 10, If 0, Class=3D, Driver=3Dftdi_sio, 12M
>>             |__ Port 2: Dev 11, If 0, Class=3D, Driver=3Dftdi_sio, 480M
>>             |__ Port 2: Dev 11, If 1, Class=3D, Driver=3Dftdi_sio, 480M
>>             |__ Port 2: Dev 11, If 2, Class=3D, Driver=3Dftdi_sio, 480M
>>             |__ Port 2: Dev 11, If 3, Class=3D, Driver=3Dftdi_sio, 480M
>>             |__ Port 3: Dev 12, If 0, Class=3D, Driver=3Dftdi_sio, 480M
>>             |__ Port 3: Dev 12, If 1, Class=3D, Driver=3Dftdi_sio, 480M
>>             |__ Port 3: Dev 12, If 2, Class=3D, Driver=3Dftdi_sio, 480M
>>             |__ Port 3: Dev 12, If 3, Class=3D, Driver=3Dftdi_sio, 480M
>>         |__ Port 2: Dev 4, If 0, Class=3D, Driver=3Dftdi_sio, 480M
>>         |__ Port 2: Dev 4, If 1, Class=3D, Driver=3Dftdi_sio, 480M
>>         |__ Port 2: Dev 4, If 2, Class=3D, Driver=3Dftdi_sio, 480M
>>         |__ Port 2: Dev 4, If 3, Class=3D, Driver=3Dftdi_sio, 480M
>>         |__ Port 3: Dev 7, If 0, Class=3D, Driver=3Dftdi_sio, 480M
>>         |__ Port 3: Dev 7, If 1, Class=3D, Driver=3Dftdi_sio, 480M
>>         |__ Port 3: Dev 7, If 2, Class=3D, Driver=3Dftdi_sio, 480M
>>         |__ Port 3: Dev 7, If 3, Class=3D, Driver=3Dftdi_sio, 480M
>>
>> When using 12 ports and performing serial test (a pair of ports is
>> connected via null-modem cable and a rather short string ca. 90
>> characters will be sent alternating at 1200 and 115200b/s, testing
>> scripts are written in Python and running as own processes per a pair
>> of ports) there are no timeouts, i.e. all sent characters will be
>> received. As soon as I open ports 13 and 14 I start to get arbitrary
>> timeouts  (from test software point of view) on all ports.
>>
>> In order to check, if ftdi_sio has primary to do with this issue, I've
>> performed the same test on a PC and PandaBoard Rev. A2 (EHCI port) and
>> there were no issues with 16 ports. So it seems to have something to
>> do with am335x + musb + number of end points.
>>
>> Any idea? Let me know, if you need our test script.
>
> From time to time I get following warnings (4.3.0-rc5):
>
> musb_host_rx 1915: RX1 dma busy, csr 2020
> musb_host_rx 1915: RX4 dma busy, csr 2020
> musb_host_rx 1915: RX7 dma busy, csr 2220
> musb_host_rx 1915: RX1 dma busy, csr 2020
>
> Though they are not timely related to serial test timeouts.

yeah, I don't think MUSB can easily handle that. IIRC, endpoint
scheduling in MUSB is rather bad. While we have enough endpoints to
handle this case, you might be running into some IP (or driver) issues.

Bin, have you ever tested this many serial devices on AM335x ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWHUvNAAoJEIaOsuA1yqRE3UoP/Rh/XLj5AkaZ1t9zBj3lvuyP
9Bdz3alHchotrA61b4+CswCALRX/E0z0N9O1zW2YzBUqnp9KsjbvHWQqivUVKYyH
zWkN6jp59C5n3KCnQZK3nNIjqTQcS5p9rOlQL1x54Ut+KUjc8n+HMFaFkt2XLsbV
9rIEJa8etns6eXTMag+RwxIJBneQy01Y/fPJbO7IbkeP/QHfZgH+rVFptLoIvsI+
7GZBRndh53SH+WmXj0RxhAETmad6GGbtVyYZl7v2xth3zaMdo5X+v91wqZj6qhOx
+/pLsjY7z01Ouiqa0n4CGaYB+O4YT3YgLPuigPRcuNHQzAJt9fEdQcvzzy0LBzy+
yWf/H5hljmTuJoOI/MhLqC8zAsMcsdbilD0JH0iUEPa39yu2RTlmoOhJQXf1kWAt
nnG+cvSNt8TpGpysWsJ7VzyIiazY1gKWbKw7XhpNNsfZ82eOZNqvHwSGD1a8KzeV
s5e78hWgKkmC/Rl2o2GFblDUNumWnU9wNUWoGEtH5/1ptQJ48RtPeUTR3yeke5E6
vbci/qhmPsvFdQnxU+yb6lumG6EwHPwKmm++xbjZMC6vy654tzO5k6ibe6zWxVTs
qSr7LYUmTFhCpqy9z3hkVu+CcaGB8xAZZ/cMKmDAMAGOCQvwTIy12lemCT8Iusc6
C2+Ri3bODeairsH5VJjk
=uKRQ
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
