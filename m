From: Tony Lindgren <tony@atomide.com>
Subject: Re: simultaneous voice/data works (was Re: call/normal switch was
 Re: omap4-droid4: voice call support was)
Date: Mon, 9 Apr 2018 07:08:47 -0700
Message-ID: <20180409140847.GP5700@atomide.com>
References: <67086fdd0cdd69142cb89cd00f90e5a580e6607a.camel@redhat.com>
 <20180402155754.GD5700@atomide.com>
 <20180403150444.GE5700@atomide.com>
 <20180403155023.GA14638@atrey.karlin.mff.cuni.cz>
 <20180403194419.GG5700@atomide.com>
 <20180406120423.GA18691@amd>
 <516eb3f7-e300-d59d-6a31-ab7545c656f1@wizzup.org>
 <20180407081000.GB7818@amd>
 <20180407122233.GA11302@amd>
 <cbfc3cfa8acbc02dde848ec4e1d71b5089ff1d10.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cbfc3cfa8acbc02dde848ec4e1d71b5089ff1d10.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dcbw@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Merlijn Wajer <merlijn@wizzup.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org

* Dan Williams <dcbw@redhat.com> [180408 02:46]:
> On Sat, 2018-04-07 at 14:22 +0200, Pavel Machek wrote:
> > I tried --location-enable-gps-unmanaged , but that did not work for
> > me.
> 
> That requires a TTY that would spit out the GPS data; in this mode MM
> only sends the start/stop commands, and what comes out the GPS TTY is
> undefined (at least by MM).
> 
> So unless you know that one of the 6600's TTYs does GPS and in what
> format it does GPS, then no.

There should be a NMEA port within the unknown port range ttyUSB[123].

Is there some easy way to enable --location-enable-gps-unmanaged for
testing so I can check if GPS gets enabled for one of the ports?

Regards,

Tony
