From: Pavel Machek <pavel@ucw.cz>
Subject: Re: usb: gadget breakage on N900: bind UDC by name passed via
 usb_gadget_driver structure
Date: Sun, 27 Mar 2016 22:26:57 +0200
Message-ID: <20160327202657.GA31059@amd>
References: <CAB=otbRd+hZaO6ihL3c88Ys_q-R4grmup4cfP70PT+N2JEQ3WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAB=otbRd+hZaO6ihL3c88Ys_q-R4grmup4cfP70PT+N2JEQ3WQ@mail.gmail.com>
 <CAB=otbQ=jJNk=CtB4hu51HXxOLxhWEDaeWf3V0Uc7Uh3veXsfg@mail.gmail.com>
 <CAB=otbQ1J7FZm9vWLwor93+uD3Fv38ykduWMXG3qByNh4mV9=g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, Patrik Bachan <patrikbachan@gmail.com>, serge@hallyn.com, Maxime Ripard <maxime.ripard@free-electrons.com>, Peter Chen <peter.chen@freescale.com>, Felipe Balbi <balbi@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi!

> >> I managed to boot N900 with working USB gadget (builtin g_ether)
> >> in boardfile mode, can ping it from PC and transfer data. I don't
> >> see any issue (except of musb name issue in twl phy driver, I've
> >> already sent a fix for that: https://lkml.org/lkml/2016/3/24/670 )
> >>
> >> Pavel, I still don't see how you've got your issue, please share
> >> more detials
> >
> > Ok, let me try. I undid all the changes in drivers/phy drivers/usb and
> > include/linux/usb . I have all the gadget stuff built-in, so that I
> > could use nfsroot, but this is boot from mmcblk.
> 
> So do you mean you use original rootfs that was shipeed with N900?

No. I'm using Debian ARM root. It includes useful X and even phone
functions. https://gitlab.com/tui/tui .

> > gzipped config is attached.
> 
> Thanks, I'll try that

Thanks.

> > Dmesg from the n900 is attached as /tmp/delme.gz. I did _not_ apply
> > the patch from https://lkml.org/lkml/2016/3/24/670 , yet, as I'm using
> > devicetree boot.
> 
> Hmm.. don't see anything strange in the boot log related to USB,
> I'll try your config

Let me know how it went.

> >> Dmesg from the n900 is attached as /tmp/delme.gz. I did _not_ apply
> >> the patch from https://lkml.org/lkml/2016/3/24/670 , yet, as I'm using
> >> devicetree boot.
> >
> > Hmm.. don't see anything strange in the boot log related to USB,
> > I'll try your config
> 
> After looking into your config and boot log again, I see you use kernel
> 4.4, whereas the patch you've told about ("usb: gadget: bind UDC by name
> passed via usb_gadget_driver structure") was merged only into 4.5 kernel.
> Could you please try vanilla v4.5 with your config and see if it
> helps?

...ok, I could do that, but:

> >> I managed to boot N900 with working USB gadget (builtin g_ether)
> >> in boardfile mode, can ping it from PC and transfer data. I don't
> >> see any issue (except of musb name issue in twl phy driver, I've
> >> already sent a fix for that: https://lkml.org/lkml/2016/3/24/670 )
> >
> > I tried to add that one, too, and no change. Can I get your .config?
> 
> Since you use DT boot, this patch will not have any effect.
> See my config attached.

...it looks like it is not expected to have any effect.

Ok, let me examine the config.

Best regards,

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
