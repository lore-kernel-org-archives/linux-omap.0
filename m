From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v16 12/12] OMAP: dmtimer: get rid of timer_ip_version
 field
Date: Wed, 21 Sep 2011 18:00:22 -0700
Message-ID: <20110922010022.GQ2937@atomide.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
 <1316518227-28116-13-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:16565 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750874Ab1IVBAY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 21:00:24 -0400
Content-Disposition: inline
In-Reply-To: <1316518227-28116-13-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110920 03:57]:
> We do not need this field in dmtimer_platform_data{} anymore.
> Instead, read "tidr" register to identify the ip version now.

Let's wait a bit on this one as Benoit had some comments regarding
the use of tidr.

Regards,

Tony
