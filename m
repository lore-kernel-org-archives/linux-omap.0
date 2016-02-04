From: Tony Lindgren <tony@atomide.com>
Subject: Re: N900 sleep mode (in 4.5-rc0, if that matters)
Date: Wed, 3 Feb 2016 21:35:18 -0800
Message-ID: <20160204053518.GP19432@atomide.com>
References: <20160123121022.GB12497@amd>
 <20160125163332.GT19432@atomide.com>
 <20160126140010.GA29723@amd>
 <20160126172527.GY3500@atomide.com>
 <20160130200244.GA30429@amd>
 <20160130201452.GC30429@amd>
 <20160130221509.GA28644@amd>
 <20160201181316.GM19432@atomide.com>
 <20160201211736.GA11283@amd>
 <20160201221111.GP19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160201221111.GP19432@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [160201 14:12]:
> * Pavel Machek <pavel@ucw.cz> [160201 13:18]:
> > 
> > No, sorry, that was with 4.4. As you hit "PM regression with commit
> > 5de85b9d57ab PM runtime re-init in v4.5-rc1", I thought I'd avoid
> > v4.5-rc. 
> 
> OK
> 
> > (I assume I have to insmod and rmmod, right? Because powersave is not
> > entered if I simply compile-out usb).
> 
> Depending on what the bootloader does and probably also if
> USB was used during the booting.. So yeah you may need to modprobe
> and then rmmod.
> 
> > Would you have commit ids for those rmmod fixes? It might be good to
> > push them into stable, and I should try again with them applied...
> 
> 055555fc459 ("usb: musb: core: Fix handling of the phy notifications")
> 03e43528ab68 ("usb: musb: Fix unbalanced pm_runtime_enable")

Oh and looks like these two phy-twl4030-phy fixes never got
merged from thread "[PATCH 0/2] Two phy-twl4030-usb fixes for
unloading the module":

phy: twl4030-usb: Relase usb phy on unload
phy: twl4030-usb: Fix unbalanced pm_runtime_enable on module reload

I'll resend those. But without those again deeper idle states
are blocked.. And it could be that n900 needs similar additional
patches for it's USB PHY as I've tested things so far only with
phy-twl4030-usb PHY based systems.

Regards,

Tony
