From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] RX-51: Add platform function and data for bq24150a
 charger
Date: Mon, 23 Sep 2013 11:03:00 -0700
Message-ID: <20130923180259.GJ2684@atomide.com>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <1378630239-10006-5-git-send-email-pali.rohar@gmail.com>
 <201309202122.06327@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201309202122.06327@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Anton Vorontsov <anton@enomsg.org>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, freemangordon@abv.bg, aaro.koskinen@iki.fi, pavel@ucw.cz
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [130920 12:29]:
> On Sunday 08 September 2013 10:50:39 Pali Roh=C3=A1r wrote:
> > This patch will register bq24150a charger in RX-51 board data.
> > Patch also adding platform function between isp1704 and
> > bq2415x drivers for detecting charger type.
> >=20
> > So finally charging battery on Nokia N900 (RX-51) working
> > automatically without any proprietary Nokia bits in userspace.
=2E..
=20
> > @@ -277,6 +316,7 @@ static void rx51_charger_set_power(bool
> > on)
> >=20
> >  static struct isp1704_charger_data rx51_charger_data =3D {
> >  	.set_power	=3D rx51_charger_set_power,
> > +	.set_current	=3D rx51_charger_set_current,
> >  };

We want to get rid of the platform data callbacks here,
there no longer any need to keep these under arch/arm.

> Tony, can you look and review this board patch?

Yes, looks like this can all be done in the driver nowadays.
You can use drivers/reset for the set_power. Or if it's really
controlling the regulator, then the regulator framework. The
info can be passed in a .dts file for those.

The .set_current you can do in the driver based on the
compatible flag.
=20
> I think that this patch series it the most important for Nokia=20
> N900, because it finally bringing charging support. And without=20
> charging battery it very hard to use phone which has power supply=20
> only from battery.

Right, let's get this driver updated to use the device tree
based init and that way this file is no longer needed.
I would like to $ grep -i grandmom ~/.phonebook | call too :)

I forgot how this charger is wired up, but maybe take a
look at commit d7bf353f (bq24190_charger: Add support for TI
BQ24190 Battery Charger) for the DT parts.

Regards,

Tony
