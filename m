From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch v3 3/3] arm: omap4: support pmu
Date: Thu, 3 Mar 2011 10:20:49 -0800
Message-ID: <20110303182049.GN20560@atomide.com>
References: <1299149633-699-1-git-send-email-tom.leiming@gmail.com>
 <1299149633-699-4-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54177 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758598Ab1CCSVD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 13:21:03 -0500
Content-Disposition: inline
In-Reply-To: <1299149633-699-4-git-send-email-tom.leiming@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tom.leiming@gmail.com
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, will.deacon@arm.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Woodruff Richard <r-woodruff2@ti.com>, linux-omap@vger.kernel.org

* tom.leiming@gmail.com <tom.leiming@gmail.com> [110303 02:52]:
> From: Ming Lei <tom.leiming@gmail.com>
> 
> This patch supports pmu irq routed from CTI, so
> make pmu/perf working on OMAP4.
> 
> The idea is from Woodruff Richard in the disscussion
> about "Oprofile on Pandaboard / Omap4" on pandaboard@googlegroups.com.
> 
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Woodruff Richard <r-woodruff2@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>

You'll probably want to queue this along with the to other
patches via the Russell, so:

Acked-by: Tony Lindgren <tony@atomide.com>
