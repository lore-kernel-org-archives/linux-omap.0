From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: dwc3 gadget breaks on system suspend/resume
Date: Fri, 27 Jan 2017 17:03:30 +0200
Message-ID: <8760l07dfh.fsf@linux.intel.com>
References: <54bdc1b7-69ed-d580-fd17-3e7499ac1c27@ti.com> <87a8anjm5z.fsf@linux.intel.com> <a0cc2705-b1f5-7b6e-d73c-ff9b525eead2@ti.com> <e64bc4ee-1c71-d72c-cdc7-f5857f49a90e@ti.com> <87inp07fkx.fsf@linux.intel.com> <57fbf2b6-3811-3202-0e69-7cf82662d50f@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57fbf2b6-3811-3202-0e69-7cf82662d50f-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb@vger.kernel.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>>>>>> We have system suspend resume working on dra7-evm in v4.10-rc but
>>>>>> dwc3 gadget breaks after system suspend resume.
>>>>>>
>>>>>> Any hints how to fix it? Full backtrace below.
>>>>>
>>>>> from a quick look. END_TRANSFER is timing out, most likely. Tracepoin=
ts
>>>>> should give better hints.
>>>>>
>>>>> We might have a bug in dwc3_gadget_suspend(). No idea what's really
>>>>> going on.
>>>>>
>>>>>> Another message that looks worry-some is
>>>>>> "[   61.495313] omap-dwc3 48880000.omap_dwc3_1: runtime PM trying to=
 suspend device but active child"
>>>>>
>>>>> did you implement runtime PM on dwc3-omap.c? Look at dwc3-pci.c for r=
eference.
>>>>>
>>>>>> If I unload gadget, then suspend/resume system then load gadget ever=
ything works fine.
>>>>>
>>>>> right, dwc3 UDC will already have been toredown. Unfortunately I can't
>>>>> spend a lot of time on this, so you're gonna have to try to fix it and
>>>>> provide a patch :-s Quite busy looking at some f_fs weirdness.
>>>>
>>>> No problem. I'll debug this issue.
>>>
>>> Bisected to bad commit 4eb3d981e7344ded9e5a8725ed934dd8f8056daf "usb: d=
wc3: core: simplify suspend/resume operations".
>>=20
>> $ git show 4eb3d981e7344ded9e5a8725ed934dd8f8056daf
>> fatal: bad object 4eb3d981e7344ded9e5a8725ed934dd8f8056daf
>>=20
>> That commit to me is:
>>=20
>> commit 51f5d49ad6f011ee380b866ea617fd90584189a2
>> Author: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> Date:   Mon May 16 10:52:58 2016 +0300
>>=20
>>     usb: dwc3: core: simplify suspend/resume operations
>>=20=20=20=20=20
>>     now that we have re-factored dwc3_core_init() and
>>     dwc3_core_exit() we can use them for suspend/resume
>>     operations.
>>=20=20=20=20=20
>>     This will help us avoid some common mistakes when
>>     patching code when we have duplicated pieces of code
>>     doing the same thing.
>>=20=20=20=20=20
>>     Signed-off-by: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>=20
>> Can you please try actual mainline and not some tree where you
>> cherry-picked patches on top? ;-)
>>=20
> Sorry about the wrong commit ID.

np

> I reset my tree to 51f5d49ad6f011ee380b866ea617fd90584189a2 and can repro=
duce the issue.

okay

> The previous commit c499ff71ff2a281366c6ec7a904c547d806cbcd1 is fine.

okay. Then let's try to figure out what's going on. A diff of regdump
before and after suspend/resume might start to give some clue about
what's going on. DWC3 tracepoints should help too. Care to get those?
BTW, is this dwc3 as host or peripheral?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAliLYUIACgkQzL64meEa
mQa3lRAA22albfVcIMdfqXUg6Vjbsa0R1bhha+afSUQsx2YFeH7egA44+96Cs+lI
glRi1bRwfnGi3oWaKsYyDph3eP24M4lrCbb9pFE2QfvnKn3VO58n76HdEa1wMXm/
pYTWn+IPzqYKjQWKYju6DR+bjwl0nMLXLwUf1hw/ZetS/3f2KwWAKdxILtWsY/ma
5t2XRpSfS/y9G4F1djWDM4BrdhKjZ8cnDMcDvRIAWQLr5PXgKvoBLuoFMvkO8b0T
hEgQdHS8tzqDXfkekJIyx2h+ucCnCQyHEMmimXK0xOIhtNFlBHu44FcUxsKBf5eI
7yIzT67ZBPR3xkUQRSU8gca3A22V8cF0UBqbKfH3ChP8ZvSByyRV1om9k5oI6EO2
YgHZbJjsYq0R9qXbd1vU5QhEdp2jruMwwFDcUBwOt0tVSZdiYoBSRttvB4UBVzTL
Kl+DtZaMs1OcvY4F9K6RN4FLdLWl6nZuEknZBKuYpUnTU05ou+SrzHV2+owElraU
p+yLCamb68ZZhPwpmR4WDuRQCKjkrXOL5TJev5kC7v9GdLSdVoCu5WtiNT5DLjfF
ZGb/YmpDm/g6woIAqDD2Zj2ThwvULRdSeYYLe87E8WlM+fOik+RT7qcfh0dl2em+
0aXhTP9qCA3bCxDVzv+PYSXbUEDOgIVZ6Cn/XQHeKbHXi0ipzlE=
=YKUW
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
