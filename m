From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 4/5] watchdog: move omap_wdt.h to include/linux/watchdog
Date: Fri, 19 Sep 2008 14:06:45 +0300
Message-ID: <20080919110645.GO28615@gandalf.research.nokia.com>
References: <1221820359-8943-1-git-send-email-felipe.balbi@nokia.com> <1221820359-8943-2-git-send-email-felipe.balbi@nokia.com> <1221820359-8943-3-git-send-email-felipe.balbi@nokia.com> <1221820359-8943-4-git-send-email-felipe.balbi@nokia.com> <1221820359-8943-5-git-send-email-felipe.balbi@nokia.com> <20080919115627.343a2847@lxorguk.ukuu.org.uk>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753400AbYISLTX@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080919115627.343a2847@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: ext Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Wim Van Sebroeck <wim@iguana.be>, Andrew Morton <akpm@linux-foundation.org>, "George G. Davis" <gdavis@mvista.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 19, 2008 at 11:56:27AM +0100, ext Alan Cox wrote:
> On Fri, 19 Sep 2008 13:32:38 +0300
> Felipe Balbi <felipe.balbi@nokia.com> wrote:
> 
> > Create a new include/linux/watchdog directory
> > for holding watchdog chips headers, move omap_wdt.h
> > to the new location and update the include path in
> > the driver source.
> 
> Headers that are driver private belong with the driver. In fact in many
> cases they belong *in* the driver C file but that depends how much is
> there.
> 
> 
> 
> > +#define OMAP_WATCHDOG_REV		(0x00)
> > +#define OMAP_WATCHDOG_SYS_CONFIG	(0x10)
> > +#define OMAP_WATCHDOG_STATUS		(0x14)
> > +#define OMAP_WATCHDOG_CNTRL		(0x24)
> > +#define OMAP_WATCHDOG_CRR		(0x28)
> > +#define OMAP_WATCHDOG_LDR		(0x2c)
> > +#define OMAP_WATCHDOG_TGR		(0x30)
> > +#define OMAP_WATCHDOG_WPS		(0x34)
> > +#define OMAP_WATCHDOG_SPR		(0x48)
> > +
> > +/* Using the prescaler, the OMAP watchdog could go for many
> > + * months before firing.  These limits work without scaling,
> > + * with the 60 second default assumed by most tools and docs.
> > + */
> > +#define TIMER_MARGIN_MAX	(24 * 60 * 60)	/* 1 day */
> > +#define TIMER_MARGIN_DEFAULT	60	/* 60 secs */
> > +#define TIMER_MARGIN_MIN	1
> > +
> > +#define PTV			0	/* prescale */
> > +#define GET_WLDR_VAL(secs)	(0xffffffff - ((secs) * (32768/(1<<PTV))) + 1)
> > +
> > +#endif				/* _OMAP_WATCHDOG_H */
> 
> You could just drop these into the C file given how small they are.

Sure, I'll update the patch. But if you look at patch 5/5, I'll need the
structures to define the set_clock() function. Should I create then
under <mach/omap_wdt.h> ??

-- 
balbi
