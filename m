From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: update omap1 and omap2plus defconfigs
Date: Wed, 8 Feb 2012 11:51:42 -0800
Message-ID: <20120208195141.GE1426@atomide.com>
References: <20120208053556.GB1426@atomide.com>
 <1328696173-17226-1-git-send-email-grinberg@compulab.co.il>
 <20120208101958.GT1275@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58439 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757210Ab2BHTvu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 14:51:50 -0500
Content-Disposition: inline
In-Reply-To: <20120208101958.GT1275@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 01:49]:
> On Wed, Feb 08, 2012 at 12:16:13PM +0200, Igor Grinberg wrote:
> > This patch updates omapX_defconfig to 3.3-rc1 and enables
> > the CONFIG_DEBUG_SECTION_MISMATCH.
> 
> You shouldn't enable this in the kernel supplied defconfigs.
> 
> > The update is done by:
> > 1) make mrproper && make omapX_defconfig
> > 2) Enable the CONFIG_DEBUG_SECTION_MISMATCH
> > 3) make savedefconfig
> > 4) cp defconfig arch/arm/configs/omapX_defconfig
> > 
> > Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> > ---
> > After updating omap1_defconfig,
> > there are several section mismatch warnings seen.
> > Hopefully, I will have time to fix those tomorrow
> > (unless someone will be kind enough to fix them before me).
> > The mismatches are:
> 
> The correct way is to build with:
> 
> make ... CONFIG_DEBUG_SECTION_MISMATCH=y
> 
> or set it in your private configuration.

OK that's the way to go then. Having the unoptimizer compiler flag
-fno-inline-functions-called-once is not nice in defconfigs.. And
we should already get the warning to enable section mismatch
warnings anyways.

Regrads,

Tony
