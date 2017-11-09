From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: USB regression in next-20171108 with hub spamming
Date: Thu, 09 Nov 2017 12:44:47 +0200
Message-ID: <87wp2zrasg.fsf@linux.intel.com>
References: <20171108230511.GY28152@atomide.com> <20171109080007.GA17098@kroah.com> <871sl7sq9i.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <871sl7sq9i.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> writes:

> Hi,
>
> Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> writes:
>> On Wed, Nov 08, 2017 at 03:05:11PM -0800, Tony Lindgren wrote:
>>> Hi Felipe & Greg,
>>>=20
>>> Looks like in next-20171108 USB hub is spamming console about once a
>>> second after commit 7dfd74fd128 ("Merge remote-tracking branch
>>> 'usb/usb-next'").
>>>=20
>>> Any ideas? See the log below.
>>
>> Any chance you can run 'git bisect'?
>
> I wonder if it was caused by the usb_get_std_status() changes. We didn't
> catch this in our testing, though. I left the patches in intel's
> validation for a few days before sending out.
>
> Let me compile that very tag and try it with one of our machines.
>
> Tony, a bisection would be useful, indeed.

reproduced. Digging to figure out what's going on.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAloEMZ8ACgkQzL64meEa
mQZL9g/+IHPDx31pH/xTIc+YnCVmi1ie62CLsLDHGYCSUQeNylos+Zs4VdHGBJbr
PqQKUheXZV6dN2JkF0v0JH8WGW7M9uWIGebMFV4/a3LtdQkt8NH+l+yEYmzLIj4i
ggvw/qQS7HMWhpzgR4AVMUJxxtHe0XE8F7b1qpACVfYeD62GMnAfBqia5UnK0UqU
sw2EFQ/kgyJ7X0uGQRAhX85k2ZSVnvcdietfhWIJfYQAjPc2dNZzUMjDw09TOLIE
J+bPKF0t1BjqlaNDjAtnBJFR6zqrheO70mGYzk1wG+YfJPb2k8LF0Gw/rwC97+rJ
upBFTM+hovW8icpcHw4OJkEa6JPgNZSwRIcegSedXWvQt2HCpLhyD4t3/9u9if9u
j4AFSai51iOWvziPeyhZv4w2CU60dQCuOuJHXDg8mmdjJOBK4HI25qQLMmtL5PSd
Va6fwb3lE4f8f2wd19f+o9rMJifvqWS/P9OZs1njsLb9FvI15Cikpd2cIdFmqVdo
fDl9gpYYhnIkFn5MJjbgjD3/GSY9vY6x8StcnfxhJcn9A2YhcEbQUSXM5+zIps98
EXFEGueeOcNQPoULroOHet8ZaIbo+TjO1klotCU1ZOb06pmGmo3aFpHU0qa4LocL
Zli4LWBM76a/DX7rm7ZGepJFFlbkWFw8tR8BYa/B6gDKkv5BRxE=
=3Y8/
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
