From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: [android-internals] Re: Android on Nokia n810 (OMAP2420)
Date: Mon, 7 Apr 2008 01:41:30 +0200
Message-ID: <fb249edb0804061641s57f52b15x553c6cb9366909b6@mail.gmail.com>
References: <f6c5b8d90804020736m3d80fef9h2d377aea7fab52bf@mail.gmail.com>
	 <9ff5cf01-f4aa-4560-b71e-bb948a69d9b9@t54g2000hsg.googlegroups.com>
	 <9583cd73-79d6-4f4e-b5a3-e27c4f165993@p39g2000prm.googlegroups.com>
	 <105bd206-af76-4fbb-affa-6fc8efdf6133@59g2000hsb.googlegroups.com>
	 <f6e0615c-d180-4a3e-a112-c5320cde1cfd@c65g2000hsa.googlegroups.com>
	 <47F7B240.2070901@gmail.com>
	 <20080406132323.GA13033@bulgaria.corp.google.com>
	 <47F8E66E.7080605@gmail.com>
	 <fb249edb0804060936w73684e13y4e6b14ffdc6aa634@mail.gmail.com>
	 <47F92640.9080107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:48908 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754922AbYDFXlc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Apr 2008 19:41:32 -0400
Received: by ug-out-1314.google.com with SMTP id z38so378762ugc.16
        for <linux-omap@vger.kernel.org>; Sun, 06 Apr 2008 16:41:31 -0700 (PDT)
In-Reply-To: <47F92640.9080107@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Georges Toth <georges.toth@gmail.com>
Cc: linux-omap@vger.kernel.org

On 06/04/2008, Georges Toth <georges.toth@gmail.com> wrote:
> >  Fortunately the userspace can partially ignore the
> > charging issue because the RETU (now Betty) chip takes care of that in
> > the hardware.  Charging / charger-cable / power-button / battery-life
> > states are readable from /sys and /dev.
> >
> >
>  Hmm where exactly can you read that info from ?
>  I quickly searched through sysfs, proc and dev but without much luck  :-)

The battery and charger are connected to the ADC in retu which has 14
channels.  I thought I saw an interface in the stock n810 kernel to
get their readings through /sys but apparently there isn't any, except
for the "Headset detection" channel, my bad.  In this case, to read
the values you need to open /dev/retu and issue RETU_IOCH_ADC_READ
ioctl (number _IO(0x60, 0x03)) with the channel number as parameter.
It returns the 12-bit ADC value. The channel names are the following:

0 - Ground
1 - BSI
2 - Battery temperature
3 - Charger voltage
4 - Headset detection
5 - Hook detection
6 - RF GP
7 - Wideband Tx detection
8 - Battery voltage
9 - Ground
10 - Light sensor
11 - Light sensor temperature
12 - Backup battery voltage
13 - RETU temperature
(the names come from the NOLO bootloader help messages)

The light sensor is actually connected to a separate ADC whose value
is available in /sys/class/hwmon/... somewhere.

When BME is running the already processed battery state can be read
from hal with:
$ hal-get-property --udi /org/freedesktop/Hal/devices/bme --key
battery.charge_level.percentage

("hal-device /org/freedesktop/Hal/devices/bme" gives more info)

>
>
> > The best bet for a distro is probably to leave the maemo "initfs",
> > which contains closed-source DSME / BME / flasher, in place and let
> > the custom rootfs run on top of it.  If you need some details about
> > retu / tahvo driving / bootloading, I may be able to tell because I
> > recently had to poke on it for a different project.
> >
> >
>  Should I get android to work correctly it would be nice to automatically
> start android after booting the n810.

Poky works that way, the initfs boots first (the stock initfs,
unmodified) and eventually chroot's into the rootfs which is a Poky
image and the system starts automatically but you still get the stock
nokia flasher and charger screen in initfs.

>  Thus if you have any info on setting up wifi automatically from a script
> and what exactly to disable to prevent the system from starting Xomap, dbus,
> hal etc... that would be nice :-)

I haven't looked into the software side much, but I'm sure that if you
replace the rootfs, Xomap won't start.  The initfs has a /linuxrc file
that can be custimsed.

>
>
> >
> > >  Next would be to try to get the framebuffer driver hacked to work with
> the
> > > m5 image ... the framebuffer driver doesn't support double buffering
> thus we
> > > only get a black screen :-(
> > >
> > >
> > I understand the userspace is going to be open-source at some point,
> > which would render this work a bit useless.  If it doesn't get
> > open-sourced then it's a waste of time either way I think?
> >
> >
>  According to what I've read so far it will be open-sourced as soon as the
> first devices start to appear...which probably won't be anytime soon
>
>  But even then that work wouldn't be useless because Google won't release a
> framebuffer driver for Nokia n800/810 ... so if one wants to be able to run
> m5 and future releases, somebody has to modify the current driver to be
> compatible with android...if that is even possible.

What I mean is that this is the kind of issue that takes probably
minutes to fix in the userspace for a person that has the sources, but
can take days to a person trying to work around the userspace bug in
the kernel, time that could be spent on actual free software,
collaborative projects.  The issue as I understand is in the userspace
which is written in a way that's not portable between framebuffers,
probably ignoring existing standards and existing libraries for
accessing framebuffers.
-- 
Please do not print this email unless absolutely necessary. Spread
environmental awareness.
