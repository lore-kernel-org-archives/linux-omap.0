From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: musb: communication issue with more than 12 FTDI ports
Date: Wed, 14 Oct 2015 12:05:10 -0500
Message-ID: <87bnc1bcu1.fsf@saruman.tx.rr.com>
References: <CAGm1_ku3d4q3jQ6ZZYaLktd182O_WY5Hvu-Z877N31e5wN2_NA@mail.gmail.com> <CAGm1_kvwLu=4R1G8+bXEhmU4298B-+XGKQRaOjZOz15eU1StFw@mail.gmail.com> <87r3kyd3xw.fsf@saruman.tx.rr.com> <561E7639.40506@ti.com> <87h9ltbg0i.fsf@saruman.tx.rr.com> <561E7B6D.80605@ti.com> <87eggxbeou.fsf@saruman.tx.rr.com> <561E85D4.4040208@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <561E85D4.4040208-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> writes:
> Felipe,
>
> On 10/14/2015 11:25 AM, Felipe Balbi wrote:
>>
>> Hi,
>>
>> Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> writes:
>>> On 10/14/2015 10:56 AM, Felipe Balbi wrote:
>>>>
>>>> Hi,
>>>>
>>>> Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> writes:
>>>>> Hi,
>>>>>
>>>>> On 10/13/2015 01:22 PM, Felipe Balbi wrote:
>>>>>> Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> writes:
>>>>>>> On Mon, Oct 12, 2015 at 11:34 AM, Yegor Yefremov
>>>>>>> <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
>>>>>>>> We have a problem, when using more than 12 FTDI ports. Kernels tri=
ed:
>>>>>>>> 3.18.1, 4.2.3 and 4.3-rc5. SoC am335x 600MHz
>>>>>>>>
>>>>>>>> Below the USB topology:
>>>>>>>>
>>>>>>>> # lsusb -t
>>>>>>>> /:  Bus 02.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dmusb-hdrc/1p,=
 480M
>>>>>>>> /:  Bus 01.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dmusb-hdrc/1p,=
 480M
>>>>>>>>        |__ Port 1: Dev 2, If 0, Class=3D, Driver=3Dhub/4p, 480M
>>>>>>>>            |__ Port 1: Dev 9, If 0, Class=3D, Driver=3Dhub/4p, 480M
>>>>>>>>                |__ Port 1: Dev 10, If 0, Class=3D, Driver=3Dftdi_s=
io, 12M
>>>>>>>>                |__ Port 2: Dev 11, If 0, Class=3D, Driver=3Dftdi_s=
io, 480M
>>>>>>>>                |__ Port 2: Dev 11, If 1, Class=3D, Driver=3Dftdi_s=
io, 480M
>>>>>>>>                |__ Port 2: Dev 11, If 2, Class=3D, Driver=3Dftdi_s=
io, 480M
>>>>>>>>                |__ Port 2: Dev 11, If 3, Class=3D, Driver=3Dftdi_s=
io, 480M
>>>>>>>>                |__ Port 3: Dev 12, If 0, Class=3D, Driver=3Dftdi_s=
io, 480M
>>>>>>>>                |__ Port 3: Dev 12, If 1, Class=3D, Driver=3Dftdi_s=
io, 480M
>>>>>>>>                |__ Port 3: Dev 12, If 2, Class=3D, Driver=3Dftdi_s=
io, 480M
>>>>>>>>                |__ Port 3: Dev 12, If 3, Class=3D, Driver=3Dftdi_s=
io, 480M
>>>>>>>>            |__ Port 2: Dev 4, If 0, Class=3D, Driver=3Dftdi_sio, 4=
80M
>>>>>>>>            |__ Port 2: Dev 4, If 1, Class=3D, Driver=3Dftdi_sio, 4=
80M
>>>>>>>>            |__ Port 2: Dev 4, If 2, Class=3D, Driver=3Dftdi_sio, 4=
80M
>>>>>>>>            |__ Port 2: Dev 4, If 3, Class=3D, Driver=3Dftdi_sio, 4=
80M
>>>>>>>>            |__ Port 3: Dev 7, If 0, Class=3D, Driver=3Dftdi_sio, 4=
80M
>>>>>>>>            |__ Port 3: Dev 7, If 1, Class=3D, Driver=3Dftdi_sio, 4=
80M
>>>>>>>>            |__ Port 3: Dev 7, If 2, Class=3D, Driver=3Dftdi_sio, 4=
80M
>>>>>>>>            |__ Port 3: Dev 7, If 3, Class=3D, Driver=3Dftdi_sio, 4=
80M
>>>>>
>>>>> How many EPs does each FTDI device require? at least one INT EP, righ=
t?
>>>>> If I read it right, the topology above has 2 hubs, and 16 high-speed
>>>>> FTDI and 1 full-speed FTDI. So it requires at least 18 high-speed INT
>>>>> EPs. MUSB driver only has 11 high-speed EPs for mode-4 which is the EP
>>>>> configuration used by default. I am wondering how those devices got
>>>>> enumerated properly.
>>>>
>>>> dynamic EP allocation, but that has its own limitations.
>>>>
>>> MUSB does not support dynamic EP allocation for INT/ISOCH.
>>
>> I remember isoc doesn't, not sure about int. Do you remember where that
>> part of the code is off the top of your head ?
>>
>
> The MUSB EP allocation is in musb_schedule() in musb_host.c.
>
> It does not have specific policy for INT/ISOCH, but the issue is that=20
> for periodic EP, it got allocated during device enumeration but freed=20
> only when the device is disconnected. So practically there is no dynamic=
=20
> EP allocation for INT/ISOCH.

