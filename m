From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Mon, 20 Feb 2017 22:27:39 +0100
Message-ID: <C2E7AC24-75AB-442F-94A2-84904723EE41@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com> <B30D00D0-1967-4BD5-A304-E2ADC815A805@goldelico.com> <201702202042.15878@pali> <201702202208.50498@pali>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_DBEB6E25-957A-4660-ACFE-D165692FA78F"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201702202208.50498@pali>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin Tissoires <benjam>
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_DBEB6E25-957A-4660-ACFE-D165692FA78F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> Am 20.02.2017 um 22:08 schrieb Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>=20
> On Monday 20 February 2017 20:42:15 Pali Roh=C3=A1r wrote:
>> Hi Nikolaus!
>>=20
>> On Monday 20 February 2017 17:50:04 H. Nikolaus Schaller wrote:
>>> Hi Dmitry,
>>>=20
>>>> Input driver may set resolution for given axis in units per mm
>>>> (or units per radian for rotational axis ABS_RX, ABS_RY,
>>>> ABS_RZ), and if you check the binding, you can use
>>>> "touchscreen-x-mm" and "touchscreen-y-mm" to specify the size of
>>>> entire touch surface and set resolution from it so that
>>>> userspace can calculate the proper scaling factor.
>>>=20
>>> How is this information exposed by the kernel to user-space? By
>>> scanning the DT file or tree?
>>=20
>> Set input_abs_set_res() from kernel. And in userspace call EVIOCGABS
>> ioctl() on input device. Look at struct input_absinfo, you should
>> have all needed information here. This is generic input interface,
>> no DT is needed.
>=20
> Looking at kernel code... via EVIOCSABS ioctl() you can even set
> resolution from userspace for specified input device.
>=20
> So this could be potentially used for calibrating input device from
> userspace? (In case DT data will not fully match current HW)
>=20
>> I hope that XServer is already using it for evdev devices...
>>=20
>> For whole implementation look at evtest program. That should be good
>> starting point for your userspace implementation.
>>=20
>> While I'm watching this discussion... in my opinion kernel should
>> just invert input axes (when needed)

It is questionable why it should do that at all then.

User-Space can also easily do it. Either the driver should provide raw
data only or if it does pre-processing (scaling by +/-1), why exclude
pre-scaling by other factors?

>> and should not do any other
>> normalization or integer/floating-point
>> re-calibration/re-calculation. If it correctly exports minimum
>> value, maximum value and resolution then userspace can correctly
>> re-scale input events to units which userspace needs (e.g. mapping
>> into LCD screen pixels or whatever is needed).
>=20
> --
> Pali Roh=C3=A1r
> pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org


--Apple-Mail=_DBEB6E25-957A-4660-ACFE-D165692FA78F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYq19LAAoJEIl79TGLgAm644gQALBIU3doHmJLuu/w4V608d7D
Y1r6IwKjUc0QbFDu7UufKehYRgW/fN3LMbgl+w/gddudIts+Rntrf2AY/P8q4FS3
cYWJ34WBApV8ITuwxLhfAb0ErGBsxYCA4VMTUJmyj5tiGkXdPqO/Sa0+/4GhSaNe
8gelyT7WintA05hK0vuo5b9StfvJm6Zn/9I53DDFjQtnM113YIa/oJ8HFtybXsc/
tcGOPbihkF/El6pvu+M6z3Nnyf0IJZtu6DEzKuxUwVkYuEE54d8zWlxups4gpsVJ
LQ+gu8PlrGjNWYbBnl8nx7AZvEM+rVcr7Y+lrgZ2qQe/UAsM6M90DvMxlfqlvbIp
DcRJiFAAoAlr+NWShtVba7T6qohuBkdAasLRE/rYuiILALzDn5XDD5s4px3WqrMC
T2Ual/Xhd8Xp8bsEjCicBaJSvdl13YNXYTrk2oe8velvr1t4fHrvOiW0XapDZjBN
JwJDH8uS+IDqPfs8WfODTIUayHTAqrM3Tc4CdC8aQQMcMRIE9OOJJabHAKkITdc1
XSmx++KzhzZ8+TFScrrRX7lX8simDl8zOrddlnk7jmE8U4Xg9PL/0/eqEl2zkKy/
FFo9vZo1T45bnw7r01qu3eR+Zwz78JP5A/MwDkXkSHSBONmFDIo9HwlSPlS97+iV
JNK/P+YMOGulEA3gmaHB
=nfv3
-----END PGP SIGNATURE-----

--Apple-Mail=_DBEB6E25-957A-4660-ACFE-D165692FA78F--
