From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Allow I2C bus driver to be compiled as a
	module
Date: Wed, 18 Feb 2009 15:40:29 -0800
Message-ID: <20090218234029.GB31436@atomide.com>
References: <20090217235018.GF11928@atomide.com> <1234948938-6979-1-git-send-email-Aaro.Koskinen@nokia.com> <20090218114525.cb95391f.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64231 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925AbZBRXke (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Feb 2009 18:40:34 -0500
Content-Disposition: inline
In-Reply-To: <20090218114525.cb95391f.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Aaro Koskinen <Aaro.Koskinen@nokia.com>, linux-omap@vger.kernel.org, jarkko.nikula@nokia.com, ext-atal.shargorodsky@nokia.com

* Jarkko Nikula <jhnikula@gmail.com> [090218 01:42]:
> On Wed, 18 Feb 2009 11:22:18 +0200
> Aaro Koskinen <Aaro.Koskinen@nokia.com> wrote:
> 
> > Fixes a linker error when OMAP I2C bus driver is compiled as a module:
> > 
> >    ERROR: "i2c_register_board_info" [arch/arm/plat-omap/i2c.ko]
> > undefined!
> > 
> > The I2C utility functions used for board initialization should be
> > always built-in.
> > 
> > Signed-off-by: Aaro Koskinen <Aaro.Koskinen@nokia.com>
> > ---
> >  arch/arm/plat-omap/Makefile              |    3 ++-
> >  arch/arm/plat-omap/include/mach/common.h |    2 +-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> Acked-by: Jarkko Nikula  <jarkko.nikula@nokia.com>

Applying to linux-omap and omap-fixes.

Tony
