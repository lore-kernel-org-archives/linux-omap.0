From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 2/3] bq2415x_charger: Use power_supply notifier for
 automode
Date: Mon, 25 Nov 2013 16:18:39 +0100
Message-ID: <20131125151838.GD21526@amd.pavel.ucw.cz>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <201311242041.47075@pali>
 <20131125140127.GA24125@amd.pavel.ucw.cz>
 <201311251510.00987@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201311251510.00987@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Sebastian Reichel <sre@ring0.de>, Anton Vorontsov <anton@enomsg.org>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, freemangordon@abv.bg, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org

On Mon 2013-11-25 15:10:00, Pali Roh=E1r wrote:
> On Monday 25 November 2013 15:01:27 Pavel Machek wrote:
> > Where can I get dsme sources?
> > 									Pavel
>=20
> dsme daemon: https://gitorious.org/community-ssu/dsme
> dsme thermal plugin: https://gitorious.org/rx51-bme-replacement/dsme-=
thermalobject-surface
>=20
> dsme thermal plugin is responsible for checking temperature of=20
> battery and send it to dsme damon. dsme daemon itself checking=20
> temperature limits and do something (e.g reboot device)

Thanks for links!

AFAICT.... dsme daemon does some kind of system management, not
directly controlling charging, right? It does monitor system temperatur=
e.

Now.. Imagine phone left in car in charger (on sun). Likely
temperature will reach high values, kernel is charging, dsme will
reboot the system, but kernel will start charging again, dsme will
reboot again, ...

And it is not only high temperatures that are problem for li-ion
charging; battery should not be fast charged below 5C and should not
be charged below 0C. (Again, both are likely to happen if you leave
your phone in car).

AFAICT, we should simply disable charging below 5C or above 45C.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
