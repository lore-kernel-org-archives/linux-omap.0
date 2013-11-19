From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2 1/3] power_supply: Add power_supply notifier
Date: Tue, 19 Nov 2013 14:19:19 +0100
Message-ID: <201311191419.25036@pali>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com> <1384856285-19593-2-git-send-email-pali.rohar@gmail.com> <20131119131006.GD14587@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131119131006.GD14587@amd.pavel.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Anton Vorontsov <anton@enomsg.org>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, freemangordon@abv.bg, aaro.koskinen@iki.fi, Jenny TC <jenny.tc@intel.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 19 November 2013 14:10:06 Pavel Machek wrote:
> On Tue 2013-11-19 11:18:03, Pali Roh=C3=A1r wrote:
> > This patch adds a notifier chain to the power_supply.
> > This notifier helps drivers in other subsystem to listen to
> > changes in power supply subsystem. This would help to take
> > some actions in those drivers on changing the power supply
> > properties. One such scenario is to increase/decrease
> > system performance based on the battery capacity/voltage.
> > Another scenario is to adjust the h/w peak current
> > detection voltage/current thresholds based on battery
> > voltage/capacity. The notifier helps drivers to listen to
> > changes in power_suppy susbystem without polling the
> > power_supply properties
> >=20
> > Signed-off-by: Jenny TC <jenny.tc@intel.com>
> > Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>=20
> Reviewed-by: Pavel Machek <pavel@ucw.cz>
>=20
> > +extern struct atomic_notifier_head  =20
> > power_supply_notifier;
>=20
> You may want to delete some spaces here.
>=20
> Thanks,
> 								Pavel

Ok, note that this patch I copied from:=20
https://lkml.org/lkml/2013/9/23/181

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
