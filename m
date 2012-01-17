From: NeilBrown <neilb@suse.de>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Wed, 18 Jan 2012 08:24:10 +1100
Message-ID: <20120118082410.48262777@notabene.brown>
References: <WC20120109124643.880164@terrafix.co.uk>
	<20120110080849.5a242adf@notabene.brown>
	<alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com>
	<20120112095940.0a54413e@notabene.brown>
	<alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
	<20120113222045.37f9b4ec@notabene.brown>
	<alpine.DEB.2.00.1201130423280.3659@utopia.booyaka.com>
	<20120114100915.01c96727@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/IISNNI9QnZY/mBU8_3/tSvT"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53074 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755455Ab2AQVY0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jan 2012 16:24:26 -0500
In-Reply-To: <20120114100915.01c96727@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, t-kristo@ti.com, govindraj.raja@ti.com, linux-omap@vger.kernel.org

--Sig_/IISNNI9QnZY/mBU8_3/tSvT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 14 Jan 2012 10:09:15 +1100 NeilBrown <neilb@suse.de> wrote:

> On Fri, 13 Jan 2012 04:31:37 -0700 (MST) Paul Walmsley <paul@pwsan.com> w=
rote:
>=20
> > On Fri, 13 Jan 2012, NeilBrown wrote:
> >=20
> > > Also, the HDQ access to the battery 'fuel gauge' is working fine, so
> > > presumably that gets disturbed by one of the lower power states (3,4,=
5).
> > > I guess it is 4,5,6 when CORE goes to RET or OFF.  So we need some wa=
y for
> > > HDQ to say "I'm busy" just like UART can.  omap_hdq_can_sleep() ???
> > > There must be a cleaner way...
> >=20
> > The first thing to try is the HDQ runtime PM conversion series that was=
=20
> > sent separately.  Maybe let us know if that fixes the problem.
>=20
> Not completely - but I'm still exploring.
>=20
>

I've finished exploring (for now) and am seriously stumped.  Maybe you can
help...=20

I modified your patch so that hdq uses autosuspend - because it seemed like=
 a
good idea and ends up providing slightly more informative failure modes.

The normal behaviour of the bq27000 driver is to request lots of values in
quick succession.  So using autosuspend (with 100ms timeout) means that we
have only one pm_resume and one pm_suspend for each batch of requests which
at least reduces the noise.

I have added an omap_hdq_can_sleep() function which only succeeds if the hdq
device is run-time suspended, and call it in the same place that
omap_uart_can_sleep is called, to ensure the core never goes to a lower sta=
te
while he hdq is active.  I've double-checked that this really works.

HDQ all works find normally, but then normally CORE stays ON because the UA=
RT
keeps it on.

If I tell the UARTs they can sleep (by setting sleep_timeout) and then acce=
ss
the bq27000 via HDQ it doesn't work properly.

The normal sequence is that it resets the HDQ and sends a 'BREAK' signal
(possibly not really necessary) for which we get a TIMEOUT interrupt.
Then=20
 write address - get TX interrupt - wait a bit - get RX interrupt - read by=
te.

We normally get the TIMEOUT interrupt and often get the first TX and then RX
interrupts but then the device goes silent.  No more interrupts come in, and
the status register (which shows interrupt source) reads as zero.

Occasionally I have seen maybe half a dozen successful reads before it goes
silent, but usually it is zero or 1.

It is as though something is timing out and going to sleep.  A clock
auto-sleeping?  Seems unlikely.

If I set all the UART sleep_timeout values to 0 to keep CORE always ON, the
problem doesn't fix itself.  Whatever got turned off stays off.

Once it starts failing, it never works again until a reboot.

Could we be caching something in memory which we think is on, but due to CO=
RE
going into RET (or maybe OFF), the thing is now off and we never bother to
reset it because the cached value is 'on' ??  I'm wondering about
_sysc_cache, but I haven't looked very deeply into it.

Any other ideas?

Oh - another thing.
Sometimes during early boot I get:

[    0.158447] omap_hwmod: usbtll_fck: missing clockdomain for usbtll_fck.
[    0.176879] omap_hwmod: hdq: softreset failed (waited 10000 usec)

At the same time the UART seem to hiccup and my USB-Serial port loses track
and doesn't see any more characters until I close and re-open.

Could that be related?  Any idea what it means?


Thanks,
NeilBrown

--Sig_/IISNNI9QnZY/mBU8_3/tSvT
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTxXm+jnsnt1WYoG5AQJLMg//XQE4F7QRzvK4iw/CFQ0DP7wCVY+q69g+
i8D7nlqPWCHgLcPlzbSEzx7+PqL0lG1X4YVRYwiMtWrCV40kuCfBNS09U5yiDG4N
9Wahjg5qnxMu7iEXFXmyVeCNz9wRI9zEfEfwcODjYoUGjo+xXcBq7Iq3L40DEp9M
n/8BQAXsBjCxgDoxuaQwCee6KoygaUy1xfw4omWP5BxyGhTMYKHh3fe/x7ucu0hn
89bAQVGDHXJ8UWj3kab8K+WnO9jUYnwQxv8cob2psgJ9KOd+yKOwBbsXZf0J3FIY
05Tqe8xSOhavJT2eYQDuSl8BYXGTyfADaqZw6i6ZbMMVnHgJO5lyVsCsPwmUUuZU
Y9GG7Aahvac43cqxcYmLz//B1MjpOmf7hvQl+UeyZ3YbnWJ7X53zGh3UkjAnske0
e+lpEP87kKNxWttl/q0kf52SJ7p11WITwT3FQTFFZimzWFayr4MwE/Cykvflm+Ra
FnPpjeNZvqkHz+tHhLrC9LBgaH3vKUhVocnqSkdqQWbO8WVpwlCtA5WE93Kh/VnT
v5E8nn67D/n8ARv5A6Bsvj4781RTtmvqc2ornWK2+be36CxysiCU508O/lZ+Kp4g
9Z45qKl7JjGsZjDk2tpIvhqey8s9uVTBFNgmqATlkiTkHTdV6GVI51e3+ayVPd7h
fV5M+oLqPhM=
=4wWU
-----END PGP SIGNATURE-----

--Sig_/IISNNI9QnZY/mBU8_3/tSvT--
