From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 21/25] gpio/omap: remove omap_gpio_save_context overhead
Date: Tue, 06 Sep 2011 16:57:37 -0700
Message-ID: <87obyxw7f2.fsf@ti.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-22-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:47107 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755404Ab1IFX5l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Sep 2011 19:57:41 -0400
Received: by gxk1 with SMTP id 1so5348124gxk.24
        for <linux-omap@vger.kernel.org>; Tue, 06 Sep 2011 16:57:40 -0700 (PDT)
In-Reply-To: <1314798161-19523-22-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 31 Aug 2011 19:12:37 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> Context is now saved dynamically in respective functions whenever and
> whichever registers are modified. This avoid overhead of saving all
> registers context in the runtime callback.

Nice!

s/runtime callback/runtime suspend callback/

> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Kevin
