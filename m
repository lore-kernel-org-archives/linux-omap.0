From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 10/10] OMAPDSS: HDMI: Implement DSS driver interface
 for audio
Date: Wed, 25 Apr 2012 09:19:17 +0300
Message-ID: <1335334757.1923.19.camel@lappy>
References: <1332974305-4578-1-git-send-email-ricardo.neri@ti.com>
	 <1332974305-4578-11-git-send-email-ricardo.neri@ti.com>
	 <1335186116.1535.23.camel@lappy>  <4F97820E.2020006@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-qhhFCWqTodYrPA4wmyBC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:51154 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758057Ab2DYGT0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Apr 2012 02:19:26 -0400
Received: by lbgc1 with SMTP id c1so1033187lbg.3
        for <linux-omap@vger.kernel.org>; Tue, 24 Apr 2012 23:19:23 -0700 (PDT)
In-Reply-To: <4F97820E.2020006@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: mythripk@ti.com, s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org


--=-qhhFCWqTodYrPA4wmyBC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-04-24 at 23:48 -0500, Ricardo Neri wrote:
> On 04/23/2012 08:01 AM, Tomi Valkeinen wrote:
> > On Wed, 2012-03-28 at 16:38 -0600, Ricardo Neri wrote:
> >> Implement the DSS device driver audio support interface in the HDMI
> >> panel driver and generic driver. The implementation relies on the
> >> IP-specific functions that are defined at DSS probe time.
> >>
> >> A HW-safe spinlock is used to protect the audio functions. This is bec=
ause
> >
> > What is a "HW-safe spinlock"?
> Sorry, I meant a spinlock that disables the HW irqs when held:hardirq-saf=
e.
>=20
> >
> >> the audio functions may be called while holding a lock; in such case,
> >> the panel's driver mutex is not suitable. Functions should be used
> >> to set registers and should not wait for any other event.
> >
> > Are you sure this is the only option? What lock is being held?
> For instance, ALSA calls the start audio function while holding a=20
> hardirq-safe readlock. Hence, when reaching the HDMI panel start=20
> function, a lock is held and irqs are disabled. Using a mutex, that=20
> might sleep, is not correct; nor it is using an hardirq-unsafe spinlock.=
=20
> Otherwise, deadlocks and/or inverse lock ordering may arise. This=20
> situation was signaled by lockdep.
>=20
> IMHO, as the DSS device driver does not know who is going to use it (at=
=20
> least the audio part), it should not assume that no locks are held when=
=20
> its functions are called.
>=20
> > While a spinlock may be ok for now, quite often enabling/disabling thin=
gs do not
> > happen immediately,and it's much easier to do the wait synchronously.
> I don't understand this comment. To me, holding a lock until the=20
> enabling function returns is synchronous. Would you please clarify?

I meant that quite often when enabling things on hardware it takes time
until the HW is actually up and running. Perhaps a regulator needs to be
started, or such. And it's usually simpler to wait for the HW to be up
synchronously in the enable function, instead of some kind of
asynchronous mechanism. And if a function waits synchronously, a mutex
is better than spinlock.

And in that sense it's often better to define (define meaning, adding a
comment, or just mentally taking note about it) that the functions in
the API may sleep, so that the driver is free to do what is best for the
case, and it's also future-proof in a way that you can easily add
function calls that sleep to the functions in the future.

But you are also right in your previous comment, it's better to define
functions so that they never sleep, as that gives the callers the
freedom to call the funcs in atomic context.

Perhaps we can have audio_start() that never sleeps, it just enables a
few bits that start the audio. But how about audio_enable()? Is it
possible that on some OMAP version it would need to enable a regulator,
or set a gpio that's in an external i2c controlled mux chip, or such?

If so, we need to make sure it's not currently called in an atomic
context, because it would break if the function will sleep in the
future. And with "make sure" I just mean that we check the code and keep
it in mind. Or perhaps adding a comment in the header, that says
"audio_enable may sleep, other audio functions do not sleep" or such.

 Tomi


--=-qhhFCWqTodYrPA4wmyBC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPl5deAAoJEPo9qoy8lh71Yh8P/3bEwk33NZOVXuZg/VaR4oFh
kmEXr3DYo2bMDNUQKX6tLGZqYzG1q/1Vm5xJr4vietdj3ThaZSrw0BiCwoZ7SSFh
5SPqI6vFsbko05z02OuLrMlLgB3Yc6JqMEy4ewTgUBPQn+OLGIRKfdV84wmXL2pG
o/9aQ2wdBgYdLDrZAMjur5zwkJPg74Gnvyfm5o3RvZQBl3PfLNeEOJ3uOHP9U8IR
NGSxGe7m9warbCbHUM/qP/m+fcWSJ0We/qiKkmPe3DhuWJG5+GHQzB53K3Rr4cBX
vj0/z2Uy/vJDq0dxkF3NpH6mUq/yTCPkUUuavGjJwUWIm8Q251YYlxy2MOqgedlK
Q7s3j0Z/vDolvlNbTCPxbGmsnChfWh0c4raX30Nj0obhLLSE1+FFY//o6Sw+yuLB
0HD6tsD3hHnGgMW9G3Xn9Gh6DlPfWc7LgxAEezx7LRVdirspUCz5leQiYbyO61Iw
3fh2AxAVb+riHNaEF4o+WRQA83sFNfInn3Pw4VPBTlxCetH4roPqitz3uQMA4CI/
JHLg0j++/UtHxIaGePnmkRJwq7uwwwn8Gk9D4VDok+k2M5t5qtOLFy5MmtC7HP5M
a0wRCmOm/x8usvDwjyUWrWbuqCi9ya3ihfkvNZyIwIk2GYRK8LAVW6n8WtdeWeUq
IEKk62h7QTUx5xjtVktq
=Llx+
-----END PGP SIGNATURE-----

--=-qhhFCWqTodYrPA4wmyBC--

