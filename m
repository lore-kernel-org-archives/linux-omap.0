From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 1/3] power_supply: Add power_supply notifier
Date: Tue, 19 Nov 2013 14:10:06 +0100
Message-ID: <20131119131006.GD14587@amd.pavel.ucw.cz>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <1384856285-19593-1-git-send-email-pali.rohar@gmail.com>
 <1384856285-19593-2-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1384856285-19593-2-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Anton Vorontsov <anton@enomsg.org>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, freemangordon@abv.bg, aaro.koskinen@iki.fi, Jenny TC <jenny.tc@intel.com>
List-Id: linux-omap@vger.kernel.org

On Tue 2013-11-19 11:18:03, Pali Roh=E1r wrote:
> This patch adds a notifier chain to the power_supply.
> This notifier helps drivers in other subsystem to listen to
> changes in power supply subsystem. This would help to take some
> actions in those drivers on changing the power supply properties.
> One such scenario is to increase/decrease system performance based
> on the battery capacity/voltage. Another scenario is to adjust the
> h/w peak current detection voltage/current thresholds based on batter=
y
> voltage/capacity. The notifier helps drivers to listen to changes
> in power_suppy susbystem without polling the power_supply properties
>=20
> Signed-off-by: Jenny TC <jenny.tc@intel.com>
> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>

Reviewed-by: Pavel Machek <pavel@ucw.cz>

> +extern struct atomic_notifier_head    power_supply_notifier;

You may want to delete some spaces here.

Thanks,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
