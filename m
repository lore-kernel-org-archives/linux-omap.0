From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH v2 1/3] power_supply: Add power_supply notifier
Date: Sun, 1 Dec 2013 14:20:58 -0800
Message-ID: <20131201222057.GA22142@lizard>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <1384856285-19593-1-git-send-email-pali.rohar@gmail.com>
 <1384856285-19593-2-git-send-email-pali.rohar@gmail.com>
 <20ADAB092842284E95860F279283C5640AAF43B1@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20ADAB092842284E95860F279283C5640AAF43B1@BGSMSX104.gar.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Tc, Jenny" <jenny.tc@intel.com>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "freemangordon@abv.bg" <freemangordon@abv.bg>, "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>, "pavel@ucw.cz" <pavel@ucw.cz>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 27, 2013 at 05:23:34PM +0000, Tc, Jenny wrote:
>=20
> > Subject: [PATCH v2 1/3] power_supply: Add power_supply notifier
> >=20
> > This patch adds a notifier chain to the power_supply.
> > This notifier helps drivers in other subsystem to listen to changes=
 in power supply
> > subsystem. This would help to take some actions in those drivers on=
 changing the power
> > supply properties.
> > One such scenario is to increase/decrease system performance based =
on the battery
> > capacity/voltage. Another scenario is to adjust the h/w peak curren=
t detection
> > voltage/current thresholds based on battery voltage/capacity. The n=
otifier helps drivers to
> > listen to changes in power_suppy susbystem without polling the powe=
r_supply properties
> >=20
> > Signed-off-by: Jenny TC <jenny.tc@intel.com>
> > Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > ---
>=20
> Acked-by: Jenny TC <jenny.tc@intel.com>

Applied, thanks a lot!

Anton
