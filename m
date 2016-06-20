From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v10 06/14] usb: gadget.h: Add OTG to gadget interface
Date: Mon, 20 Jun 2016 11:13:37 +0300
Message-ID: <87d1ncxopa.fsf@linux.intel.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com> <1465564043-27163-7-git-send-email-rogerq@ti.com> <87k2hkxr4d.fsf@linux.intel.com> <57679B30.6030809@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57679B30.6030809-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
> [ Unknown signature status ]
> On 20/06/16 10:21, Felipe Balbi wrote:
>>=20
>> Hi,
>>=20
>> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>>> The OTG core will use struct otg_gadget_ops to
>>> start/stop the gadget controller.
>>>
>>> The main purpose of this interface is to avoid directly
>>> calling usb_gadget_start/stop() from the OTG core as they
>>> wouldn't be defined in the built-in symbol table if
>>> CONFIG_USB_GADGET is m.
>>>
>>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>>> ---
>>>  include/linux/usb/gadget.h | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
>>> index 2dd9e6b..f4fc0aa 100644
>>> --- a/include/linux/usb/gadget.h
>>> +++ b/include/linux/usb/gadget.h
>>> @@ -639,6 +639,22 @@ struct usb_gadget_driver {
>>>  };
>>>=20=20
>>>=20=20
>>> +/*--------------------------------------------------------------------=
-----*/
>>> +
>>> +/**
>>> + * struct otg_gadget_ops - Interface between OTG core and gadget
>>> + *
>>> + * Provided by the gadget core to allow the OTG core to start/stop the=
 gadget
>>> + *
>>> + * @start: function to start the gadget
>>> + * @stop: function to stop the gadget
>>> + * @connect_control: function to connect/disconnect from the bus
>>> + */
>>> +struct otg_gadget_ops {
>>> +	int (*start)(struct usb_gadget *gadget);
>>> +	int (*stop)(struct usb_gadget *gadget);
>>> +	int (*connect_control)(struct usb_gadget *gadget, bool connect);
>>> +};
>>=20
>> you shouldn't need these at all. They are already part of the gadget
>> framework as ->udc_start(), ->udc_stop() and ->pullup()
>>=20
>
> This is to avoid the undefined symbol errors during build when OTG has is
> built-in because USB (host) is built-in but GADGET is still a module.

change your Kconfig dependencies. OTG layer shouldn't be built-in unless
both Gadget and Host are built-in.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXZ6WxAAoJEIaOsuA1yqREPEwQAIbydRmtZUjksjNQQnYHUQUp
Nz11gd0+S8MqrybPD8Y7WPw4tXfZi9eWFuf/WaGm79+vDzf93VxmRVIJmfcZyide
OjgARsKPDJ3RA5bnG0OTnR6QiT3soIxjlMjUGCd0Mx3+/81pqPNArgnPjOSA3U81
7PoqyWwlRfkwyP40TLP9uXY77w6ZoRLZ+p/I7U9SSVj9vZkFAKmo+YNjxfVHhoV2
cF7YgWEgpGByl5jqyiM6mn+uDWdivUpP5ejBLFprM4SwN7/K02o24akLrF/4BCXp
komrfBYyzQpse9sV4n06fXzpQjHGlwz8PuNqSGcFxInHIV++D7Q/H2OUiyGLjA56
MQkOn/91qvHWqpaTETWVaj1fTO0KSQ2/ubiUMInRmq806YSHqQHW3hY9Bdw7yHcX
guhztz+wy0e6RrdP+mu0ADpqe04XB5JczIkcpdOrb4lawQyWLcjbQzL5QCVygFUf
8jvuMfzlBJ9GdgnvIjuFWv2ZYrkios3btzd5lR62uXjTI2hIX8MNIBzhsSWV3bm1
iEunZHIjGINbImdwvgLxi6aM+5emhNqI7f0jbDmHYvD0VaDcVbYBqZez6PCUO6A9
TO5kI46fYmDfTn8wz+Fy3Pix30q7tEl2mKATgvvPN8xvJMM7fB3UVMVCrS/OzLyv
wM/Z5UQVv9CmudjKouxL
=mJvn
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