This is not exactly what I can see when trying things out:

minicom.cap:56:[   90.909917] musb-hdrc musb-hdrc.1.auto: qh df62d240 urb d=
c4ebec0 dev3 ep1in-intr, hw_ep 10, df700680/1
minicom.cap:66:[   91.175860] musb-hdrc musb-hdrc.1.auto: qh df62d240 urb d=
c4ebec0 dev3 ep1in-intr, hw_ep 10, df700680/1
minicom.cap:100:[   91.697827] musb-hdrc musb-hdrc.1.auto: qh df62d240 urb =
dc4ebec0 dev3 ep1in-intr, hw_ep 10, df700680/1
minicom.cap:106:[   91.818066] musb-hdrc musb-hdrc.1.auto: qh dc4eb340 urb =
df5b7e40 dev4 ep1in-intr, hw_ep 11, df5c3400/1
minicom.cap:149:[   92.475792] musb-hdrc musb-hdrc.1.auto: qh df62d240 urb =
dc4ebec0 dev3 ep1in-intr, hw_ep 10, df700680/1
minicom.cap:162:[   92.736808] musb-hdrc musb-hdrc.1.auto: qh dc07d5c0 urb =
dc4ebec0 dev3 ep1in-intr, hw_ep 10, df700680/1
minicom.cap:207:[   93.703046] musb-hdrc musb-hdrc.1.auto: qh df551cc0 urb =
df65ee40 dev7 ep1in-intr, hw_ep 12, df6a2bc0/1
minicom.cap:215:[   93.977574] musb-hdrc musb-hdrc.1.auto: qh df551cc0 urb =
df65ee40 dev7 ep1in-intr, hw_ep 12, df6a2bc0/1
minicom.cap:240:[   94.388472] musb-hdrc musb-hdrc.1.auto: qh dc4eb340 urb =
df5b7e40 dev4 ep1in-intr, hw_ep 11, df5c3400/1
minicom.cap:289:[   95.422325] musb-hdrc musb-hdrc.1.auto: qh dc4eb340 urb =
df5b7e40 dev4 ep1in-intr, hw_ep 11, df5c3400/1
minicom.cap:305:[   95.688207] musb-hdrc musb-hdrc.1.auto: qh dc4eb340 urb =
df5b7e40 dev4 ep1in-intr, hw_ep 11, df5c3400/1
minicom.cap:335:[   96.291453] musb-hdrc musb-hdrc.1.auto: qh df551cc0 urb =
df65ee40 dev7 ep1in-intr, hw_ep 12, df6a2bc0/1
minicom.cap:410:[   97.696976] musb-hdrc musb-hdrc.1.auto: qh df6b70c0 urb =
dc011f40 dev11 ep1in-intr, hw_ep 2, dd842080/8
minicom.cap:56:[   90.909917] musb-hdrc musb-hdrc.1.auto: qh df62d240 urb d=
c4ebec0 dev3 ep1in-intr, hw_ep 10, df700680/1
minicom.cap:66:[   91.175860] musb-hdrc musb-hdrc.1.auto: qh df62d240 urb d=
c4ebec0 dev3 ep1in-intr, hw_ep 10, df700680/1
minicom.cap:100:[   91.697827] musb-hdrc musb-hdrc.1.auto: qh df62d240 urb =
dc4ebec0 dev3 ep1in-intr, hw_ep 10, df700680/1
minicom.cap:106:[   91.818066] musb-hdrc musb-hdrc.1.auto: qh dc4eb340 urb =
df5b7e40 dev4 ep1in-intr, hw_ep 11, df5c3400/1
minicom.cap:149:[   92.475792] musb-hdrc musb-hdrc.1.auto: qh df62d240 urb =
dc4ebec0 dev3 ep1in-intr, hw_ep 10, df700680/1
minicom.cap:162:[   92.736808] musb-hdrc musb-hdrc.1.auto: qh dc07d5c0 urb =
dc4ebec0 dev3 ep1in-intr, hw_ep 10, df700680/1
minicom.cap:207:[   93.703046] musb-hdrc musb-hdrc.1.auto: qh df551cc0 urb =
df65ee40 dev7 ep1in-intr, hw_ep 12, df6a2bc0/1
minicom.cap:215:[   93.977574] musb-hdrc musb-hdrc.1.auto: qh df551cc0 urb =
df65ee40 dev7 ep1in-intr, hw_ep 12, df6a2bc0/1
minicom.cap:240:[   94.388472] musb-hdrc musb-hdrc.1.auto: qh dc4eb340 urb =
df5b7e40 dev4 ep1in-intr, hw_ep 11, df5c3400/1
minicom.cap:289:[   95.422325] musb-hdrc musb-hdrc.1.auto: qh dc4eb340 urb =
df5b7e40 dev4 ep1in-intr, hw_ep 11, df5c3400/1
minicom.cap:305:[   95.688207] musb-hdrc musb-hdrc.1.auto: qh dc4eb340 urb =
df5b7e40 dev4 ep1in-intr, hw_ep 11, df5c3400/1
minicom.cap:335:[   96.291453] musb-hdrc musb-hdrc.1.auto: qh df551cc0 urb =
df65ee40 dev7 ep1in-intr, hw_ep 12, df6a2bc0/1
minicom.cap:410:[   97.696976] musb-hdrc musb-hdrc.1.auto: qh df6b70c0 urb =
dc011f40 dev11 ep1in-intr, hw_ep 2, dd842080/8

