From: Dan Williams <dcbw@redhat.com>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Date: Mon, 26 Mar 2018 10:16:43 -0500
Message-ID: <e756d74aaff6b0a4546944393e1b98bf51ae4900.camel@redhat.com>
References: <20180322192843.GA17189@amd>
         <a88b0c0c06a6977d8f0c329690f5335b5fb5ab36.camel@redhat.com>
         <20180323105455.GB21644@amd>
         <20180323113521.45va72bhzis6ym6m@earth.universe>
         <20180323201343.GC23658@amd>
         <bd79e802944f16b844c1850572928d93f3f2c4b2.camel@redhat.com>
         <20180324142517.GA94954@atomide.com> <20180324200224.GA17857@amd>
         <20180325154512.GC5700@atomide.com> <20180325185857.GA7582@amd>
         <20180325205232.GD5700@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180325205232.GD5700@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Sun, 2018-03-25 at 13:52 -0700, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180325 19:00]:
> > Hi!
> > 
> > > > Hmm. Interesting. Anyway, for me ttyUSB4 is interesting, as it
> > > > seems
> > > > to react to AT commands, and in particular reacts to ADT123; (;
> > > > is
> > > > important).
> > > 
> > > Is that to dial a voice call?
> > 
> > Yes. And it is ATD123; not ATD.
> 
> Strange, no semicolon is needed when using /dev/gsmtty to
> dial a voice call with my current pile of pending changes,
> just doing ATD123 dials..
> 
> Anyways, looks like qmi_wwan needs to be loaded before
> qcserial module, otherwise we get nine ttyUSB instances
> and ModemManager can't find any modems.

Use qcaux.c or option, unless the 6600 actually *does* have the same
layout as Gobi 1K/2K/etc devices.

If you're going to use qcaux or optoin, then you need to use some
variant of USB_DEVICE_AND_INTERFACE_INFO to lock the serial driver to
the specific USB interfaces that expose the TTYs and to ignore the QMI
interfaces and netdevs.

Dan

> With qcserial module loaded after qmi_wwan, it still takes
> a long time for ModemManager to find the modem.
> 
> Then unrelated to the qcserial module, also looks like I can
> no longer use the GPS with ModemManager:
> 
> $ mmcli -m 0 --enable
> $ mmcli -m 0 --location-enable-gps-raw
> 
> And then chmod a+r /dev/cdc-wdm0 and pointing gpsd to use
> /dev/cdc-wdm0 used to work, but now it seems that gpsd
> can no longer read it. Trying to start gpsd manually produces:
> 
> # gpsd -b -n -N /dev/cdc-wdm0
> gpsd:ERROR: SER: /dev/cdc-wdm0 already opened by another process
> gpsd:ERROR: initial GPS device /dev/cdc-wdm0 open failed
> gpsd:ERROR: can't run with neither control socket nor devices open
> 
> And lsof shows /usr/libexec/qmi-proxy having it open.
> 
> Anybody know what I might be doing wrong? Sounds like something
> now needs to be done with qmi-proxy to get access to GPS?
> 
> > > Anyway, "good" solution is to get ofonod running, then use ofone
> > > from
> > > here: https://github.com/pavelmachek/unicsy_demo
> 
> Thanks I'll take a look.
> 
> > > I think it's the cpcap based config to route voice call audio
> > > to SoC, Sebastian knows the details :)
> > > 
> > > The way to figure that one out is to dump the cpcap registers
> > > before and during voice call on android with cpcaprw, then
> > > diff the output for the audio registers. Probably some SoC
> > > registers need to be diffed too with rwmem or similar tool
> > > for the mcbsp instance(s) used.
> > 
> > That sounds like hard way to do it. There's source available, I'm
> > now
> > trying to understand it / fit it into Sebastian's driver.
> > 
> > https://raw.githubusercontent.com/NotKit/android_kernel_motorola_om
> > ap4-common/hybris-11.0/sound/soc/codecs/cpcap.c
> 
> Sure that hopefully helps too :)
> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
