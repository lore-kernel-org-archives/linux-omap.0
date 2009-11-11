From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] omap3: cm-t35 updates
Date: Wed, 11 Nov 2009 12:04:49 -0800
Message-ID: <20091111200449.GM24837@atomide.com>
References: <cover.1257937910.git.mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60835 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbZKKUEq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 15:04:46 -0500
Content-Disposition: inline
In-Reply-To: <cover.1257937910.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-omap@vger.kernel.org

* Mike Rapoport <mike@compulab.co.il> [091111 03:25]:
> Here are several small updates for CM-T35 board.
> 
> Changes since commit e7e7a613eded2732b68496f69ff8fc34f16e1dd0:
>   Tony Lindgren (1):
>           Linux-omap rebuilt: Processor support for new omaps merged
> 
> Mike Rapoport (3):
>   omap3: cm-t35: update led polarity
>   omap3: cm-t35: use matrix_keyboard
>   omap3: cm-t35: add support for baseboard ehternet
> 
>  arch/arm/mach-omap2/board-cm-t35.c |   71 ++++++++++++++++++++++++++----------

Merging all three into your earlier patch in omap for-next branch.

Tony
