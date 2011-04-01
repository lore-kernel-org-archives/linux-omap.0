From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Fri, 01 Apr 2011 10:32:37 +0300
Message-ID: <1301643157.3393.17.camel@deskari>
References: <201103301906.42429.arnd@arndb.de>
	 <alpine.LFD.2.00.1103311359320.22418@localhost6.localdomain6>
	 <87d3l7jqpr.fsf@ti.com>  <201103311723.02301.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201103311723.02301.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kevin Hilman <khilman@ti.com>, Thomas Gleixner <tglx@linutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Ingo Molnar <mingo@elte.hu>, Nicolas Pitre <nico@fluxnic.net>, david@lang.hm, Linus Torvalds <torvalds@linux-foundation.org>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, lkml <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 2011-03-31 at 17:23 +0200, Arnd Bergmann wrote:

> * The DSS display drivers introduce new infrastructure include new bus
>   types that have the complexity to make them completely generic, but
>   in practice can only work on OMAP, and are clearly not written with
>   cross-vendor abstractions in mind.

If you mean the panel drivers, then I disagree. They are currently OMAP
specific, but they are designed so that making them generic shouldn't be
too difficult. It's been my aim for a long time already to make the
panel drivers generic, but I've never had time and it's never been quite
clear to me what would be the best way to do that.

The core DSS driver is OMAP specific, and while the DSS IP could in
theory be used in some other platform, that is not currently the case
and I wouldn't want to needlessly start abstracting things for just the
sake of abstracting.

 Tomi
