From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] OMAP: convert boards that use SMSC911x to use
 gpmc-smsc911x
Date: Mon, 18 Apr 2011 14:21:53 +0300
Message-ID: <20110418112153.GK12272@atomide.com>
References: <cover.1302992702.git.mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:21219 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420Ab1DRLVy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Apr 2011 07:21:54 -0400
Content-Disposition: inline
In-Reply-To: <cover.1302992702.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-omap@vger.kernel.org

* Mike Rapoport <mike@compulab.co.il> [110417 01:21]:
> There are several OMAP boards that use SMSC911x Ethernet controller. Convert them all to use gpmc-smsc911x for device registration.
> 
> Mike Rapoport (2):
>   OMAP: gpmc-smsc911x: always set irq flags to IORESOURCE_IRQ_LOWLEVEL
>   OMAP: convert boards that use SMSC911x to use gpmc-smsc911x
> 
>  arch/arm/mach-omap2/board-cm-t35.c          |   84 +++------------------
>  arch/arm/mach-omap2/board-igep0020.c        |   53 ++-----------
>  arch/arm/mach-omap2/board-ldp.c             |   65 ++--------------
>  arch/arm/mach-omap2/board-omap3evm.c        |   71 +++---------------
>  arch/arm/mach-omap2/board-omap3logic.c      |    1 -
>  arch/arm/mach-omap2/board-omap3stalker.c    |   48 ++----------
>  arch/arm/mach-omap2/board-overo.c           |  108 ++++-----------------------
>  arch/arm/mach-omap2/board-zoom-debugboard.c |   56 ++------------
>  arch/arm/mach-omap2/gpmc-smsc911x.c         |    7 +-
>  9 files changed, 70 insertions(+), 423 deletions(-)

Nice job Mike :)

Tony
