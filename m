From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 11/26] gpio/omap: cleanup set_gpio_triggering
 function
Date: Wed, 21 Sep 2011 07:55:51 -0700
Message-ID: <20110921145551.GW2937@atomide.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
 <1315918979-26173-12-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:14123 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751726Ab1IUOzy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 10:55:54 -0400
Content-Disposition: inline
In-Reply-To: <1315918979-26173-12-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110913 05:29]:
> Getting rid of ifdefs within the function by adding register offset intctrl
> and associating OMAPXXXX_GPIO_INT_CONTROL in respective SoC specific files.
> Also, use wkup_status register consistently instead of referring to wakeup
> clear and wakeup set register offsets.
> 
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
