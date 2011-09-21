From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 08/26] gpio/omap: further cleanup using wkup_en
 register
Date: Wed, 21 Sep 2011 07:49:53 -0700
Message-ID: <20110921144953.GT2937@atomide.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
 <1315918979-26173-9-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:63921 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751567Ab1IUOtz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 10:49:55 -0400
Content-Disposition: inline
In-Reply-To: <1315918979-26173-9-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110913 05:29]:
> Wakeup enable register offset initialized according to OMAP versions
> during device registration. Use this to avoid version checks.
> Starting with OMAP4, legacy registers should not be used in combination
> with the updated regsiters. Use wkup_en register consistently for
> all SoCs wherever applicable.
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
