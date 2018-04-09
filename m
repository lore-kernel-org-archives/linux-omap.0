From: Dan Williams <dcbw@redhat.com>
Subject: Re: simultaneous voice/data works (was Re: call/normal switch was
 Re: omap4-droid4: voice call support was)
Date: Mon, 09 Apr 2018 10:53:14 -0500
Message-ID: <d827bf66f88eab01d7716fbe36decb9a539da353.camel@redhat.com>
References: <67086fdd0cdd69142cb89cd00f90e5a580e6607a.camel@redhat.com>
         <20180402155754.GD5700@atomide.com> <20180403150444.GE5700@atomide.com>
         <20180403155023.GA14638@atrey.karlin.mff.cuni.cz>
         <20180403194419.GG5700@atomide.com> <20180406120423.GA18691@amd>
         <516eb3f7-e300-d59d-6a31-ab7545c656f1@wizzup.org>
         <20180407081000.GB7818@amd> <20180407122233.GA11302@amd>
         <cbfc3cfa8acbc02dde848ec4e1d71b5089ff1d10.camel@redhat.com>
         <20180409140847.GP5700@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180409140847.GP5700@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, Merlijn Wajer <merlijn@wizzup.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org

On Mon, 2018-04-09 at 07:08 -0700, Tony Lindgren wrote:
> * Dan Williams <dcbw@redhat.com> [180408 02:46]:
> > On Sat, 2018-04-07 at 14:22 +0200, Pavel Machek wrote:
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
> 
> There should be a NMEA port within the unknown port range
> ttyUSB[123].
> 
> Is there some easy way to enable --location-enable-gps-unmanaged for
> testing so I can check if GPS gets enabled for one of the ports?

Not all modems support all of the ModemManager location options;
-unmanaged is only for devices that support sending the data to a
separate port and for which we know the commands to do that.

It looks like QMI has a way to direct the output to a specific device:

// Enum to describe QMI PDS Output Devices
enum eQMIPDSOutputDevices:UINT8
{
   eQMIPDSOutputDevices_NoneDisabled  = 0,
   eQMIPDSOutputDevices_USB           = 1,
   eQMIPDSOutputDevices_UART1         = 2,
   eQMIPDSOutputDevices_UART2         = 3,
   eQMIPDSOutputDevices_SharedMemory  = 4,
};

so we could add support for that to libqmi and then to ModemManager,
which could help implement --location-enable-gps-unmanaged on alternate
ports.

But what might be simpler is implementing something like the "QMI GPS
proxy" that already exists, but for ModemManager or libqmi directly. 
That way you can use QMI and get known formatting of the output data,
but proxy it to a normal-looking NMEA tty?  Instead of trying to figure
out which TTY/UART/etc the information comes out of for each specific
device and somehow encoding that into the platform.  We know what the
QMI ports are already, that's easy.  We don't know what all the TTYs
are for every given modem and hardcoding that info somewhere is error-
prone and hard to keep up with.

Dan
