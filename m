From: Tony Lindgren <tony@atomide.com>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Date: Tue, 18 Dec 2018 13:53:11 -0800
Message-ID: <20181218215311.GD6707@atomide.com>
References: <20181217004450.GW6707@atomide.com>
 <20181218124616.GA10758@amd>
 <20181218153650.GA6707@atomide.com>
 <20181218202242.GA30831@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181218202242.GA30831@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Johan Hovold <johan@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, omerlle@gmail.com, Sebastian Reichel <sre@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Rob Herring <robh@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [181218 20:22]:
> Hi!
> 
> > > # commit	    0c1bc81ba976bcd480d6e3c3009a28589f8427c0 (patch)
> > > # mfd: motmdm: Add Motorola TS 27.010 serdev driver for devices like droid4
> > > 
> > > Oh, that is a lot of fun. Especially state machine for parsing modem
> > > responses. I wonder how well it is going to work when modem is
> > > accessed over USB... 
> > > 
> > > motmdm_read_state(... size_t len)
> > 
> > That's a bit of a layering violation yeah :) But we still need to
> > do that somewhere for notifiers. And the notifications are separate
> > from the commands and start with a ~ character so from that point of
> > view it should not be too bad.
> 
> Plus, you seem to assume that data will always come in suitably sized
> chunks. Aha, and as it is not plain serial but packet protocol over
> serial... I guess that is going to work?

Yeah it's just packet data out of the n_gsm.

> > > I did a quick test in my config... and it did not break my old setup
> > > -- voice calls still work when set up over USB and with manual mixer
> > > setup. That was good surprise.
> > 
> > OK good to hear. Using the n_gsm port instead of USB during idle
> > has a major PM advantage as the SoC can hit retention during idle
> > while still connected to the modem and getting notifications.
> > 
> > So looks like during idle we can keep USB in autosuspend mode with
> > something like the below shell script function.
> 
> Yes, I should really start using serials instead of USB. But... I have
> working ofono there, and was using that phone and am little short on
> time at the moment.

Hopefully adding support to ofono and modemmanager to use use
/dev/motmdm1 for calls should be quite trivial now.

Regards,

Tony
