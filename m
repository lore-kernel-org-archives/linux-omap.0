From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2.6.38] omap: McBSP: Fix potential memory leak in
 omap_mcbsp_remove
Date: Tue, 16 Nov 2010 13:31:15 -0800
Message-ID: <20101116213114.GL9264@atomide.com>
References: <1288776263-6600-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:41013 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932348Ab0KPVbY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 16:31:24 -0500
Content-Disposition: inline
In-Reply-To: <1288776263-6600-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org

* Jarkko Nikula <jhnikula@gmail.com> [101103 02:15]:
> Function omap_mcbsp_probe allocates struct omap_mcbsp *mcbsp but it is not
> freed in omap_mcbsp_remove. Fix this, remove unneeded structure cleanups
> and clk_disable calls since they are not needed here.
> 
> This is not problem currently but becomes if the mcbsp driver is ever
> modularized.

Queuing this for 2.6.38 merge window.

Tony
