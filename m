From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: musb: communication issue with more than 12 FTDI ports
Date: Wed, 14 Oct 2015 12:19:32 -0500
Message-ID: <874mhtbc63.fsf@saruman.tx.rr.com>
References: <CAGm1_ku3d4q3jQ6ZZYaLktd182O_WY5Hvu-Z877N31e5wN2_NA@mail.gmail.com> <CAGm1_kvwLu=4R1G8+bXEhmU4298B-+XGKQRaOjZOz15eU1StFw@mail.gmail.com> <87r3kyd3xw.fsf@saruman.tx.rr.com> <561E7639.40506@ti.com> <87h9ltbg0i.fsf@saruman.tx.rr.com> <561E7B6D.80605@ti.com> <87eggxbeou.fsf@saruman.tx.rr.com> <561E85D4.4040208@ti.com> <87bnc1bcu1.fsf@saruman.tx.rr.com> <561E8C4E.1020602@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <561E8C4E.1020602-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> writes:
> On 10/14/2015 12:05 PM, Felipe Balbi wrote:
>>
>> Hi,
>>
>> Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> writes:
>>> Felipe,
>>>
>>> On 10/14/2015 11:25 AM, Felipe Balbi wrote:
>>>>
>>>> Hi,
>>>>
>>>> Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> writes:
>>>>> On 10/14/2015 10:56 AM, Felipe Balbi wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> writes:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 10/13/2015 01:22 PM, Felipe Balbi wrote:
>>>>>>>> Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> writes:
>>>>>>>>> On Mon, Oct 12, 2015 at 11:34 AM, Yegor Yefremov
>>>>>>>>> <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
>>>>>>>>>> We have a problem, when using more than 12 FTDI ports. Kernels t=
ried:
>>>>>>>>>> 3.18.1, 4.2.3 and 4.3-rc5. SoC am335x 600MHz
>>>>>>>>>>
>>>>>>>>>> Below the USB topology:
>>>>>>>>>>
>>>>>>>>>> # lsusb -t
>>>>>>>>>> /:  Bus 02.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dmusb-hdrc/1=
p, 480M
>>>>>>>>>> /:  Bus 01.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dmusb-hdrc/1=
p, 480M
>>>>>>>>>>         |__ Port 1: Dev 2, If 0, Class=3D, Driver=3Dhub/4p, 480M
>>>>>>>>>>             |__ Port 1: Dev 9, If 0, Class=3D, Driver=3Dhub/4p, =
480M
>>>>>>>>>>                 |__ Port 1: Dev 10, If 0, Class=3D, Driver=3Dftd=
i_sio, 12M
>>>>>>>>>>                 |__ Port 2: Dev 11, If 0, Class=3D, Driver=3Dftd=
i_sio, 480M
>>>>>>>>>>                 |__ Port 2: Dev 11, If 1, Class=3D, Driver=3Dftd=
i_sio, 480M
>>>>>>>>>>                 |__ Port 2: Dev 11, If 2, Class=3D, Driver=3Dftd=
i_sio, 480M
>>>>>>>>>>                 |__ Port 2: Dev 11, If 3, Class=3D, Driver=3Dftd=
i_sio, 480M
>>>>>>>>>>                 |__ Port 3: Dev 12, If 0, Class=3D, Driver=3Dftd=
i_sio, 480M
>>>>>>>>>>                 |__ Port 3: Dev 12, If 1, Class=3D, Driver=3Dftd=
i_sio, 480M
>>>>>>>>>>                 |__ Port 3: Dev 12, If 2, Class=3D, Driver=3Dftd=
i_sio, 480M
>>>>>>>>>>                 |__ Port 3: Dev 12, If 3, Class=3D, Driver=3Dftd=
i_sio, 480M
>>>>>>>>>>             |__ Port 2: Dev 4, If 0, Class=3D, Driver=3Dftdi_sio=
, 480M
>>>>>>>>>>             |__ Port 2: Dev 4, If 1, Class=3D, Driver=3Dftdi_sio=
, 480M
>>>>>>>>>>             |__ Port 2: Dev 4, If 2, Class=3D, Driver=3Dftdi_sio=
, 480M
>>>>>>>>>>             |__ Port 2: Dev 4, If 3, Class=3D, Driver=3Dftdi_sio=
, 480M
>>>>>>>>>>             |__ Port 3: Dev 7, If 0, Class=3D, Driver=3Dftdi_sio=
, 480M
>>>>>>>>>>             |__ Port 3: Dev 7, If 1, Class=3D, Driver=3Dftdi_sio=
, 480M
>>>>>>>>>>             |__ Port 3: Dev 7, If 2, Class=3D, Driver=3Dftdi_sio=
, 480M
>>>>>>>>>>             |__ Port 3: Dev 7, If 3, Class=3D, Driver=3Dftdi_sio=
, 480M
>>>>>>>
>>>>>>> How many EPs does each FTDI device require? at least one INT EP, ri=
ght?
>>>>>>> If I read it right, the topology above has 2 hubs, and 16 high-speed
>>>>>>> FTDI and 1 full-speed FTDI. So it requires at least 18 high-speed I=
NT
>>>>>>> EPs. MUSB driver only has 11 high-speed EPs for mode-4 which is the=
 EP
