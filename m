From: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Subject: Re: power management problems in ehci-omap
Date: Tue, 6 Feb 2018 17:55:38 +0100
Message-ID: <20180206175509.4d80e930@aktux>
References: <20180204000335.29812776@kemnade.info>
        <CAOf5uw=6RCJBPZd1fCi6+xb23THLRmXcfqsNtiZQeM=oKx0VvQ@mail.gmail.com>
        <20180204093831.44322452@kemnade.info>
        <CAOf5uwnoQtS+PnPO0t7Mf1qP9u_BgLPAX0h4EhiXfY7380QXng@mail.gmail.com>
        <20180206074201.479405e7@aktux>
        <20180206160452.GA21573@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wSfmdQ1pyCk7vDNismV_Q/1"; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180206160452.GA21573-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Michael Nazzareno Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--Sig_/wSfmdQ1pyCk7vDNismV_Q/1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Feb 2018 08:04:52 -0800
Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:

> * Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org> [180206 06:42]:
> > rechecked with a board with really nothing connected there
> > Same behaviour =20
>=20
> I've just verified that my test board power consumption goes
> back to normal after rmmod ehci-omap with v4.15.
>=20
yes, for me too, I initially used a test script which does an
echo rmmod ehci-omap

without a real
rmmod ehci-omap

It just seems to be consistent with my observations in a fully booted
system (where many things can play a role). Sorry for that confusion.

But suspend current is a problem. I have repeated the measurement with
another board, so it is not a board problem.=20

Regards,
Andreas

--Sig_/wSfmdQ1pyCk7vDNismV_Q/1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlp53goACgkQfb1qx03i
kyQ8Ew/+Pp8ml7MJ5jK/TPXS5yebcImtjcrnw0LMTu/sPmW6/MHmG2i74GOwLtr/
0OEqi49ZZzAoR1C5J7rjQRZgnCx48QQuISjdlH5mOTyPy/xwHiT46P5QUAK997pM
JXd3w9hhJ92SfIu9bp55nZEN1nWbCpHdbY2J20C07F8Yhm34fk5nR1KGR+1AvECD
jTumE69NITFQXMZhn+8KLNJfDtdebbZt7AnTnEWfCxJaclZ/fuu2UQ54ppnLo3Al
B3H7N0PaMrNjJ3pvdBoo1tesfFdL/0MFz0SzS5ueTnKyuY7pWNeiBGSulzii9p3k
05lKlnQ0rzs7SJbwCsD1TDn+UNBweT844ehR4TlVvdHztgqWf26K5koTMq61JGPw
/Ocl6vKTLtvsGZIAj9SM9AQHCaLQkP1bU8DtDewjP9GYeyUSguhlh8E/D/nzS17c
pqK5LwaqqY42DjFhEAcBExBYjdSeNJmz1ayQyFkrcI6YrwODoYSw2+GGXBriWs2T
5+agOKsLnBAXFYZnTf15VD//qZn6gB8Gl0101TZ69JgY8jwr6wGh1+OOC6jmjVsB
BGpPIdnjSR4C2yXc782aGTgXu8MNDKA4VVkrnAdrB7cXFqJVB2Mdq/XZHLzp3ot/
2uqoof1nS0yPJ7ZQd4D9TjwhVH2ywIQhDnHKrQdtJFERsmB2mjY=
=uU7O
-----END PGP SIGNATURE-----

--Sig_/wSfmdQ1pyCk7vDNismV_Q/1--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
