From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 07/29] mfd: omap-usb: use clk_prepare_enable and
 clk_disable_unprepare
Date: Mon, 2 Jul 2012 13:18:50 +0200
Message-ID: <20120702111850.GC22065@sortiz-mobl>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
 <1339678038-23082-8-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10551 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869Ab2GBLHc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Jul 2012 07:07:32 -0400
Content-Disposition: inline
In-Reply-To: <1339678038-23082-8-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: paul@pwsan.com, mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Rajendra,

On Thu, Jun 14, 2012 at 06:16:56PM +0530, Rajendra Nayak wrote:
> As we move to Common clk framework use clk_prepare_enable()
> instead of clk_enable() and similarly clk_disable_unprepare()
> instead of clk_disable()
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  drivers/mfd/omap-usb-host.c |   28 ++++++++++++++--------------
>  1 files changed, 14 insertions(+), 14 deletions(-)
Patch applied, many thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
