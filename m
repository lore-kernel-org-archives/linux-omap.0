From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Nokia N900 retention mode in v4.6, camera buttons fun
Date: Sun, 1 May 2016 10:52:36 +0200
Message-ID: <20160501085236.GA14243@amd>
References: <20160407234134.GQ16484@atomide.com>
 <20160411093023.GC11814@amd>
 <20160411094130.GA5753@amd>
 <20160411211026.GH5995@atomide.com>
 <20160412121658.GA32486@amd>
 <20160412123013.GA12296@amd>
 <20160412163055.GP5995@atomide.com>
 <20160417175539.GA502@amd>
 <20160421130450.GQ29406@pali>
 <20160429200559.GA16598@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160429200559.GA16598@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Tony Lindgren <tony@atomide.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri 2016-04-29 22:06:00, Sebastian Reichel wrote:
> Hi,
>=20
> On Thu, Apr 21, 2016 at 03:04:50PM +0200, Pali Roh=E1r wrote:
> > > CONFIG_HSI breaks power management completely, so power managemen=
t
> > > with modem will be another topic. =20
> >=20
> > Sebastian, any idea why power management does not work for HSI?
>=20
> I wasn't aware, that pm_runtime_irq_safe() basically breaks runtime
> PM until Tony's fix for musb (even though it's logical when thinking
> about it). Currently omap-ssi and omap-ssi-port make use of
> pm_runtime_irq_safe().
>=20
> Since pm_runtime_get_sync/pm_runtime_put_sync is called from
> tasklets in omap-ssi (and omap-ssi-port) it cannot be simply
> removed. So fixing PM for the ssi controller requires reworking
> the driver in a non trivial way.

I see latest series, and it also talks about frequency scaling. But I
guess it is not going to fix this issue?

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
