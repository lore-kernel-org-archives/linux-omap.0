From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: RT throttling and suspend/resume (was Re: [PATCH] i2c: omap:
 revert "i2c: omap: switch to threaded IRQ support")
Date: Wed, 17 Oct 2012 17:00:02 +0300
Message-ID: <20121017140002.GI11394@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1210150148080.16624@utopia.booyaka.com>
 <CAM=Q2csHTbR4rBe1HNr5-M3sG5wgdCv6dCnGLmNQEwo1gjCSGg@mail.gmail.com>
 <20121016133356.GG21801@arwen.pp.htv.fi>
 <87ipaanljt.fsf_-_@deeprootsystems.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2nTeH+t2PBomgucg"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87ipaanljt.fsf_-_-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--2nTeH+t2PBomgucg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 16, 2012 at 02:39:50PM -0700, Kevin Hilman wrote:
> + peterz, tglx
>=20
> Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> writes:
>=20
> [...]
>=20
> > The problem I see is that even though we properly return IRQ_WAKE_THREAD
> > and wake_up_process() manages to wakeup the IRQ thread (it returns 1),
> > the thread is never scheduled. To make things even worse, ouw irq thread
> > runs once, but doesn't run on a consecutive call. Here's some (rather
> > nasty) debug prints showing the problem:
>=20
> [...]
>=20
> >> [   88.721923] try_to_wake_up 1411
> >> [   88.725189] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0
> >> [   88.731292] [sched_delayed] sched: RT throttling activated
>=20
> This throttling message is the key one.
>=20
> With RT throttling activated, the IRQ thread will not be run (it
> eventually will be allowed much later on, but by then, the I2C xfers
> have timed out.)
>=20
> As a quick hack, the throttling can be disabled by seeting the
> sched_rt_runtime to RUNTIME_INF:
>=20
>         # sysctl -w kernel.sched_rt_runtime_us=3D-1
>=20
> and a quick test shows that things go back to working as expected.  But
> we still need to figure out why the throttling is hapenning...
>=20
> So I started digging into why the RT runtime was so high, and noticed
> that time spent in suspend was being counted as RT runtime!
>=20
> So spending time in suspend anywhere near sched_rt_runtime (0.95s) will
> cause the RT throttling to always be triggered, and thus prevent IRQ
> threads from running in the resume path.  Ouch.
>=20
> I think I'm already in over my head in the RT runtime stuff, but
> counting the time spent in suspend as RT runtime smells like a bug to
> me. no?
>=20
> Peter? Thomas?

it looks like removing console output completely (echo 0 >
/proc/sysrq-trigger) I don't see the issue anymore. Let me just run for
a few more iterations to make sure what I'm saying is correct.

--=20
balbi

--2nTeH+t2PBomgucg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQfrniAAoJEIaOsuA1yqREvL4P/3CZmZ2LZfyA6lOLqpPc7Qt8
uflsm3vE0fQ+UGycRggHwwa5Xtwx+z8VejcYYvkWuzNk2zPF1wENSZPSjAyleboN
IDbs3TNufK2/X7boZcHZNYuTcbW9qcVzSioGDjz9tBeACWEiCPTc1YaYi5tqlVXG
/JQt0mRo+daZg+8yVqv3cIjkYcyoWX2IWW/LIjnaLTwPspeW4rlfHfZYmgAYwdNU
CvhfdOjJATG2OrtNj+MOn1dGmykqgegOoHiJ0e8QS7ftGwbJLRknHTjmUUhQ/3HP
5Nx9f67N7skZP8YZC6knw1F2CxgXEDYMFgP+rbhu1Fz2aB7MmbaQKcWu99jg3eDP
e1gU7jFRRA3CCwiNJTlvppWbgfGud7Mn0ApoLKplEbrO+JQl182gG3ftRDCIwhvU
Gwv8L6rcwPQr0rWFUNZB2okre63ZKByeHaoQdvGaV+eaA/OjQbwyWr6TldVSRo4+
mQDCQDiDws+4y8rC7Mr92qGFIrz4TFeuyabIxSZH0G8IuFelfI821dV0ixsUJgWI
1M2bZqFya1vn/nr0KQT9fmfvfKKqNrPtW1ybbFqFRaC34o2umtKW/q9re6rh3Mhq
I8CfPThie876eH+KdLuEw8hFpx9FG5xZ1VGu61Jlc8vpNdXNFIfWiglbJLkva2uV
5TSogSE92xHFSYKKGr+U
=Oc9o
-----END PGP SIGNATURE-----

--2nTeH+t2PBomgucg--
