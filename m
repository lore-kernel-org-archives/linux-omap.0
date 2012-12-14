From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH v3 1/6] watchdog: omap_wdt: convert to new
 watchdog core
Date: Thu, 13 Dec 2012 17:32:57 -0800
Message-ID: <20121214013256.GM4989@atomide.com>
References: <1352746025-1669-1-git-send-email-aaro.koskinen@iki.fi>
 <1352746025-1669-2-git-send-email-aaro.koskinen@iki.fi>
 <20121112224703.GT6801@atomide.com>
 <20121214012336.GA402@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121214012336.GA402@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, wim@iguana.be, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@debian.org> [121213 17:26]:
> On Mon, Nov 12, 2012 at 02:47:03PM -0800, Tony Lindgren wrote:
> > * Aaro Koskinen <aaro.koskinen@iki.fi> [121112 10:49]:
> > > Convert omap_wdt to new watchdog core. On OMAP boards, there are usually
> > > multiple watchdogs. Since the new watchdog core supports multiple
> > > watchdogs, all watchdog drivers used on OMAP should be converted.
> > > 
> > > The legacy watchdog device node is still created, so this should not
> > > break existing users.
> > > 
> > > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > > Tested-by: Jarkko Nikula <jarkko.nikula@jollamobile.com>
> > > Tested-by: Lokesh Vutla <lokeshvutla@ti.com>
> > > Cc: Wim Van Sebroeck <wim@iguana.be>
> > 
> > Wim, looks like these will cause merge conflicts with what we
> > have already queued in omap-for-v3.8/cleanup-prcm as patch
> > "watchdog: OMAP: use standard GETBOOTSTATUS interface; use
> > platform_data fn ptr" along with other ARM multiplatform
> > related clean up. If these look ackable to you, I can queue
> > these that's OK to you.
> 
> What's the status of this patchset? If I'm not mistaken it is
> neither included in linux-omap, nor in linux-watchdog-next.

It should be all linux-watchdog-next with what got merged into
the mainline kernel today. No more arch/arm/*omap*/ dependencies
AFAIK.

Regards,

Tony
