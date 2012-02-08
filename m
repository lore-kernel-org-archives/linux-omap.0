From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: OMAP: update omap1 and omap2plus defconfigs
Date: Wed, 8 Feb 2012 10:19:58 +0000
Message-ID: <20120208101958.GT1275@n2100.arm.linux.org.uk>
References: <20120208053556.GB1426@atomide.com> <1328696173-17226-1-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53302 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab2BHKUO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 05:20:14 -0500
Content-Disposition: inline
In-Reply-To: <1328696173-17226-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Feb 08, 2012 at 12:16:13PM +0200, Igor Grinberg wrote:
> This patch updates omapX_defconfig to 3.3-rc1 and enables
> the CONFIG_DEBUG_SECTION_MISMATCH.

You shouldn't enable this in the kernel supplied defconfigs.

> The update is done by:
> 1) make mrproper && make omapX_defconfig
> 2) Enable the CONFIG_DEBUG_SECTION_MISMATCH
> 3) make savedefconfig
> 4) cp defconfig arch/arm/configs/omapX_defconfig
> 
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
> After updating omap1_defconfig,
> there are several section mismatch warnings seen.
> Hopefully, I will have time to fix those tomorrow
> (unless someone will be kind enough to fix them before me).
> The mismatches are:

The correct way is to build with:

make ... CONFIG_DEBUG_SECTION_MISMATCH=y

or set it in your private configuration.
