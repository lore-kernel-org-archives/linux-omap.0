From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/3] Add support for charging battery in Nokia RX-51
Date: Tue, 19 Nov 2013 07:40:52 -0800
Message-ID: <20131119154052.GB10317@atomide.com>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <1384856285-19593-1-git-send-email-pali.rohar@gmail.com>
 <20131119144407.GB28455@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131119144407.GB28455@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Anton Vorontsov <anton@enomsg.org>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, freemangordon@abv.bg, aaro.koskinen@iki.fi, pavel@ucw.cz
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@debian.org> [131119 06:45]:
> Hi Pali,
>=20
> On Tue, Nov 19, 2013 at 11:18:02AM +0100, Pali Roh=C3=A1r wrote:
> > This patch series finally bringing support for charging battery on
> > Nokia N900 (RX-51) without any proprietary Nokia bits in userspace.
>=20
> YAY! :)
>=20
> > I removed hook function from bq2415x_charger driver and replaced it
> > by Jenny TC power_supply notifier code. This simplify usage of
> > bq2415x driver and also allow adding DT support in future because
> > driver does not need board specific function anymore (only static d=
ata).
> >=20
> > I tested this series with linux 3.12-rc5 on Nokia N900.
>=20
> cool :)
>=20
> Do you want me to take this up and add DT support?

Great news, yeah let's add this with DT support instead as we're
planning to switch over to DT only booting anyways. The values can be
probably set directly in the charger driver based on the compatible
flag.

Note that we can also still add the I2C devices as needed from
the pdata-quirks.c, but in this case there should not be any need
for it :)

Regards,

Tony
