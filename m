From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/2] PM: OMAP3 SDRC: fix some SDRAM settings for
	Qimonda parts
Date: Thu, 14 May 2009 13:51:57 -0700
Message-ID: <20090514205157.GS5593@atomide.com>
References: <20090514194728.20623.60039.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49562 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164AbZENUwA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 16:52:00 -0400
Content-Disposition: inline
In-Reply-To: <20090514194728.20623.60039.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, r-woodruff2@ti.com, khilman@deeprootsystems.com

* Paul Walmsley <paul@pwsan.com> [090514 12:52]:
> Hi,
> 
> This series updates some SDRAM parameter settings for the Qimonda parts
> used on some 3430SDP boards.
> 
> Drop the 133.3MHz/66.6MHz rates from the Qimonda SDRAM file - these were only
> used on some early Labrador boards with slower SDRAM parts.  Thanks to
> Richard Woodruff <r-woodruff2@ti.com> for help with this patch.
> 
> Finally some 3430SDP boards are using bootloaders with rounded DPLL3 rates
> (e.g., 166000000 Hz rather than 165941176 Hz); update the Qimonda SDRAM
> parameters.  This resolves -EINVALs during boot-time "Reprogramming SDRC"
> on 3430SDPs with updated bootloaders.  Thanks to Kevin Hilman
> <khilman@deeprootsystems.com> for reporting this issue and testing
> the patch.
> 
> These patches will be queued up into the omap-clock-testing branch at the
> next opportunity.

I've merged these two patches already into your older sdram patches
in the omap3-upstream queue.

Tony
