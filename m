From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/30] sound/omap: omap_mcpdm_remove cannot be __devexit
Date: Sun, 2 Oct 2011 20:24:43 +0100
Message-ID: <20111002192441.GA3693@opensource.wolfsonmicro.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
 <1317566760-25681-2-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:51966 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751620Ab1JBTYp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Oct 2011 15:24:45 -0400
Content-Disposition: inline
In-Reply-To: <1317566760-25681-2-git-send-email-arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>

On Sun, Oct 02, 2011 at 04:45:31PM +0200, Arnd Bergmann wrote:
> omap_mcpdm_remove is used from asoc_mcpdm_probe, which is an
> initcall, and must not be discarded when HOTPLUG is disabled.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>

I've applied this, thanks.  It'd be helpful if you could say if you're
working on Linus' tree rather than -next, this one doesn't actually
apply against -next as the driver has been totally rewritten.
