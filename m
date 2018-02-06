From: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Subject: Re: [PATCH] usb: musb: fix enumeration after resume
Date: Tue, 6 Feb 2018 20:09:57 +0100
Message-ID: <20180206200957.196ab0b3@aktux>
References: <20180127083403.928-1-andreas@kemnade.info>
        <20180206184725.GD21573@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zKUm6DYXUggfst3azIH=XCO"; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180206184725.GD21573-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: b-liu-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--Sig_/zKUm6DYXUggfst3azIH=XCO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 6 Feb 2018 10:47:25 -0800
Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:

> * Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org> [180127 08:34]:
> > On dm3730 there are enumeration problems after resume.
> > Investigation led to the cause that the MUSB_POWER_SOFTCONN
> > bit is not set. If it was set before suspend (because it
> > was enabled via musb_pullup()), it is set in
> > musb_restore_context() so the pullup is enabled. But then
> > musb_start() is called which overwrites MUSB_POWER and
> > therefore disables MUSB_POWER_SOFTCONN, so no pullup is
> > enabled and the device is not enumerated. =20
>=20
> I just gave this patch a quick try and things seem to behave
> for me from PM point of view:
>=20
> Tested-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>=20
> Unrelated to this patch, I also noticed that we now somehow
> higher idle power consumption initially when musb modules are
> loaded. It used to idle after that but now to get things to
> idle I had to plug and unplug a USB device once to the musb
> port.
>=20
Hmm, I have seen this effect with some earlier kernels but not with
4.15. My observation is that current consumption went down again after
a modprobe g_ether and ifconfig usb0 up

I was loading modules piece by piece and waited 10s after each and then
measured.

Regards,
Andreas

--Sig_/zKUm6DYXUggfst3azIH=XCO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlp5/YUACgkQfb1qx03i
kyT2yw//REuINAuyOjtTqW4hlDdn8BYWoxeb9wj4yqlJeETdKerO2nwPHunD+B+l
mLx4IOUMaUUg4RJOEmD/hLVDTftz/cqk+xuZb3daLCldI8Oiacz3bMcwVXN81L0H
sjgQO4zcoAMG/YDZTIIr4rcjdIc86hSCu6/5gM+yhY9QrwOaVZOIQzpGXVhZ0mIZ
FBbACI8dcLpyZExPKhjVJutTRtb1THSi0pTDOWALKoRyJEd+nHguZyFsKhbHMeVg
ejXWgkjxy+CUzp8EwgH0uYfbVA7ij30SCZB+Bq8QhKgdRc2lQXchJwCwXXgguojg
Wom+hYp4r9t1jLjW+Jm+1/KjwjhfC4BrQ7VwPVs8f+SjqvVBLS1YJsMv+deVK68l
prHQbVkUyDMUGp7t7Fsg5NivvYJAWH+PVwM+R5oaXTVPpYLFsjkxBhY54dY0JeDP
N7r+k/7KomYTPi7iGH6pzDg0RIQsH5vSopt3v9DkT+T0xK6qe+4UHfUF/XUByY9P
FYAvykpd0FqO0SAbKWJ1+k65/FhvRN8hwtGwjI9ZIfCBGjDubkVuBaTrOoyNIMIC
Kib06XNZiAEOeE3yeaIhbLLraBCxmKWSkDFqYakX8paeVa7g2p8YHx0zDbwWOuW0
pvolCmuQZOhrK8ToAmy4K/6opynsMe/jlqrCUGnAguaI3IYXXio=
=T3RF
-----END PGP SIGNATURE-----

--Sig_/zKUm6DYXUggfst3azIH=XCO--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