>>>>>>> configuration used by default. I am wondering how those devices got
>>>>>>> enumerated properly.
>>>>>>
>>>>>> dynamic EP allocation, but that has its own limitations.
>>>>>>
>>>>> MUSB does not support dynamic EP allocation for INT/ISOCH.
>>>>
>>>> I remember isoc doesn't, not sure about int. Do you remember where that
>>>> part of the code is off the top of your head ?
>>>>
>>>
>>> The MUSB EP allocation is in musb_schedule() in musb_host.c.
>>>
>>> It does not have specific policy for INT/ISOCH, but the issue is that
>>> for periodic EP, it got allocated during device enumeration but freed
>>> only when the device is disconnected. So practically there is no dynamic
>>> EP allocation for INT/ISOCH.
>>
>> This is not exactly what I can see when trying things out:
>>
>> minicom.cap:56:[   90.909917] musb-hdrc musb-hdrc.1.auto: qh df62d240 ur=
b dc4ebec0 dev3 ep1in-intr, hw_ep 10, df700680/1
>> minicom.cap:66:[   91.175860] musb-hdrc musb-hdrc.1.auto: qh df62d240 ur=
b dc4ebec0 dev3 ep1in-intr, hw_ep 10, df700680/1
>> minicom.cap:100:[   91.697827] musb-hdrc musb-hdrc.1.auto: qh df62d240 u=
rb dc4ebec0 dev3 ep1in-intr, hw_ep 10, df700680/1
>> minicom.cap:106:[   91.818066] musb-hdrc musb-hdrc.1.auto: qh dc4eb340 u=
rb df5b7e40 dev4 ep1in-intr, hw_ep 11, df5c3400/1
>> minicom.cap:149:[   92.475792] musb-hdrc musb-hdrc.1.auto: qh df62d240 u=
rb dc4ebec0 dev3 ep1in-intr, hw_ep 10, df700680/1
>> minicom.cap:162:[   92.736808] musb-hdrc musb-hdrc.1.auto: qh dc07d5c0 u=
rb dc4ebec0 dev3 ep1in-intr, hw_ep 10, df700680/1
>> minicom.cap:207:[   93.703046] musb-hdrc musb-hdrc.1.auto: qh df551cc0 u=
rb df65ee40 dev7 ep1in-intr, hw_ep 12, df6a2bc0/1
>> minicom.cap:215:[   93.977574] musb-hdrc musb-hdrc.1.auto: qh df551cc0 u=
rb df65ee40 dev7 ep1in-intr, hw_ep 12, df6a2bc0/1
>> minicom.cap:240:[   94.388472] musb-hdrc musb-hdrc.1.auto: qh dc4eb340 u=
rb df5b7e40 dev4 ep1in-intr, hw_ep 11, df5c3400/1
>> minicom.cap:289:[   95.422325] musb-hdrc musb-hdrc.1.auto: qh dc4eb340 u=
rb df5b7e40 dev4 ep1in-intr, hw_ep 11, df5c3400/1
>> minicom.cap:305:[   95.688207] musb-hdrc musb-hdrc.1.auto: qh dc4eb340 u=
rb df5b7e40 dev4 ep1in-intr, hw_ep 11, df5c3400/1
>> minicom.cap:335:[   96.291453] musb-hdrc musb-hdrc.1.auto: qh df551cc0 u=
rb df65ee40 dev7 ep1in-intr, hw_ep 12, df6a2bc0/1
>> minicom.cap:410:[   97.696976] musb-hdrc musb-hdrc.1.auto: qh df6b70c0 u=
rb dc011f40 dev11 ep1in-intr, hw_ep 2, dd842080/8
>> minicom.cap:56:[   90.909917] musb-hdrc musb-hdrc.1.auto: qh df62d240 ur=
b dc4ebec0 dev3 ep1in-intr, hw_ep 10, df700680/1
>> minicom.cap:66:[   91.175860] musb-hdrc musb-hdrc.1.auto: qh df62d240 ur=
b dc4ebec0 dev3 ep1in-intr, hw_ep 10, df700680/1
>> minicom.cap:100:[   91.697827] musb-hdrc musb-hdrc.1.auto: qh df62d240 u=
rb dc4ebec0 dev3 ep1in-intr, hw_ep 10, df700680/1
>> minicom.cap:106:[   91.818066] musb-hdrc musb-hdrc.1.auto: qh dc4eb340 u=
rb df5b7e40 dev4 ep1in-intr, hw_ep 11, df5c3400/1
>> minicom.cap:149:[   92.475792] musb-hdrc musb-hdrc.1.auto: qh df62d240 u=
rb dc4ebec0 dev3 ep1in-intr, hw_ep 10, df700680/1
>> minicom.cap:162:[   92.736808] musb-hdrc musb-hdrc.1.auto: qh dc07d5c0 u=
rb dc4ebec0 dev3 ep1in-intr, hw_ep 10, df700680/1
>> minicom.cap:207:[   93.703046] musb-hdrc musb-hdrc.1.auto: qh df551cc0 u=
rb df65ee40 dev7 ep1in-intr, hw_ep 12, df6a2bc0/1
>> minicom.cap:215:[   93.977574] musb-hdrc musb-hdrc.1.auto: qh df551cc0 u=
rb df65ee40 dev7 ep1in-intr, hw_ep 12, df6a2bc0/1
>> minicom.cap:240:[   94.388472] musb-hdrc musb-hdrc.1.auto: qh dc4eb340 u=
rb df5b7e40 dev4 ep1in-intr, hw_ep 11, df5c3400/1
>> minicom.cap:289:[   95.422325] musb-hdrc musb-hdrc.1.auto: qh dc4eb340 u=
rb df5b7e40 dev4 ep1in-intr, hw_ep 11, df5c3400/1
>> minicom.cap:305:[   95.688207] musb-hdrc musb-hdrc.1.auto: qh dc4eb340 u=
rb df5b7e40 dev4 ep1in-intr, hw_ep 11, df5c3400/1
>> minicom.cap:335:[   96.291453] musb-hdrc musb-hdrc.1.auto: qh df551cc0 u=
rb df65ee40 dev7 ep1in-intr, hw_ep 12, df6a2bc0/1
>> minicom.cap:410:[   97.696976] musb-hdrc musb-hdrc.1.auto: qh df6b70c0 u=
rb dc011f40 dev11 ep1in-intr, hw_ep 2, dd842080/8
>>
>> Note how the same ep1in-intr was used with different devices and
>> different hw_eps. OTOH, within the same device, hw_ep was
>
> Maybe I am wrong, but ep1in-intr is the EP reference to the device EP,=20
> while hw_ep is the reference to MUSB host EP.

