From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC PATCH 3/3] i2c: inititalise the actual transferred to zero
Date: Mon, 16 Jul 2012 11:17:30 +0300
Message-ID: <20120716081729.GJ7955@arwen.pp.htv.fi>
References: <1340967927-27354-1-git-send-email-shubhrajyoti@ti.com>
 <1340967927-27354-4-git-send-email-shubhrajyoti@ti.com>
 <20120629144002.3b4a31ee@endymion.delvare>
 <20120629145718.697b6955@endymion.delvare>
 <4FEDA9A8.1050504@ti.com>
 <20120629151832.0cb26bea@endymion.delvare>
 <20120702115422.GC2730@arwen.pp.htv.fi>
 <20120702152058.35fb0bca@endymion.delvare>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P6YfpwaDcfcOCJkJ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:32963 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751375Ab2GPIU3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jul 2012 04:20:29 -0400
Received: by lban1 with SMTP id n1so6458660lba.38
        for <linux-omap@vger.kernel.org>; Mon, 16 Jul 2012 01:20:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120702152058.35fb0bca@endymion.delvare>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: balbi@ti.com, Shubhrajyoti <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de


--P6YfpwaDcfcOCJkJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 02, 2012 at 03:20:58PM +0200, Jean Delvare wrote:
> Hi Felipe,
>=20
> On Mon, 2 Jul 2012 14:54:23 +0300, Felipe Balbi wrote:
> > On Fri, Jun 29, 2012 at 03:18:32PM +0200, Jean Delvare wrote:
> > > Well you've seen the caveats I mentioned, this will be no easy ride. =
If
> > > you are willing to take the risk, spend the time documenting the
> > > change, and help people if there are issues, then I'm OK. At least as
> > > long as someone else doesn't come saying it's a very bad idea ;)
> >=20
> > This approach is a hard-requirement for devices which will pose any
> > interface/feedback with user. We have been working with a piezo driver
> > from TI (drv2665) and it will be used (in most cases at least) to give
> > the user a feedback based on e.g. touchscreen event.
> >=20
> > Imagine drv2665 responds with a NAK while we're in the middle of driving
> > a wave through it (keep in mind a wave could take seconds to finish,
> > depending on the usecase), if we don't have a way to tell users that we
> > have writen X bytes, how should we make sure to continue driving the
> > wave from the exact byte where we got a NAK ?
> >=20
> > If can't make sure that detail is true, then such usecases (as piezo
> > drivers) will never work.
> >=20
> > Another approach would be to not add any field to struct i2c_msg but
> > instead return either the amount of bytes transferred, or an error case.
> > This would mean a series that would:
> >=20
> > 1) fix all users of struct i2c_master_send() and the like to check for
> > 	errors as if (ret < 0) instead of if (ret);
>=20
> You confuse me here. i2c_master_send is a function, not a structure.

exactly. The proposal was to change the semantics of i2c_master_send()
and maybe users understand that it returns negative errno or the number
of bytes transfered. No need to change any structure. Just read again
where I said:

"Another approach would be to not add any field to struct i2c_msg but
instead return either the amount of bytes transferred, or an error
case."


> Have you checked the code as it currently exists? i2c_master_send()
> already returns a positive number on success, not 0. I'm not claiming
> this number is necessarily very useful with the current implementation,
> but it's not 0. The API looks sane at least, and with Shubhrajyoti's
> proposed change, we could finally implement it properly.
>=20
> And its backend i2c_transfer() also doesn't return 0 on success, but
> the number of transferred messages. The problem at the moment is that
> it's not clear what the bus driver should return in case of partial
> success : a negative error code, or the number of messages successfully
> processed. I suspect implementations are mixed. Plus, as you and
> Shubhrajyoti found out, the caller doesn't know where in the last
> message the problem occurred.

indeed.

> Are you really suggesting that we could change the meaning of the value
> returned by i2c_transfer from "number of messages processed" to "number
> of bytes processed"? This would be a real API change. I'm not claiming
> the current API is very useful, but callers expect it that way, and I
> mean in-tree kernel drivers, out-of-tree kernel drivers, and user-space
> alike. Changing it has a huge risk of breakage (with lots of people mad
> at you.)

So does adding an extra field to the i2c_msg structure, right ? We just
need to make sure to implement the one which will cause less problems.

> > 2) fix all i2c buses to return the amount of bytes written instead of
> > 	zero or error case
>=20
> adap->algo->master_xfer is not returning 0 on success today, so your
> proposal makes little sense to me.

s/zero/number of messages

> > 3) fix Documentation to state that we're now returning the amount of
> > 	bytes, instead of zero or errno.
> >=20
> > I'm not sure what will have minimum impact to userland, though. What do
> > you say Jean ? What would you prefer ?
>=20
> Shubhrajyoti's proposal (which is much in line with what David Brownell
> proposed 4 years ago) seems at least possible to implement, while so
> far your own proposal is fuzzy at best (an actual patch may make your
> intents clearer.)
>=20
> What I like about Shubhrajyoti's proposal is that it adds optional
> information for the caller. It isn't changing the values returned, so
> the risk of breaking current driver code is quite low. Actually I think
> the only issue is with i2c_msg structures not being initialized using
> the C99 style. Other than this, it should be pretty safe.

fair enough.

--=20
balbi

--P6YfpwaDcfcOCJkJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQA84ZAAoJEIaOsuA1yqRE33QQAJjJmJN62GLVdXLdbka/b36f
3Ai2jjEJd7pPmIFHlxudLnnyeMXLJYl+QMahW9cFbx5dnCt8EGpyc5PKjDkM6VTA
faiLG8SHid949ufOJs8ZOQYd3r4DAa7eGaNsU0tfOI4puZWJpoMncA9gymR9kHGC
3xYemw33T8ZPsMUdanYkTNKqREq4JtIv5aMvQ4BmSLfVZG5nPGPvOeccABwp8L4A
tTVOfwnAoT770vuhvg9mlgcjx3odz7LqVRUMeWYfOWOKEZjkZuM3bbaP4GNykoul
REEdTwrVAFsr8DNdYHroHkvz0Mp/YjJjSDjoGHgjoofmCaGWo96ybCK0uEtvyJ2i
tABrIncgjmYTqsiF1IlAy2EvAiPMRgFIYQY+1kSqvy9+YRlNhxDZX2u9VTcbE/ju
J5AblPLvgU3sX0DT5BAeJUJklB5Nc6270nvhQqpXEVvxeSwH4jaJxZVxdhecZIQh
w301I+oxu2G6o6T1aWPikE13yYFiebdGTEUNLpkUuK8yjwEXvBghn2zLGqe8VpxX
TtFzCNWtrBkPyjl9SMbfbvVUCrDwOB4roLqpSCwQ/LzOCwaXh1hog25/IM+yTeTA
Fly9rp1I2kCYaiwqavjZNyJdJoifNs8N7INTRQm90nse6wiZomhibWbq2oU2KqXg
k9qciRHb/UQouxNuI8Ev
=X5xR
-----END PGP SIGNATURE-----

--P6YfpwaDcfcOCJkJ--
