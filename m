From: Tony Lindgren <tony@atomide.com>
Subject: Re: call/normal switch was Re: omap4-droid4: voice call support was
Date: Sat, 31 Mar 2018 16:43:14 -0700
Message-ID: <20180331234314.GZ5700@atomide.com>
References: <20180327121441.GH29239@sirena.org.uk>
 <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
 <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com>
 <20180331145531.GA10404@amd>
 <20180331181935.GX5700@atomide.com>
 <20180331191939.GA8999@amd>
 <20180331194616.GA19388@amd>
 <20180331195524.GB19388@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180331195524.GB19388@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Dan Williams <dcbw@redhat.com>
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180331 19:56]:
> On Sat 2018-03-31 21:46:16, Pavel Machek wrote:
> > On Sat 2018-03-31 21:19:39, Pavel Machek wrote:
> > > On Sat 2018-03-31 11:19:35, Tony Lindgren wrote:
> > > > Cool :) Microphone still does not work for me.. I tried tweaking
> > > > the alsamixer settings but no mic. This is with cold boot with
> > > > droid4-kexecboot if that might make a difference, we may have
> > > > some register uninitialized somewhere. Any ideas?
> > > 
> > > Ok, I was focusing on the speaker side.
> > > 
> > > alsamixer, tab to go to capture settings, set it to 37 37 Mic2 Mic1
> > > should work, according to my notes, but not recently tested and not
> > > tested against real human.
> > > 
> > > I'll attempt to test it, but something in my userland shuts down
> > > system just after boot 60% of time, which is rather annoying.
> > 
> > Hmm. So I tried again, and setting Mic1 and back in the capture
> > settings crashed the modem. Bang, disconnected from the USB.
> 
> Next try, and it worked this time.
> 
> _Before the call_, set mode to Normal and then Call. Then go to
> capture, and set 100 100 Mic2 Mic1. Then place a call,
> 
> AT+CFUN=1
> OK
> ATD6;

No luck with microphone here :( Using ttyUSB4, AT+CFUN=1
works, but ATD command on it just hangs the USB interface
and I have to reload phy-mapphone-mdm6600 to reset the
modem.

> If you change Mic1 setting, GSM modem will likely crash.

Have not seen that one here :)

Regards,

Tony
