From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 23/25] gpio/omap: enable irq at the end of all configuration in restore
Date: Tue, 06 Sep 2011 17:08:36 -0700
Message-ID: <87hb4puscb.fsf@ti.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-24-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:50704 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751150Ab1IGAIj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Sep 2011 20:08:39 -0400
Received: by mail-yw0-f46.google.com with SMTP id 7so5357282ywf.33
        for <linux-omap@vger.kernel.org>; Tue, 06 Sep 2011 17:08:39 -0700 (PDT)
In-Reply-To: <1314798161-19523-24-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 31 Aug 2011 19:12:39 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Nishanth Menon <nm@ti.com>
>
> Setup the interrupt enable registers only after we have configured the
> required edge and required configurations, not before, to prevent
> spurious events as part of restore routine.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Good catch Nishanth.

Kevin
