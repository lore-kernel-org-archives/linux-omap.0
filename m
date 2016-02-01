From: Pavel Machek <pavel@ucw.cz>
Subject: Re: N900 sleep mode (in 4.5-rc0, if that matters)
Date: Mon, 1 Feb 2016 22:17:36 +0100
Message-ID: <20160201211736.GA11283@amd>
References: <20160123121022.GB12497@amd>
 <20160125163332.GT19432@atomide.com>
 <20160126140010.GA29723@amd>
 <20160126172527.GY3500@atomide.com>
 <20160130200244.GA30429@amd>
 <20160130201452.GC30429@amd>
 <20160130221509.GA28644@amd>
 <20160201181316.GM19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160201181316.GM19432@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

Hi!

> > > > Any ideas what jumps to use the modules? Charger code?
> > > 
> > > I tried a kernel without charger code, and no luck, rmmod fails the
> > > same way. dmesg says:
> > > [  111.093078] wlan0: authenticated
> > > [  111.097442] wlan0: associate with 06:27:22:f9:10:6a (try 1/3)
> > > [  111.104553] wlan0: RX AssocResp from 06:27:22:f9:10:6a (capab=0x421
> > > status=0 aid=2)
> > > [  111.104705] wlan0: AP has invalid WMM params (AIFSN=1 for ACI 2),
> > > will use 2
> > > [  111.104736] wlan0: AP has invalid WMM params (AIFSN=1 for ACI 3),
> > > will use 2
> > > [  111.256652] wlan0: associated
> > > [  184.681427] HS USB OTG: no transceiver configured
> > > [  184.681488] musb-hdrc musb-hdrc.0.auto: musb_init_controller failed
> > > with status -517
> > > [  184.681976] HS USB OTG: no transceiver configured
> > > [  184.682006] musb-hdrc musb-hdrc.0.auto: musb_init_controller failed
> > > with status -517
> > > [  187.690338] twl4030_usb 48070000.i2c:twl@48:twl4030-usb:
> > > Initialized TWL4030 USB module
> > > [  187.698303] musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk
> > > combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
> > > [  187.698333] musb-hdrc: MHDRC RTL version 1.400
> > > [  187.698333] musb-hdrc: setup fifo_mode 4
> > > [  187.698394] musb-hdrc: 28/31 max ep, 16384/16384 memory
> > > pavel@n900:/my/tui/ofone$
> > 
> > I added following hack to phy-twl4030-usb.c so that I could avoid
> > modules and module unloading problem. But still could not get it to
> > sleep :-(.
> 
> Are you sure you're using v4.5-rc? I recently patched away some
> issues where rmmod of the musb related modules did not work.

No, sorry, that was with 4.4. As you hit "PM regression with commit
5de85b9d57ab PM runtime re-init in v4.5-rc1", I thought I'd avoid
v4.5-rc. 

(I assume I have to insmod and rmmod, right? Because powersave is not
entered if I simply compile-out usb).

Would you have commit ids for those rmmod fixes? It might be good to
push them into stable, and I should try again with them applied...

Thanks and best regards,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
