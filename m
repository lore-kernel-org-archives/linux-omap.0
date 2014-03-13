From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4: Fix definition of IS_PM44XX_ERRATUM
Date: Thu, 13 Mar 2014 13:36:38 -0700
Message-ID: <20140313203637.GF5981@atomide.com>
References: <1394660600-3771-1-git-send-email-nm@ti.com>
 <7hy50ekl8g.fsf@paris.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62370 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755034AbaCMUgn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2014 16:36:43 -0400
Content-Disposition: inline
In-Reply-To: <7hy50ekl8g.fsf@paris.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Santosh <santosh.shilimkar@ti.com>

* Kevin Hilman <khilman@linaro.org> [140313 11:30]:
> Nishanth Menon <nm@ti.com> writes:
> 
> > Just like IS_PM34XX_ERRATUM, IS_PM44XX_ERRATUM is valid only if
> > CONFIG_PM is enabled, else, disabling CONFIG_PM results in build
> > failure complaining about the following:
> > arch/arm/mach-omap2/built-in.o: In function `omap4_boot_secondary':
> > :(.text+0x8a70): undefined reference to `pm44xx_errata'
> >
> > Fixes: c962184 (ARM: OMAP4: PM: add errata support)
> > Reported-by: Tony Lindgren <tony@atomide.com>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> Acked-by: Kevin Hilman <khilman@linaro.org>

Applying this into omap-for-v3.15/fixes thanks.

Tony
