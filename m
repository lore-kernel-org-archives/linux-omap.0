From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv6 4/6] regulator: twl: fix twl4030 support for smps
 regulators
Date: Fri, 25 Nov 2011 19:08:48 +0200
Message-ID: <1322240928.13828.0.camel@sokoban>
References: <1322238562-19943-1-git-send-email-t-kristo@ti.com>
	 <1322238562-19943-5-git-send-email-t-kristo@ti.com>
	 <20111125165509.GI5315@opensource.wolfsonmicro.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54548 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129Ab1KYRIy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Nov 2011 12:08:54 -0500
In-Reply-To: <20111125165509.GI5315@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, lrg@ti.com, gg@slimlogic.co.uk, rnayak@ti.com, b-cousson@ti.com

On Fri, 2011-11-25 at 16:55 +0000, Mark Brown wrote:
> On Fri, Nov 25, 2011 at 06:29:20PM +0200, Tero Kristo wrote:
> 
> > +	struct twlreg_info *info = rdev_get_drvdata(rdev);
> > +	int vsel = DIV_ROUND_UP(min_uV - 600000, 12500);
> > +
> > +	pr_info("attempting to write: %02x\n", vsel);
> 
> There's lots of prints in the driver which are at most dev_dbg().

Oh yea, sorry. I accidentally left my debug prints in there, will be
removed in next version.

-Tero


