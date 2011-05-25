From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 14/15] OMAP: GPIO: Use memset for omap_gpio_reg_offs
Date: Wed, 25 May 2011 16:30:49 -0700
Message-ID: <877h9el5na.fsf@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-15-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:59320 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753185Ab1EYXaw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 19:30:52 -0400
Received: by mail-pw0-f42.google.com with SMTP id 3so104599pwj.29
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 16:30:51 -0700 (PDT)
In-Reply-To: <1306247094-25372-15-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 24 May 2011 19:54:53 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> Use memset to fill omap_gpio_reg_offs structure with 0xFFFF
> instead of filling each and every undefined register offset
> separately with USHRT_MAX in a given OMAP SoC. This would ease
> while adding new register offsets in the future SoCs.
>
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

This can be dropped in favor of using zero to indicate a non-existant
register offset.  Only the revision register needs a special case of
using USHRT_MAX since zero can be a valid offset for the revision
register.

Kevin
