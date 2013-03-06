From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/9] ARM: omap1: add back missing includes
Date: Wed, 6 Mar 2013 11:23:30 +0000
Message-ID: <201303061123.30789.arnd@arndb.de>
References: <1362521809-22989-1-git-send-email-arnd@arndb.de> <201303052227.33430.arnd@arndb.de> <20130306005951.GH11806@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:58770 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757167Ab3CFLXk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Mar 2013 06:23:40 -0500
In-Reply-To: <20130306005951.GH11806@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, arm@kernel.org, linux-omap@vger.kernel.org

On Wednesday 06 March 2013, Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [130305 14:31]:
> > On Tuesday 05 March 2013, Arnd Bergmann wrote:
> > > The recent reorganization of OMAP header files caused a couple of
> > > files that used to be implicitly included now missing from OMAP1.
> > > This adds explicit inclusions of mach/irqs.h and mach/hardware.h
> > > in all files that need them for an OMAP1 allyesconfig build.
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Tony Lindgren <tony@atomide.com>
> > > Cc: linux-omap@vger.kernel.org
> > > ---
> > >  arch/arm/mach-omap1/board-fsample.c  | 1 +
> > >  arch/arm/mach-omap1/board-h2.c       | 1 +
> > >  arch/arm/mach-omap1/board-perseus2.c | 1 +
> > >  arch/arm/mach-omap1/board-sx1.c      | 1 +
> > >  drivers/video/omap/lcd_ams_delta.c   | 1 +
> > >  drivers/video/omap/lcd_osk.c         | 1 +
> > >  6 files changed, 6 insertions(+)
> > 
> > I saw that Tony has already addressed the latter two changes, but
> > did not see a fix for the four board files.
> 
> Hmm I wonder why I have not seen the board-*.c related ones?
> 
> Anyways thanks for fixing those:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Actually I cannot reproduce them myself now, I think I'll just drop
the patch for now, but will remember your Ack if the problem comes
back. The patch would be needed if we decide to use SPARSE_IRQ on
OMAP1.

	Arnd
