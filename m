From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 2/2] mfd: twl: remove pdata->irq_base/_end, no more users
Date: Fri, 11 May 2012 11:40:09 +0200
Message-ID: <20120511094009.GD1214@sortiz-mobl>
References: <1336497542-13629-1-git-send-email-khilman@ti.com>
 <1336497542-13629-3-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10467 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756737Ab2EKJa3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 May 2012 05:30:29 -0400
Content-Disposition: inline
In-Reply-To: <1336497542-13629-3-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org

Hi Kevin,

On Tue, May 08, 2012 at 10:19:02AM -0700, Kevin Hilman wrote:
> After converstion to SPARSE_IRQ, the driver doesn't use the
> pdata->irq_base/irq_end fields anymore.  The last users
> have been cleanup up, and now these fields can be removed.
> 
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
