From: Tony Lindgren <tony@atomide.com>
Subject: Re: N900 sleep mode (in 4.5-rc0, if that matters)
Date: Tue, 9 Feb 2016 09:38:08 -0800
Message-ID: <20160209173807.GL19432@atomide.com>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [160209 09:26]:
> * Pavel Machek <pavel@ucw.cz> [160207 13:24]:
> > Hi!
> > 
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
> 
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
> 
> Oh and I also have the MMC PM runtime regression fix here that I
> have not yet posted. Will post today. But I guess you're on
> v4.4 right now still.

And looks like the USB RNDIS gadget has some extra issues
breaking reboot. So I'd stick to ECM if possible and leave out
RNDIS completely.

Tony
