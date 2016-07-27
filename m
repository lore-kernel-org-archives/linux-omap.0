From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/2] net: davinci_cpdma: reduce latency on -rt
Date: Wed, 27 Jul 2016 09:03:02 +0200
Message-ID: <20160727070302.GG5368@pengutronix.de>
References: <1469534545-14478-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <f546b5f0-1da6-2c16-647a-33bb8692b753@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f546b5f0-1da6-2c16-647a-33bb8692b753@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Mugunthan V N <mugunthanvnm@ti.com>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 26, 2016 at 05:36:49PM +0300, Grygorii Strashko wrote:
> On 07/26/2016 03:02 PM, Uwe Kleine-K=F6nig wrote:
> >Hello,
> >
> >these patches are based on next-20160726. I didn't check yet how lat=
ency
> >improves by using these patches, but even if the improvment is small=
,
> >it's still a good idea to have them.
>=20
> Sry, but how this will affect on -RT? This is not a raw locks, so
> they will be converted to rt-mutexes which are sleepable.
> Or I've missed smth?

They are still locks after all. On -rt I saw for the relevant
application:

  send package         |
    take lock          |
    write pckt to hw   |
                       | rcv irq
		       |   take lock
		       |     schedule
    drop lock	       |=20
      schedule         |
                       |   get pckt from hw
		       |   drop lock

So reducing the time a lock is taken reduces the chances that the lock
is contended for another thread which results in extra context switches=
=2E

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
