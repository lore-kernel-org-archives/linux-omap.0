From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v16 00/12] OMAP: dmtimer: adaptation to platform_driver
Date: Wed, 21 Sep 2011 17:59:30 -0700
Message-ID: <20110922005930.GN2937@atomide.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:35380 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab1IVA7f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 20:59:35 -0400
Content-Disposition: inline
In-Reply-To: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

Hi Tarun,

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110920 03:57]:
> Adaptation of dmtimer code to platform driver using omap_device and
> omap_hwmod abstraction. It also include pm-runtime and off-mode support.

I've applied these into dmtimer branch with some changes to simplify
things further. I've also merged it into linux-omap master branch
for further testing.

I'll reply to your patches with the changes I've done. Care give the
dmtimer branch a try and see if I've missed something?

Regards,

Tony
