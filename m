From: Pavel Machek <pavel@ucw.cz>
Subject: Re: outdated documentation for lp5523 LED driver?
Date: Fri, 15 Jul 2016 10:54:25 +0200
Message-ID: <20160715085425.GA21257@amd>
References: <20160715073214.GC13429@amd>
 <20160715074052.GE29844@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160715074052.GE29844@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, samu.p.onkalo@nokia.com, milo.kim@ti.com, toshik@chromium.org, j.anaszewski@samsung.com, cooloney@gmail.com
List-Id: linux-omap@vger.kernel.org

On Fri 2016-07-15 09:40:52, Pali Roh=E1r wrote:
> On Friday 15 July 2016 09:32:14 Pavel Machek wrote:
> > Hi!
> >=20
> > Documentation says that load/leds are only visible in the load mode=
,
> > but that does not seem to be true (kernel 4.4.0 on N900).
> >=20
> > # 1) Legacy interface - enginex_mode, enginex_load and enginex_leds
> > #  Control interface for the engines:
> > #    x is 1 .. 3
> > #      enginex_mode : disabled, load, run
> > #      enginex_load : microcode load (visible only in load mode)
> > #      enginex_leds : led mux control (visible only in load mode)
> >=20
> > pavel@n900:/sys/class/leds/lp5523:r/device$ ls -al engine*
> > -rw-r--r-- 1 root root 4096 Jul  6 22:47 engine1_leds
> > --w------- 1 root root 4096 Jul  6 22:47 engine1_load
> > -rw-r--r-- 1 root root 4096 Jul  6 23:41 engine1_mode
> > -rw-r--r-- 1 root root 4096 Jul  6 22:47 engine2_leds
> > --w------- 1 root root 4096 Jul  6 22:47 engine2_load
> > -rw-r--r-- 1 root root 4096 Jul  6 23:41 engine2_mode
> > -rw-r--r-- 1 root root 4096 Jul  6 22:47 engine3_leds
> > --w------- 1 root root 4096 Jul  6 22:47 engine3_load
> > -rw-r--r-- 1 root root 4096 Jul  6 22:47 engine3_mode
> > pavel@n900:/sys/class/leds/lp5523:r/device$ grep . engine*mode
> > engine1_mode:run
> > engine2_mode:load
> > engine3_mode:run
> > pavel@n900:/sys/class/leds/lp5523:r/device$
>=20
> On 2.6.28 kernel is present only legacy interface and for this versio=
n
> is above documentation correct. When engine is in "run" or "disabled"=
,
> then sysfs nodes _load and _leds are invisible.

Well, I don't think 2.6.28 is suitable kernel to compare
against... and I don't think hiding sysfs attributes makes any sense.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
