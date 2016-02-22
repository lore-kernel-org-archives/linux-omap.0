From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] usb: dwc3: drop FIFO resizing logic
Date: Mon, 22 Feb 2016 12:52:38 +0200
Message-ID: <87io1hnhjd.fsf@ti.com>
References: <1454588282-14383-1-git-send-email-balbi@kernel.org> <56B4C8B0.9070909@ti.com> <87h9hgswjw.fsf@ti.com> <56BB0E2D.1030600@ti.com> <56CAC1F1.7010408@ti.com> <87vb5hnnsy.fsf@ti.com> <56CAE849.5050303@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56CAE849.5050303-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nm-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> writes:
>> Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> writes:
>>>>>> On Thursday 04 February 2016 05:48 PM, Felipe Balbi wrote:
>>>>>>> That FIFO resizing logic was added to support OMAP5
>>>>>>> ES1.0 which had a bogus default FIFO size. I can't
>>>>>>> remember the exact size of default FIFO, but it was
>>>>>>> less than one bulk superspeed packet (<1024) which
>>>>>>> would prevent USB3 from ever working on OMAP5 ES1.0.
>>>>>>>
>>>>>>> However, OMAP5 ES1.0 support has been dropped by
>>>>>>> commit aa2f4b16f830 ("ARM: OMAP5: id: Remove ES1.0
>>>>>>> support") which renders FIFO resizing unnecessary.
>>>>>>>
>>>>>>> Signed-off-by: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>>>>>
>>>>>> tested this series on both dra7-evm and dra72-evm using mass storage=
 gadget and
>>>>>> msc.sh
>>>>>
>>>>> both HS and SS ?
>>>>
>>>> yes.. but the logs here were for only SS.
>>>>>
>>>>>> dra72-evm: http://pastebin.ubuntu.com/14887997/
>>>>>> dra7-evm: http://pastebin.ubuntu.com/14887975/
>>>>>>
>>>>>> Tested-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>>>>>>
>>>>>> Let me know if you want me to do any other testing on dra7.
>>>>>
>>>>> yeah, run testusb for a week or so, that usually catches odd bugs.
>>>>
>>>> Okay. I'll start the test before I go for vacation next week.
>>>
>>> Looks like the test couldn't complete and I see dumps [1] in my host
>>> PC. Here's the output of testusb [2].
>>>
>>> [1] -> http://pastebin.ubuntu.com/15169114/
>>> [2] -> http://pastebin.ubuntu.com/15169116/
>>=20
>> Does this also happen without this patch applied ?
>
> yeah. I could see that even without the patch.
>
> I think I should update my host PC kernel and check (maybe it got
> fixed with the latest xhci driver).

yeah, please do that and let me know ;-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWyuh2AAoJEIaOsuA1yqREP88P/1ZO7LEJbIp4bs9lDwVsLngM
w2cl/OLxIj5oxSizyorR+GFaqft9bNyv3ybVzsJNz/vCgvsmLaapGmUK7Fn/m4f1
EdZKLyMsAZOZO5MBWhUyZd2jJLPmhwf7/I+5VFV/LPUUa7D6QageCmDNZ5TxwSWR
gVJjRiU3J7qhvErJsB70I56N8cxWd++ftgcuOzKX09yHyAl0ryB68bKzrZaCTmkf
wnfM3TmoHGR/kAWLZbU1UzNugqo0IDLjPNQbmKsDTAsRbndGazjfshTO+K26pM+w
E1V79qCnGNyAUZEEa1UXGIEgyVHZdXxTevlWM6ckiL4FibyKjdc9DmRSw2YM6eQA
axBepZX+tgYNq/83PlxLE1OOAscsbgFKfmZhWP70Ur/TyHcVmKM6ALGjHxmKx9f8
xjlfmo4oyIo9e08Uqe9oWiF+TTvcH0a/pk03bYlmpFWMhLWixB+lLYVK5LIuGfPj
I0Y8H9BNBAzT1+0T7ipYDVVLHUHXQHIAcPMot4gGa+4ZCvjoD33EDAhNmcfzomLR
HXO2SYKGlpvBNtosL88yPMsMKybSqgS9JEC2Lq1qvlhgmFUdhzKgbVNrLrluR74U
tnJUCzh7J68AyGfQYMEbSWkoMOVTJxtmKhuBk4z+2x9fFf8ii5V53xFN1YyPiN2U
gXNcLcqIXtgy42VVxAPR
=Tcqy
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
