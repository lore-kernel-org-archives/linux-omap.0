From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: dwc3 gadget breaks on system suspend/resume
Date: Fri, 27 Jan 2017 16:17:02 +0200
Message-ID: <87inp07fkx.fsf@linux.intel.com>
References: <54bdc1b7-69ed-d580-fd17-3e7499ac1c27@ti.com> <87a8anjm5z.fsf@linux.intel.com> <a0cc2705-b1f5-7b6e-d73c-ff9b525eead2@ti.com> <e64bc4ee-1c71-d72c-cdc7-f5857f49a90e@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e64bc4ee-1c71-d72c-cdc7-f5857f49a90e-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb@vger.kernel.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:

> Felipe,
>
> On 19/01/17 14:16, Roger Quadros wrote:
>> On 19/01/17 13:59, Felipe Balbi wrote:
>>>
>>> Hi,
>>>
>>> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>>>> Hi Felipe,
>>>>
>>>> We have system suspend resume working on dra7-evm in v4.10-rc but
>>>> dwc3 gadget breaks after system suspend resume.
>>>>
>>>> Any hints how to fix it? Full backtrace below.
>>>
>>> from a quick look. END_TRANSFER is timing out, most likely. Tracepoints
>>> should give better hints.
>>>
>>> We might have a bug in dwc3_gadget_suspend(). No idea what's really
>>> going on.
>>>
>>>> Another message that looks worry-some is
>>>> "[   61.495313] omap-dwc3 48880000.omap_dwc3_1: runtime PM trying to s=
uspend device but active child"
>>>
>>> did you implement runtime PM on dwc3-omap.c? Look at dwc3-pci.c for ref=
erence.
>>>
>>>> If I unload gadget, then suspend/resume system then load gadget everyt=
hing works fine.
>>>
>>> right, dwc3 UDC will already have been toredown. Unfortunately I can't
>>> spend a lot of time on this, so you're gonna have to try to fix it and
>>> provide a patch :-s Quite busy looking at some f_fs weirdness.
>>=20
>> No problem. I'll debug this issue.
>
> Bisected to bad commit 4eb3d981e7344ded9e5a8725ed934dd8f8056daf "usb: dwc=
3: core: simplify suspend/resume operations".

$ git show 4eb3d981e7344ded9e5a8725ed934dd8f8056daf
fatal: bad object 4eb3d981e7344ded9e5a8725ed934dd8f8056daf

That commit to me is:

commit 51f5d49ad6f011ee380b866ea617fd90584189a2
Author: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date:   Mon May 16 10:52:58 2016 +0300

    usb: dwc3: core: simplify suspend/resume operations
=20=20=20=20
    now that we have re-factored dwc3_core_init() and
    dwc3_core_exit() we can use them for suspend/resume
    operations.
=20=20=20=20
    This will help us avoid some common mistakes when
    patching code when we have duplicated pieces of code
    doing the same thing.
=20=20=20=20
    Signed-off-by: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Can you please try actual mainline and not some tree where you
cherry-picked patches on top? ;-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAliLVl4ACgkQzL64meEa
mQZ+3A/+LHfXQ4ONOlN0r27b742TORV+L07vwM5RtrAx5pJBsmSfomaHdesGokmX
0ZMDKOt7zWK+jeS3em5vKgAZhNDXYhzDSHTPxp+0h2rYf+jegFZJFNVl7Sh49r73
awl9pQT90f4OzhXaD5LDGfQvn9x6UAQ9FzIelmXbSUcMkcVvZZ127/J5r1kLR1DQ
kryxSj6s/AVztfUwNwiS5wfYSTh8/ig5TNahW1NhMW7DH4vEHkUQP18uC+xVWBkD
5sPnh8YKLma9VTpOv0wE4VgAJY++nkbrqepAju1E8hnDKD2HbuEqY+6GXNs2CroG
6D1KcX3sY5VAp9At4vutsouoKjM8LSYQ50HamclVV4oUORwlU6h9Ac4+1a4LV3fR
4e+JBq1QIXhI26qseXOSUFmuuHlVaaM4Dlab1yrQCWUqu0JdDfnVkUMrISjFvOUP
/VH5ALUpyQiqZRHE9WHZ1y43NiWXyKrMhH1PUyz5TZWAq+dmtz4IqD4/I4fYEyZ/
hZOSGstucPqBHzJI0xAzT5KcdNwcXO1Qv6WMMhQ6w7LZ7RL40sh3tqBaF/LyLf3T
Bv4PRiQzMGti21QGIXfSECMg6Z2gM5vKxos1l7HXMeyzBSlAubFF1Y9061hT28t1
JHXMovUKAm/+vq247FeRZrJxXynvhZHZDSye9LukeZbmk0hnLRw=
=vv2u
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
