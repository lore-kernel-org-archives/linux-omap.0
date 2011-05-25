From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 06/15] OMAP4: GPIO: Save/restore context
Date: Wed, 25 May 2011 14:43:43 -0700
Message-ID: <8739k2sbg0.fsf@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-7-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:56298 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756159Ab1EYVnr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 17:43:47 -0400
Received: by pwi4 with SMTP id 4so81348pwi.25
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 14:43:46 -0700 (PDT)
In-Reply-To: <1306247094-25372-7-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 24 May 2011 19:54:45 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> Modify the omap_gpio_save/restore_context to support OMAP4
> architecture so that the OMAP GPIO driver need not be modified
> when OMAP4 off mode support is available.
>
> Signed-off-by: Charulatha V <charu@ti.com>

I don't think this patch is needed.

PATCH 11/15 removes everything added in this patch when it moves to
using the register offsets.

Kevin