Note how the same ep1in-intr was used with different devices and
different hw_eps. OTOH, within the same device, hw_ep was
constant. Hmmm...


=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWHotHAAoJEIaOsuA1yqREEgoP/3rZgWyE9pRyaXtHw+dciHvB
SqI5B0hPWzSn63DJt6+nthlKdEFobu8TyfGZLr/m8m3immuhAi3u6JJ0PTvK3L2g
Eyyzv/f8ZrWbiFk68yu4TIj4/casLtAJgjkujjIdPURNr185eUXGFcCMcF1UH/rd
l2qqwlWvYFl87454VK+v0Y4WIRL95kmFaDC1LkbYcjLfJ/xue5ZrVz3OvHvZTGLa
xoX6O5XKjgFUgtfBFXsLZbgFuSur0UFefD5KBKvHkJirJO02b4iVJj0dptfA03ON
4uTg74t4PEmnLbpE4JssTDahLEkZIpUq96oVquMKEn/oRKh/jpPMb/HuPPKbN91C
tT2UbGsyWOJaBzlQHXfABfn3KEafnM4C4kRvQBC1NrB/M4G8IQVOMD4BQmJ/sEAc
sV+g1vgo0j8R/HLtaiRn35lB7z4gGnAXSMZEYT7kGbAoH0VSBfzr8R1cy4hHYuJX
g1CZR0P06UOBCgtQfBSiK58YxvZe8l/HbQXAKKckaeJb+Y6e3BnW5bXk607o7mbb
YRGJ3EMOD+hdAMBIoTHocz97lmB//veMP5TuFcyFvv2YYhhdJjvUHGCZQJ1UhvCp
fbr/0YUBKWnyOIFG7F1Q7mGspa+EJePT5u4zltSKfobPnsBTaBZrv20DjIhsmKwe
SZ8RwgwbLAWL7SOmwL2i
=IHGu
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
