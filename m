From: Tony Lindgren <tony@atomide.com>
Subject: Re: call/normal switch was Re: omap4-droid4: voice call support was
Date: Tue, 3 Apr 2018 12:44:19 -0700
Message-ID: <20180403194419.GG5700@atomide.com>
References: <20180331194616.GA19388@amd>
 <20180331195524.GB19388@amd>
 <20180331234314.GZ5700@atomide.com>
 <20180401131852.GA11086@amd>
 <20180401153631.GA5700@atomide.com>
 <20180401173012.GB5700@atomide.com>
 <67086fdd0cdd69142cb89cd00f90e5a580e6607a.camel@redhat.com>
 <20180402155754.GD5700@atomide.com>
 <20180403150444.GE5700@atomide.com>
 <20180403155023.GA14638@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180403155023.GA14638@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dan Williams <dcbw@redhat.com>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180403 15:51]:
> Hi!
> 
> > > OK thanks for checking. So probably only n_gsm channel 1 is for normal
> > > Qualcomm at commands, and then channel 2 and others are commands
> > > implemented by Motorola on the mdm6600.
> > > 
> > > I guess we'd have to add support for reading and writing to
> > > /dev/gsmtty2 at least as it looks like these cannot be accessed
> > > via /dev/ttyUSB4. Or at least I have not figured out any other
> > > way to access them.
> > 
> > Hmm or maybe there is some way to select where qmi to tunnels the
> > AT commands to? Some kind of channel type paramenter like n_gsm
> > has?
> > 
> > Anyways, for trying to figure out things for alsamixer, I tested
> > that ngsm 2 "AT+EACC=3,0" is not related to cpcap audio register
> > settings and the mic is enabled during the call with Pavel's patch
> > with alsamixer "Mode" set to either "Call" or "Normal". Also speaker
> > keeps working during the call toggling between "Call" and "Normal".
> > "Voice" in alsamixer does also control the speaker volume during
> > the call. And setting the second "Speaker" from "Voice" to "HiFi"
> > mutes the speaker.
> 
> Take a look at the patch. Selecting "call" does something at hardware
> level, selecting "normal" is a nop.
> 
> Sorry for confusion.
> 
> Yes, that patch needs more work.

OK that explains why the speaker keeps working then :)

Regards,

Tony
