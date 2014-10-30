From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] ARM: OMAP2+: gpmc: configuration enhancements
Date: Thu, 30 Oct 2014 08:10:37 -0700
Message-ID: <20141030151036.GE2560@atomide.com>
References: <1413895309-9152-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51227 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760395AbaJ3PLv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2014 11:11:51 -0400
Content-Disposition: inline
In-Reply-To: <1413895309-9152-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: pekon@pek-sem.com, javier@dowhile0.org, linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [141021 05:43]:
> Hi Tony,
> 
> These patches address GPMC configuration issues and are for v3.19.
> Patches based on v3.18-rc1.
> 
> - Make sure to print a user visible error if a requested GPMC timing
> configuration can't be met.
> 
> - Don't create GPMC child device if a GPMC timing could not be set.
> 
> - Always enable address lines A26-A11 for non-NAND devices.
> 
> - Perform GPMC configuration as per recommended procedure i.e.
> keep Chip Select disabled while changing GPMC configuration.
> 
> Tested on dra7-evm, am437x-gp-evm and beagleboard.

For all these, please feel free to add:

Acked-by: Tony Lindgren <tony@atomide.com>
