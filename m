From: Dan Williams <dcbw@redhat.com>
Subject: Re: simultaneous voice/data works (was Re: call/normal switch was
 Re: omap4-droid4: voice call support was)
Date: Sun, 08 Apr 2018 22:15:30 -0500
Message-ID: <1a37aaadcd25b849d81bf295b28cdad7d5ffd1d2.camel@redhat.com>
References: <67086fdd0cdd69142cb89cd00f90e5a580e6607a.camel@redhat.com>
         <20180402155754.GD5700@atomide.com> <20180403150444.GE5700@atomide.com>
         <20180403155023.GA14638@atrey.karlin.mff.cuni.cz>
         <20180403194419.GG5700@atomide.com> <20180406120423.GA18691@amd>
         <516eb3f7-e300-d59d-6a31-ab7545c656f1@wizzup.org>
         <20180407081000.GB7818@amd> <20180407122233.GA11302@amd>
         <cbfc3cfa8acbc02dde848ec4e1d71b5089ff1d10.camel@redhat.com>
         <20180408074124.GA19844@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180408074124.GA19844@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Merlijn Wajer <merlijn@wizzup.org>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org

On Sun, 2018-04-08 at 09:41 +0200, Pavel Machek wrote:
> Hi!
> 
> > > mmcli -m 0 --enable
> > > mmcli -m 0  --location-enable-gps-nmea
> > > watch -n .3 sudo mmcli -m 0  --location-get-gps-nmea
> > > 
> > > ...can be used to get GPS data. Droid4 seems to have rather bad
> > > GPS,
> > > so you should probably put it near window for testing.
> > > 
> > > Is there way to grab data from modemmanager and feed it to gpsd,
> > > so
> > > that normal applications can access gps? I don't see easy way.
> > > 
> > > I tried --location-enable-gps-unmanaged , but that did not work
> > > for
> > > me.
> > 
> > That requires a TTY that would spit out the GPS data; in this mode
> > MM
> > only sends the start/stop commands, and what comes out the GPS TTY
> > is
> > undefined (at least by MM).
> > 
> > So unless you know that one of the 6600's TTYs does GPS and in what
> > format it does GPS, then no.
> > 
> > Doesn't --location-get-gps-nmea work for you?  That will spit out
> > the
> > latest NMEA traces MM gets from the modem, if it supports NMEA.  I
> > believe --location-status will tell you what methods MM supports
> > with
> > the modem.
> 
> Yes, --location-get-gps-nmea works for me.
> 
> I guess one way forward would be to implement --location-get-gps-nmea
> support for qmicli, and use that?

Yeah, libqmi already has the necessary bits but it's not plumbed
through to qmicli.  Note that qmicli is a straight interface to QMI and
doesn't try to impose abstractions on anything, so you wouldn't get --
location-get-gps-nmea, but you'd instead be working directly with the
QMI PDS (older) and/or LOC (newer) service commands.

Dan
