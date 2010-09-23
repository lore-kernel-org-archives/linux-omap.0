From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] omap: zoom: Move new code introduced by ASoC m-c
 to board-zoom-peripherals
Date: Thu, 23 Sep 2010 17:15:24 +0100
Message-ID: <20100923161524.GB32112@rakim.wolfsonmicro.main>
References: <1285258314-23721-1-git-send-email-jhnikula@gmail.com>
 <1285258314-23721-2-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:36005 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754776Ab0IWQP0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Sep 2010 12:15:26 -0400
Content-Disposition: inline
In-Reply-To: <1285258314-23721-2-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, linux-omap@vger.kernel.org, Vikram Pandita <vikram.pandita@ti.com>, "Lopez Cruz, Misael" <x0052729@ti.com>, Jorge Eduardo Candelaria <jorge.candelaria@ti.com>, Tony Lindgren <tony@atomide.com>

On Thu, Sep 23, 2010 at 07:11:54PM +0300, Jarkko Nikula wrote:
> ASoC Multi-Component Support moves some code from sound/soc/omap/zoom2.c into
> arch/arm/mach-omap2/board-zoom2.c. However, that code should go to
> board-zoom-peripherals.c instead as there is common code and registration
> for zoom boards.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
