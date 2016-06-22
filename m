From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: Drop legacy board file for n900
Date: Wed, 22 Jun 2016 19:59:59 +0200
Message-ID: <20160622175959.GA21075@amd>
References: <1465987689-14812-1-git-send-email-tony@atomide.com>
 <20160621112944.GV29844@pali> <20160621113215.GP22406@atomide.com>
 <201606221848.41305@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <201606221848.41305@pali>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@baylibre.com>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi!

> > OK I'd like to apply this series by Monday if no issues to have
> > enough time for it in Linux next. Does that sound OK to you?
> > 
> > Regards,
> > 
> > Tony
> 
> Ok, now I looked at it and tested current version from torvalds tree.
> 
> There is still missing fixed support for IR, but that is waiting in 
> media tree queue for next merge window.
> 
> So after IR patches land in torvalds tree, I'm fine with dropping legacy 
> board code for n900 and you can add my Acked-by.
> 
> Sorry that it look so long time, but Nokia N900 is omap3 device with 
> most features & drivers.
> 
> I need to say that Nokia N900 support has good support in mainline 
> kernel, probably the best from all mobile phones. It is almost feature 
> complete, missing parts are: DSP, both cameras, bluetooth and RM
> radio.

...and graphics acceleration and power management. But who needs
accelerated graphics, and power management will be solved. So yes,
N900 is the best phone :-).

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
