From: Pavel Machek <pavel@ucw.cz>
Subject: Re: N900 sleep mode (in 4.5-rc0, if that matters)
Date: Sun, 7 Feb 2016 22:37:20 +0100
Message-ID: <20160207213720.GB6147@amd>
References: <20160125163332.GT19432@atomide.com> <20160126140010.GA29723@amd>
 <20160126172527.GY3500@atomide.com> <20160130200244.GA30429@amd>
 <20160130201452.GC30429@amd> <20160130221509.GA28644@amd>
 <20160201181316.GM19432@atomide.com> <20160201211736.GA11283@amd>
 <20160201221111.GP19432@atomide.com>
 <20160204053518.GP19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160204053518.GP19432@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, pali.rohar@gmail.com, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

Hi!

> > > No, sorry, that was with 4.4. As you hit "PM regression with commit
> > > 5de85b9d57ab PM runtime re-init in v4.5-rc1", I thought I'd avoid
> > > v4.5-rc. 
> > 
> > OK
> > 
> > > (I assume I have to insmod and rmmod, right? Because powersave is not
> > > entered if I simply compile-out usb).
> > 
> > Depending on what the bootloader does and probably also if
> > USB was used during the booting.. So yeah you may need to modprobe
> > and then rmmod.
> > 
> > > Would you have commit ids for those rmmod fixes? It might be good to
> > > push them into stable, and I should try again with them applied...
> > 
> > 055555fc459 ("usb: musb: core: Fix handling of the phy notifications")
> > 03e43528ab68 ("usb: musb: Fix unbalanced pm_runtime_enable")
> 
> Oh and looks like these two phy-twl4030-phy fixes never got
> merged from thread "[PATCH 0/2] Two phy-twl4030-usb fixes for
> unloading the module":
> 
> phy: twl4030-usb: Relase usb phy on unload
> phy: twl4030-usb: Fix unbalanced pm_runtime_enable on module reload
> 
> I'll resend those. But without those again deeper idle states
> are blocked.. And it could be that n900 needs similar additional
> patches for it's USB PHY as I've tested things so far only with
> phy-twl4030-usb PHY based systems.

I don't get it. I was using

+CONFIG_USB_MUSB_OMAP2PLUS=m
+CONFIG_TWL4030_USB=m

on the n900. Are you suggesting I should be using something else on
the N900? If so, what?

Pali, do you have deeper sleep states working on 4.4 kernel? (Or
anything 4.X?)
									
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
