From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: [PATCH 02/07] dma: rework dw_dmac suspend_late()/resume_early()
Date: Fri, 5 Jun 2009 10:18:16 +0200
Message-ID: <20090605101816.6bbe496e@hskinnemoen-d830>
References: <20090605075436.14756.80501.sendpatchset@rx1.opensource.se>
	<20090605075455.14756.13684.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relay.atmel.no ([80.232.32.139]:54428 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757349AbZFEISY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Jun 2009 04:18:24 -0400
In-Reply-To: <20090605075455.14756.13684.sendpatchset@rx1.opensource.se>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org, pavel@ucw.cz, anemo@mba.ocn.ne.jp, gregkh@suse.de, rjw@sisk.pl, stern@rowland.harvard.edu, ben-linux@fluff.org, felipe.balbi@nokia.com, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Magnus Damm wrote:
> +static struct dev_pm_ops dw_dev_pm_ops = {
> +	.suspend_noirq = dw_suspend_noirq,
> +	.resume_noirq = dw_resume_noirq,
> +};

Can this be const?

Haavard
