From: Otto Solares <solca@guug.org>
Subject: Re: [PATCH] ARM: OMAP: Allow I2C bus driver to be compiled as a module
Date: Wed, 18 Feb 2009 17:43:27 -0600
Message-ID: <20090218234327.GM24800@guug.org>
References: <20090217235018.GF11928@atomide.com> <1234948938-6979-1-git-send-email-Aaro.Koskinen@nokia.com> <20090218114525.cb95391f.jhnikula@gmail.com> <20090218234029.GB31436@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from guug.org ([200.9.255.30]:23680 "EHLO guug.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400AbZBRXn3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Feb 2009 18:43:29 -0500
Content-Disposition: inline
In-Reply-To: <20090218234029.GB31436@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Wed, Feb 18, 2009 at 03:40:29PM -0800, Tony Lindgren wrote:
> * Jarkko Nikula <jhnikula@gmail.com> [090218 01:42]:
> > On Wed, 18 Feb 2009 11:22:18 +0200
> > Aaro Koskinen <Aaro.Koskinen@nokia.com> wrote:
> > 
> > > Fixes a linker error when OMAP I2C bus driver is compiled as a module:
> > > 
> > >    ERROR: "i2c_register_board_info" [arch/arm/plat-omap/i2c.ko]
> > > undefined!
> > > 
> > > The I2C utility functions used for board initialization should be
> > > always built-in.
> > > 
> > > Signed-off-by: Aaro Koskinen <Aaro.Koskinen@nokia.com>
> > > ---
> > >  arch/arm/plat-omap/Makefile              |    3 ++-
> > >  arch/arm/plat-omap/include/mach/common.h |    2 +-
> > >  2 files changed, 3 insertions(+), 2 deletions(-)
> > > 
> > Acked-by: Jarkko Nikula  <jarkko.nikula@nokia.com>
> 
> Applying to linux-omap and omap-fixes.

Just curious: what about omap-2.6.28?

-otto
