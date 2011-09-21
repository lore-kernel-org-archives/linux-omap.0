From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 10/26] gpio/omap: remove hardcoded offsets in
 context save/restore
Date: Wed, 21 Sep 2011 07:55:32 -0700
Message-ID: <20110921145532.GV2937@atomide.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
 <1315918979-26173-11-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:60257 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751699Ab1IUOze (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 10:55:34 -0400
Content-Disposition: inline
In-Reply-To: <1315918979-26173-11-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110913 05:29]:
> It is not required to use hard-coded offsets any more in context save and
> restore functions and instead use the generic offsets which have been correctly
> initialized during device registration.
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
