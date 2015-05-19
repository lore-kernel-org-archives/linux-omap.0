From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/5] PM / Wakeirq: Add automated device wake IRQ handling
Date: Tue, 19 May 2015 16:27:56 -0700
Message-ID: <20150519232756.GS10274@atomide.com>
References: <1431560196-5722-1-git-send-email-tony@atomide.com>
 <2925475.Mzl99EToV0@vostro.rjw.lan>
 <alpine.DEB.2.11.1505200039540.4225@nanos>
 <1757867.ugVzJ2yl3G@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1757867.ugVzJ2yl3G@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Felipe Balbi <balbi@ti.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Rafael J. Wysocki <rjw@rjwysocki.net> [150519 16:07]:
> On Wednesday, May 20, 2015 12:41:06 AM Thomas Gleixner wrote:
> > On Wed, 20 May 2015, Rafael J. Wysocki wrote:
> > > This one looks really good. :-)
> > > 
> > > If it doesn't depend on anything, I can apply it right away, so please let me
> > > know.

Sure works for me, it just has a dependency to patch #1 in this
series ("[PATCH 1/5] PM / Runtime: Update last_busy in rpm_resume").

> > Can you pretty please trim your replies? It's a PITA to scroll through
> > several pages of quoted patch just to find your signature as the extra
> > content.
> 
> Sorry about that.

Sounds like Thomas might be OK with the patch too then :)

Regards,

Tony 
