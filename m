From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: [android-internals] Re: Android on Nokia n810 (OMAP2420)
Date: Sun, 6 Apr 2008 18:36:39 +0200
Message-ID: <fb249edb0804060936w73684e13y4e6b14ffdc6aa634@mail.gmail.com>
References: <f6c5b8d90804020736m3d80fef9h2d377aea7fab52bf@mail.gmail.com>
	 <9a810d71-bc48-4bab-8ad6-93ebc310a110@z38g2000hsc.googlegroups.com>
	 <999ed349-dc22-4db4-a679-60511d9339f7@a23g2000hsc.googlegroups.com>
	 <9ff5cf01-f4aa-4560-b71e-bb948a69d9b9@t54g2000hsg.googlegroups.com>
	 <9583cd73-79d6-4f4e-b5a3-e27c4f165993@p39g2000prm.googlegroups.com>
	 <105bd206-af76-4fbb-affa-6fc8efdf6133@59g2000hsb.googlegroups.com>
	 <f6e0615c-d180-4a3e-a112-c5320cde1cfd@c65g2000hsa.googlegroups.com>
	 <47F7B240.2070901@gmail.com>
	 <20080406132323.GA13033@bulgaria.corp.google.com>
	 <47F8E66E.7080605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:35305 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805AbYDFQgl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Apr 2008 12:36:41 -0400
Received: by ug-out-1314.google.com with SMTP id z38so326298ugc.16
        for <linux-omap@vger.kernel.org>; Sun, 06 Apr 2008 09:36:39 -0700 (PDT)
In-Reply-To: <47F8E66E.7080605@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Georges Toth <georges.toth@gmail.com>
Cc: Brian Swetland <swetland@google.com>, linux-omap@vger.kernel.org

Hi,

On 06/04/2008, Georges Toth <georges.toth@gmail.com> wrote:
>
>
> > Congrats.
> >
> >
>  Thnx :-)
>
>
> > Has anyone had any luck getting a 2.6.23 or 2.6.24 kernel working
> > with the 800 or 810?  When I was poking around with it a while back,
> > I had to backport our stuff to .21 due to binary-only wifi drivers
> > being incompatible with newer kernels.
> >
> >
>  AFAIK, no.
>
>  I've just searched through some mailinglists and apparently it is possible
> to use a more recent kernel with the n800/n810.
>  You basically compile a module called cx3110x which is open source [1], and
> force to load a binary-only module (umac); in order to get wifi to work.
>
>  I'll probably look into this over the next few days as time permits.
>
>
>  [1]:
> http://repository.maemo.org/pool/chinook/free/c/cx3110x-module-src/
>
>
> > Also, if anyone knows of work done to figure out how the battery
> > charge control, etc works on the 800/810 hardware, I'm highly curious.
> Have not had the spare time to reverse engineer that stuff and if
> > somebody's already done the hard work, so much the better.
> >
>  I've only started to work on this last week, but AFAIK the only work that
> has been done on the n800/n810 so far is to actually get the android patches
> to work and get it to run.

Poky (pokylinux.org) and mamona both work pretty well for everyday use
on the nseries.  Fortunately the userspace can partially ignore the
charging issue because the RETU (now Betty) chip takes care of that in
the hardware.  Charging / charger-cable / power-button / battery-life
states are readable from /sys and /dev.

For more advanced power management such as that in maemo (battery type
detection, battery quality, alarm wake-ups, watchdogs etc) more work
would be needed as these are done in userspace on Maemo by services
called DSME and BME and libcal (for retrieving information from OTP)
that are closed-source and I believe not redistributable separately
from Maemo. They are effectively the driver for the RETU and TAHVO
chips whose registers / interrupts are accessed through /dev/retu and
/dev/tahvo nodes.

The best bet for a distro is probably to leave the maemo "initfs",
which contains closed-source DSME / BME / flasher, in place and let
the custom rootfs run on top of it.  If you need some details about
retu / tahvo driving / bootloading, I may be able to tell because I
recently had to poke on it for a different project.

>
>  Next would be to try to get the framebuffer driver hacked to work with the
> m5 image ... the framebuffer driver doesn't support double buffering thus we
> only get a black screen :-(

I understand the userspace is going to be open-source at some point,
which would render this work a bit useless.  If it doesn't get
open-sourced then it's a waste of time either way I think?

Regards
-- 
Please do not print this email unless absolutely necessary. Spread
environmental awareness.
