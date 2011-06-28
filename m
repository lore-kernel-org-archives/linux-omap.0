From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH 2/7] OMAP: omap_device: Create clkdev entry for hwmod
 main_clk
Date: Tue, 28 Jun 2011 11:21:42 -0700
Message-ID: <20110628182142.GA13018@google.com>
References: <1309192391-12410-1-git-send-email-b-cousson@ti.com>
 <1309192391-12410-3-git-send-email-b-cousson@ti.com>
 <20110627185604.GB6187@google.com>
 <4E09E0EF.9040600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:6880 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932409Ab1F1SVz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Jun 2011 14:21:55 -0400
Content-Disposition: inline
In-Reply-To: <4E09E0EF.9040600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>

On Tue, Jun 28, 2011 at 04:10:55PM +0200, Cousson, Benoit wrote:
> On 6/27/2011 8:56 PM, Todd Poynor wrote:
> >On Mon, Jun 27, 2011 at 06:33:06PM +0200, Benoit Cousson wrote:
> >...
> >>+	r = clk_get_sys(dev_name(&od->pdev.dev), clk_alias);
> >>+	if (!IS_ERR(r)) {
> >>+		pr_warning("omap_device: %s: %s already exist\n",
> >>+			   dev_name(&od->pdev.dev), clk_alias);
> >
> >I believe a clk_put(r) is appropriate here.
> 
> Appropriate I don't know, but useless for sure :-)
> This clk_put is a no-op for every ARM platforms (I found one exception).

I haven't followed the design of common struct clk closely, but it
probably will do ref counting on these, so it's best to keep these
matched up.

> >>+	r = omap_clk_get_by_name(clk_name);
> >>+	if (IS_ERR(r)) {
> >>+		pr_err("omap_device: %s: omap_clk_get_by_name for %s failed\n",
> >>+		       dev_name(&od->pdev.dev), clk_name);
> >>+		return;
> >>+	}
> >>+
> >>+	l = clkdev_alloc(r, clk_alias, dev_name(&od->pdev.dev));
> >>+	if (!l) {
> >>+		pr_err("omap_device: %s: clkdev_alloc for %s failed\n",
> >>+		       dev_name(&od->pdev.dev), clk_alias);
> >
> >And here.
> 
> No, it is not needed in that case because the omap_clk_get_by_name
> is not using the clk_get API.

Ah, didn't check that one, sorry.  That's an unfortunate use of "get"
in the API name IMO.  When common struct clk takes over, this may need
some tweaking.


Todd
