From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 16/26] gpio/omap: fix bankwidth for OMAP7xx MPUIO
Date: Wed, 21 Sep 2011 08:05:47 -0700
Message-ID: <20110921150547.GB2937@atomide.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
 <1315918979-26173-17-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:24923 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752005Ab1IUPFt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 11:05:49 -0400
Content-Disposition: inline
In-Reply-To: <1315918979-26173-17-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110913 05:30]:
> From: Charulatha V <charu@ti.com>
> 
> In all OMAP1 SoCs, the MPUIO bank width is 16 bits. But, in OMAP7xx,
> it is wrongly initialised to 32. Fix this.
> 
> Signed-off-by: Charulatha V <charu@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
