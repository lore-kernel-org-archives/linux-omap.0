From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 1/2] CLK: Introduce virtual clock registration
Date: Wed, 20 Aug 2008 13:18:12 +0300
Message-ID: <20080820101812.GK23346@gandalf.research.nokia.com>
References: <1219225912-347-1-git-send-email-Hiroshi.DOYU@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18423 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbYHTKRU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Aug 2008 06:17:20 -0400
Content-Disposition: inline
In-Reply-To: <1219225912-347-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, eduardo.valentin@indt.org.br

On Wed, Aug 20, 2008 at 12:51:51PM +0300, Hiroshi DOYU wrote:
> +int vclk_enable(struct clk *clk)
> +{
> +	int i;
> +	struct vclk *vc = container_of(clk, struct vclk, clk);
> +
> +	for (i = 0; i < vc->n_childs; i++)
> +		clk_enable(vc->childs[i]);

missing an error check for clk_enable()

-- 
balbi
