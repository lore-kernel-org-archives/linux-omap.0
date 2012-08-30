From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v4 2/3] ARM: omap: hwmod: get rid of all
	omap_clk_get_by_name usage
Date: Thu, 30 Aug 2012 01:08:49 +0100
Message-ID: <20120830000849.GD25765@n2100.arm.linux.org.uk>
References: <1346230576-20004-1-git-send-email-rnayak@ti.com> <1346230576-20004-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47712 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272Ab2H3AJD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Aug 2012 20:09:03 -0400
Content-Disposition: inline
In-Reply-To: <1346230576-20004-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: paul@pwsan.com, mturquette@ti.com, mturquette@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Aug 29, 2012 at 02:26:15PM +0530, Rajendra Nayak wrote:
> Moving to Common clk framework for OMAP would mean we no longer use
> internal lookup mechanism like omap_clk_get_by_name().
> get rid of all its usage mostly from hwmod and omap_device
> code.
> 
> Also use IS_ERR_OR_NULL() for error checking.

This is wrong.  IS_ERR() is the only check you should ever use with clk_get().
