From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix: ZOOM: QUART: Request reset GPIO
Date: Tue, 31 May 2011 06:11:20 -0700
Message-ID: <20110531131120.GN11352@atomide.com>
References: <1305902134-22760-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:62070 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751064Ab1EaNLX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 May 2011 09:11:23 -0400
Content-Disposition: inline
In-Reply-To: <1305902134-22760-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110520 07:31]:
> From: Charulatha V <charu@ti.com>
> 
> Reset GPIO (OMAP_GPIO_152) for QUART in zoom2/zoom3 debug-board is
> not requested at all. This would lead to problems if this GPIO is
> wrongly requested. Hence request OMAP GPIO 152 for QUART RESET but
> do not apply a reset pulse as it would reset QUART and
> disturb the QUART settings.

Thanks adding to devel-board.

Tony
