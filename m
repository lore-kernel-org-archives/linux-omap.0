From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Thu, 31 Mar 2011 01:15:02 +0100
Message-ID: <20110331001502.GB6680@n2100.arm.linux.org.uk>
References: <20110317183048.GW7258@atomide.com> <AANLkTimWbb5DWiiCW821H6pRicbk1fS3PYcnGyUMznvM@mail.gmail.com> <20110318101512.GA15375@n2100.arm.linux.org.uk> <201103301906.42429.arnd@arndb.de> <AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Catalin Marinas <catalin.marinas@arm.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 30, 2011 at 12:21:32PM -0700, Linus Torvalds wrote:
> Look at the dirstat for arch/ in just the current merge window
> (cut-off at 5% just to not get too much):
> 
> [torvalds@i5 linux]$ git diff -C --dirstat=5 --cumulative v2.6.38.. arch
>   14.0% arch/arm/mach-omap2/
>    5.8% arch/arm/plat-mxc/include/mach/
>    6.3% arch/arm/plat-mxc/
>   57.1% arch/arm/

In this merge window, I deleted at least 6000 lines from arch/arm, and
by quoting diffstat percentages, you're using that against the ARM
community.  Why did I bother (that's not a question).
