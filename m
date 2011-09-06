From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 20/25] gpio/omap: skip operations in runtime callbacks
Date: Tue, 06 Sep 2011 16:54:53 -0700
Message-ID: <87ty8pw7jm.fsf@ti.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-21-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:45185 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755421Ab1IFXy5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Sep 2011 19:54:57 -0400
Received: by mail-yw0-f52.google.com with SMTP id 29so4371310yws.11
        for <linux-omap@vger.kernel.org>; Tue, 06 Sep 2011 16:54:56 -0700 (PDT)
In-Reply-To: <1314798161-19523-21-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 31 Aug 2011 19:12:36 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> Most operations within runtime callbacks should be skipped when
> *_runtime_get_sync() and *_runtime_put_sync() are called in probe(),
> *_gpio_request() and *_gpio_free(). 

Why?  

(again, I know the answer, but should be described in the changelog for
folks not familiar with this driver, or when we come back to this in 3
months and have forgotten why.

> We just need clock enable/disable.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Kevin
