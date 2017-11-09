From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: USB regression in next-20171108 with hub spamming
Date: Thu, 09 Nov 2017 12:49:44 +0200
Message-ID: <87shdnrak7.fsf@linux.intel.com>
References: <20171108230511.GY28152@atomide.com> <20171109080007.GA17098@kroah.com> <871sl7sq9i.fsf@linux.intel.com> <87wp2zrasg.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87wp2zrasg.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> writes:

> Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> writes:
>
>> Hi,
>>
>> Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> writes:
>>> On Wed, Nov 08, 2017 at 03:05:11PM -0800, Tony Lindgren wrote:
>>>> Hi Felipe & Greg,
>>>>=20
>>>> Looks like in next-20171108 USB hub is spamming console about once a
>>>> second after commit 7dfd74fd128 ("Merge remote-tracking branch
>>>> 'usb/usb-next'").
>>>>=20
>>>> Any ideas? See the log below.
>>>
>>> Any chance you can run 'git bisect'?
>>
>> I wonder if it was caused by the usb_get_std_status() changes. We didn't
>> catch this in our testing, though. I left the patches in intel's
>> validation for a few days before sending out.
>>
>> Let me compile that very tag and try it with one of our machines.
>>
>> Tony, a bisection would be useful, indeed.
>
> reproduced. Digging to figure out what's going on.

Okay, found it. Testing a patch.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAloEMskACgkQzL64meEa
mQbZIg/+NZ30geekxwZUWdd6M21R8pBlEXLycHm34a2PLQKQ7MbukYgcenBOI3a9
rycgmyOpvIXgOBEt3yRaLR1uNqEg2uQ482MAJSI8/fqI3KJtov6uM1M1viOqq1QH
VOSXuFQVd/ooLboHKaRjEC24WUYzq4u/VtvQ1F6PsrKW+Emy2pAAKWxXaTcDFG46
oRUNa42roW9zMdL5w3p56/z9mw/2mM4DkGA5EWeSZ4FPJHcAEP6roIoMwPN7nT/F
BVIspEraGNdYT/MERjNGxpC2w51Yzex7gTMrQdp6ZbjgtMwFLbP9543gO68wYraC
SpJDNoZwOPd311Gs+d2YZAAGF6PUvd24mEmOR7/YecNqE1RWhcyELfsTYuACL/l2
EazatgtBVimRu92BsFGYD6hNLYYUyNhmDiptVzztLutkoG1yZj4Du0hmN1UoKLeT
tEM97jOP/2AvFWQnnBczWwxvssroZPLQulu8EzLeQxl6d0lHgT3YvUYADBclUFU9
drxf0UJlv5giEa1amK34UdKpMx/DS7l0irMErhvR3qyCiKjaJE4KV7D9fuo09wXi
FYC2Dn+ulUdk38+3bRL+hP0KhOs0X9J8QQsi7NHg78fI+y57v5DG4KzW2gHb5W8z
X8Y19G69C2A0bLjB4IuQZY8X6hU4T3HUMJb5vlE+MYBSNK+oziU=
=ooVK
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