We can't really know which EP the device side is using, right ? :-) The
device sides gives us an address in the EP descriptor, but that's just a
USB view, we don't know which hw endpoint the device is using; we only
know its USB address.

>> constant. Hmmm...
>
> My understanding here is that a dedicated MUSB EP is allocated=20
> permanently for each device.

Could be, it has been quite a long time since I messed around that part
of MUSB.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWHo6kAAoJEIaOsuA1yqRECkAP/i96dlAWG3XFffhnwVHUTdeJ
tceUjfWC4ipzadB4JEndk7cPCkzEVkdwnt505rcvmIi26Om/AoQaqLveKzmUv5bu
I0dwoxd7Y7urgsvZQ2gvHmBYKptyZYA0c+ovQR7O2w8ncgrTN7YMKAZaP6p9GDgM
0SebRlqrR00f4ryVDdQ6XSt2fbrcE1/ZqryaSWBfesBpWl+39iOlfdCXBSG3nDnO
J8Q6CZG6dQG4vaqa9TGvA2RNwEbXN2e9oHmc/hrZveWTVJBmikr0AzeePbVKIWNn
CySmic3DghCupZLlzsZpAB9cqWTCd7fvDZ31GRj8oi/agkWDuc+sgbLZ2T1kFuCk
AytLISC53e/0gWlPWcFjoddeYjplexCsiuU29YpnjX3eftYWAIpgoy6eGwBkqHFG
77AWTM+0S791NBfG5uSzv21uI1BCmptAgVXjxObPD4W6f7uvnC5Gn2gEIb788Aex
5R2Vcewz6/+/0Vuu0ieyWU4JFRk6cp8hsXEZY+UF1NcBEtDtbrdC1e9pBQbjpaTa
vxUNtGCUSxetha7PK8Y8TCOo/I0nwNFR5AKcgO4A80Rn7CH5KzLoi4Jj4RoI8fJr
LNq48aS6kRJE1kRZPxOJAQeXnMGR04NtA/JmOlTUlzX/Ud1jy3MyoIdVisXHVYlw
CD4JkgRQ0kIY/2cMR1NH
=FM+e
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
