From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap1: fix build when !CONFIG_OMAP_32K_TIMER
Date: Thu, 13 Feb 2014 14:52:27 -0800
Message-ID: <20140213225226.GE28216@atomide.com>
References: <1389636237-2998-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:38704 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751778AbaBMWwj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Feb 2014 17:52:39 -0500
Content-Disposition: inline
In-Reply-To: <1389636237-2998-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [140113 10:06]:
> If CONFIG_OMAP_32K_TIMER isn't enabled, we will
> try to use enable_dyn_sleep which wasn't defined
> anywhere.
> 
> In order to fix the problem, we always define
> enable_dyn_sleep as 0 when !CONFIG_OMAP_32K_TIMER.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Thanks applying into omap-for-v3.14/fixes.

Tony
