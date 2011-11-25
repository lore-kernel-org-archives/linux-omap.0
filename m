From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv6 4/6] regulator: twl: fix twl4030 support for smps
 regulators
Date: Fri, 25 Nov 2011 16:55:09 +0000
Message-ID: <20111125165509.GI5315@opensource.wolfsonmicro.com>
References: <1322238562-19943-1-git-send-email-t-kristo@ti.com>
 <1322238562-19943-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:51208 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750904Ab1KYQzM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Nov 2011 11:55:12 -0500
Content-Disposition: inline
In-Reply-To: <1322238562-19943-5-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, lrg@ti.com, gg@slimlogic.co.uk, rnayak@ti.com, b-cousson@ti.com

On Fri, Nov 25, 2011 at 06:29:20PM +0200, Tero Kristo wrote:

> +	struct twlreg_info *info = rdev_get_drvdata(rdev);
> +	int vsel = DIV_ROUND_UP(min_uV - 600000, 12500);
> +
> +	pr_info("attempting to write: %02x\n", vsel);

There's lots of prints in the driver which are at most dev_dbg().
