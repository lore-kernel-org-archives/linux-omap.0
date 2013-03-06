From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/9] ARM: omap1: add back missing includes
Date: Tue, 5 Mar 2013 16:59:52 -0800
Message-ID: <20130306005951.GH11806@atomide.com>
References: <1362521809-22989-1-git-send-email-arnd@arndb.de>
 <1362521809-22989-6-git-send-email-arnd@arndb.de>
 <201303052227.33430.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201303052227.33430.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, arm@kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [130305 14:31]:
> On Tuesday 05 March 2013, Arnd Bergmann wrote:
> > The recent reorganization of OMAP header files caused a couple of
> > files that used to be implicitly included now missing from OMAP1.
> > This adds explicit inclusions of mach/irqs.h and mach/hardware.h
> > in all files that need them for an OMAP1 allyesconfig build.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: linux-omap@vger.kernel.org
> > ---
> >  arch/arm/mach-omap1/board-fsample.c  | 1 +
> >  arch/arm/mach-omap1/board-h2.c       | 1 +
> >  arch/arm/mach-omap1/board-perseus2.c | 1 +
> >  arch/arm/mach-omap1/board-sx1.c      | 1 +
> >  drivers/video/omap/lcd_ams_delta.c   | 1 +
> >  drivers/video/omap/lcd_osk.c         | 1 +
> >  6 files changed, 6 insertions(+)
> 
> I saw that Tony has already addressed the latter two changes, but
> did not see a fix for the four board files.

Hmm I wonder why I have not seen the board-*.c related ones?

Anyways thanks for fixing those:

Acked-by: Tony Lindgren <tony@atomide.com>
