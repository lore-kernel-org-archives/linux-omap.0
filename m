From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 0/3] OMAP_LDP support in linux-git tree
Date: Wed, 26 Nov 2008 15:12:42 -0800
Message-ID: <20081126231240.GM11997@atomide.com>
References: <1227253870-4407-1-git-send-email-stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49173 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755570AbYKZXMn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 18:12:43 -0500
Content-Disposition: inline
In-Reply-To: <1227253870-4407-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stanley.Miao" <stanley.miao@windriver.com>
Cc: linux-omap@vger.kernel.org

* Stanley.Miao <stanley.miao@windriver.com> [081120 23:45]:
> Changes from v1:
> 
> 1, change omap_request_gpio() to gpio_request() in gpio.patch.

One request: Since the LDP is in the mainline kernel, can you please
provide whatever applies as patches against the mainline board-ldp.c?

Then if some driver is not yet in mainline, provide that in an extra
patch.

That way I don't have to rewrite your patches for mainline ;)

Tony
