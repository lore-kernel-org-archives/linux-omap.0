From: Tony Lindgren <tony@atomide.com>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Date: Wed, 16 Jan 2019 18:54:36 -0800
Message-ID: <20190117025436.GR5544@atomide.com>
References: <20181217004450.GW6707@atomide.com>
 <20181218124616.GA10758@amd>
 <20181218153650.GA6707@atomide.com>
 <20181218202242.GA30831@amd>
 <20181218215311.GD6707@atomide.com>
 <20190116134823.GA10145@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190116134823.GA10145@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Johan Hovold <johan@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, omerlle@gmail.com, Sebastian Reichel <sre@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Rob Herring <robh@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [190116 13:48]:
> "quite trivial" does not mix with ofono. I did parts and it is still
> not finished. At the moment, I do not have enough working SIM cards to
> test everything. Feel free to help :-).

I gave it a try but could only see "ofonod[14012]: motmdm init"
on start up. Running test/list-modems shows only /stktest
and no motmdm..

Do I need to configure something in /etc/ofono?

Regards,

Tony
