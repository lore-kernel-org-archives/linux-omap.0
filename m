From: Tony Lindgren <tony@atomide.com>
Subject: Re: call/normal switch was Re: omap4-droid4: voice call support was
Date: Sat, 31 Mar 2018 11:19:35 -0700
Message-ID: <20180331181935.GX5700@atomide.com>
References: <20180323100930.GA21644@amd>
 <20180323103006.alymgb3ywftb4gek@earth.universe>
 <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180327121441.GH29239@sirena.org.uk>
 <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
 <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com>
 <20180331145531.GA10404@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180331145531.GA10404@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Dan Williams <dcbw@redhat.com>
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180331 14:56]:
> Hi!
> 
> > Hmm well I got audio call hacked to work as a proof of concept hack,
> > see below. Maybe it can be used to verify some of the assumptions
> > above.
> > 
> > Then.. To split the work a bit, can you guys maybe try to decode
> > the cpcap register values and try to do a proper ASoC driver patch?
> 
> This is not proper patch yet, but it should be a step in that
> direction...

Cool :) Microphone still does not work for me.. I tried tweaking
the alsamixer settings but no mic. This is with cold boot with
droid4-kexecboot if that might make a difference, we may have
some register uninitialized somewhere. Any ideas?

FYI, I got one of the remaining n_gsm issues tracked down yesterday,
at least one more bug to go. Things only work with n_gsm debug
enabled right now for some reason..

Regards,

Tony
