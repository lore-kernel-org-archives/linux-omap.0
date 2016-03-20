From: Pavel Machek <pavel@ucw.cz>
Subject: Re: N900 sleep mode (in 4.5-rc0, if that matters)
Date: Sun, 20 Mar 2016 09:33:08 +0100
Message-ID: <20160320083308.GA13408@amd>
References: <20160126140010.GA29723@amd>
 <20160126172527.GY3500@atomide.com>
 <20160130200244.GA30429@amd>
 <20160130201452.GC30429@amd>
 <20160130221509.GA28644@amd>
 <20160201181316.GM19432@atomide.com>
 <20160201211736.GA11283@amd>
 <20160201221111.GP19432@atomide.com>
 <20160207212316.GA6147@amd>
 <20160209172403.GK19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160209172403.GK19432@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

Hi!

First, sorry for the delay. Busy with other projects, then tried to
keep USB in 4.5 from regressing.

I'm now back on 4.4 branch.

> > > > (I assume I have to insmod and rmmod, right? Because powersave is not
> > > > entered if I simply compile-out usb).
> > > 
> > > Depending on what the bootloader does and probably also if
> > > USB was used during the booting.. So yeah you may need to modprobe
> > > and then rmmod.
> > > 
> > > > Would you have commit ids for those rmmod fixes? It might be good to
> > > > push them into stable, and I should try again with them applied...
> > > 
> > > 055555fc459 ("usb: musb: core: Fix handling of the phy notifications")
> > > 03e43528ab68 ("usb: musb: Fix unbalanced pm_runtime_enable")
> > 
> > Ok, with that, I can insmod and rmmod. But I still get:
> > 
> > 00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
> 
> I think the cm_idlest_per is fine.
> 
> > ffdffebd 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00200042
> > 0000000d 48004a28 (fa004a28) cm_idlest3_core
> 
> Bit 21 in cm_idlest1_core is for MCSPI4 so WLAN. Does that go
> down if do sleep 5; cat /sys/kernel/debug/pm_debug/count ?

I'm using

sudo iw dev wlan0 set power_save on ; not sure if it matters.

I now have:

f7de3e8d 48004a20 (fa004a20) cm_idlest1_core blocking bits: 0021c072

So that bit seems to stay here. Aha... and it went off now:

f7fe3e8d 48004a20 (fa004a20) cm_idlest1_core blocking bits: 0001c072

Good. I still have some work in USB disabling.

> If not, the're PM runtime missing or broken somewhere.
> 
> FYI, below is my omap3 usb test script that I use to start and
> stop USB, it also works on n900. And after stopping it n900
> continues hitting deeper idle states just fine.
> 
> That is with these two phy patches applied on v4.5-rc3:
> 
> "phy: twl4030-usb: Fix unbalanced pm_runtime_enable on module reload")
> "phy: twl4030-usb: Relase usb phy on unload")
> 
> Maybe I gave you wrong info on the USB patches needed.. But these
> two above are needed on v4.5-rc3. And looks like Kishon has now
> applied them.

Lets see... yes, I seem to have those. Messing with modules is hard in
my environment, and I push kernels over usb from the "NOLO" IIRC.

> Oh and I also have the MMC PM runtime regression fix here that I
> have not yet posted. Will post today. But I guess you're on
> v4.4 right now still.

Yes. I can now go to 4.5 (or even 4.6-rc0 if needed), but I guess
staying on 4.4 is easiest for now.

Thanks for the script.

> 	rmmod $udc_glue
> 	rmmod $phy_module
> 	rmmod $udc_module

Aha, you are removing one more module; I was not working with
musb_hdrc.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
