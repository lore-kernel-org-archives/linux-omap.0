From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 01/26] gpio/omap: remove dependency on
 gpio_bank_count
Date: Wed, 21 Sep 2011 07:41:24 -0700
Message-ID: <20110921144124.GO2937@atomide.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
 <1315918979-26173-2-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:55105 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751282Ab1IUOl1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 10:41:27 -0400
Content-Disposition: inline
In-Reply-To: <1315918979-26173-2-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110913 05:29]:
> From: Charulatha V <charu@ti.com>
> 
> The gpio_bank_count is the count of number of GPIO devices in a SoC. Remove this
> dependency from the driver by using list. Also remove the dependency on array of
> pointers to gpio_bank struct of all GPIO devices.
> 
> Signed-off-by: Charulatha V <charu@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
