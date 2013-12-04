From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] ARM: OMAP2+: Remove remaining unused legacy code
Date: Wed, 4 Dec 2013 09:53:10 -0800
Message-ID: <20131204175310.GR26766@atomide.com>
References: <1385752697-13700-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:42186 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755182Ab3LDRxO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Dec 2013 12:53:14 -0500
Content-Disposition: inline
In-Reply-To: <1385752697-13700-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Javier Martinez Canillas <javier.martinez@collabora.co.uk> [131129 11:20]:
> Now that OMAP2+ board files are scheduled for removal for v3.14
> there is unused code that was only used by legacy platform code
> and can be removed.
> 
> This patch-set depends on the series:
> 
> [PATCH 00/12] Drop omap3 board files and make mach-omap2 boot in DT only mode
> 
> and is composed of the following patches:
> 
> [PATCH 1/3] ARM: OMAP2+: Remove legacy smsc911x and smc91x GPMC
> [PATCH 2/3] ARM: OMAP2+: Remove unnecesary include in GPMC driver
> [PATCH 3/3] ARM: OMAP2+: Remove legacy board-flash.c

Thanks looks good to me. I'll wait for -rc3 to get tagged and then
apply all the pending mach-omap2 device tree conversion patches
against it including these.

Regards,

Tony
