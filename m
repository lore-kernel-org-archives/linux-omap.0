From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 06/18] GPIO: OMAP2+: Make non-wakeup GPIO part of pdata
Date: Thu, 16 Jun 2011 09:35:53 -0700
Message-ID: <87y611pwd2.fsf@ti.com>
References: <1308111776-29130-1-git-send-email-tarun.kanti@ti.com>
	<1308111776-29130-5-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:53805 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756157Ab1FPQf5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 12:35:57 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so554262pwj.33
        for <linux-omap@vger.kernel.org>; Thu, 16 Jun 2011 09:35:56 -0700 (PDT)
In-Reply-To: <1308111776-29130-5-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 15 Jun 2011 09:52:53 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> Non-wakeup GPIOs are available only in OMAP2. Avoid cpu_is checks by making
> non_wakeup_gpios as part of pdata.
>
> Signed-off-by: Charulatha V <charu@ti.com>

Nice!  I like this approach.

Kevin
