From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [RFC/PATCH] ARM: OMAP: Fix build for OMAP3 only builds
Date: Thu, 27 Oct 2011 11:02:12 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930328C7C406@dbde02.ent.ti.com>
References: <1318421036-1498-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60683 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab1J0Fca convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Oct 2011 01:32:30 -0400
In-Reply-To: <1318421036-1498-1-git-send-email-weber@corscience.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Weber <weber@corscience.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>

On Wed, Oct 12, 2011 at 17:33:56, Thomas Weber wrote:
> When building for OMAP3 only I get the
> following errors:
> 
> In function `omap2420_init_early':
> undefined reference to `omap2_set_globals_242x'
> undefined reference to `omap2xxx_voltagedomains_init'
> undefined reference to `omap242x_powerdomains_init'
> undefined reference to `omap242x_clockdomains_init'
> undefined reference to `omap2420_hwmod_init'
> 
> In function `omap2430_init_early':
> undefined reference to `omap2_set_globals_243x'
> undefined reference to `omap2xxx_voltagedomains_init'
> undefined reference to `omap243x_powerdomains_init'
> undefined reference to `omap243x_clockdomains_init'
> undefined reference to `omap2430_hwmod_init'
> 
> In function `omap4430_init_early':
> undefined reference to `omap2_set_globals_443x'
> undefined reference to `omap44xx_voltagedomains_init'
> undefined reference to `omap44xx_powerdomains_init'
> undefined reference to `omap44xx_clockdomains_init'
> undefined reference to `omap44xx_hwmod_init'
> undefined reference to `omap4xxx_clk_init'
> 
> With this patch the omapXXXX_init_early will be compiled only
> when their SOC's are selected.
> 
> Signed-off-by: Thomas Weber <weber@corscience.de>

I was facing the same problem and this patch helped
me get rid of it.

Tested-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar

