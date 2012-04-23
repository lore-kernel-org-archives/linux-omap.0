From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 3/4] ARM: OMAP2+: dmtimer: cleanup iclk usage
Date: Mon, 23 Apr 2012 10:48:44 -0700
Message-ID: <87obqijq4j.fsf@ti.com>
References: <1334925563-20768-1-git-send-email-tarun.kanti@ti.com>
	<1334925563-20768-4-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:47676 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752248Ab2DWRsj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Apr 2012 13:48:39 -0400
Received: by dadz14 with SMTP id z14so15591546dad.3
        for <linux-omap@vger.kernel.org>; Mon, 23 Apr 2012 10:48:38 -0700 (PDT)
In-Reply-To: <1334925563-20768-4-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Fri, 20 Apr 2012 18:09:22 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> We do not use iclk anywhere in the dmtimer driver and so removing it.
> Hence removing the timer iclk entries from OMAP4 clkdev table as well.

What about the OMAP2/3 clkdev tables?  Can't those be removed as well?

Comment applies to PATCH 4/4 also.

Kevin
