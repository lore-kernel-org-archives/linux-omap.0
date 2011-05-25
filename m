From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 10/15] OMAP: GPIO: cleanup prepare/resume idle functions
Date: Wed, 25 May 2011 16:00:02 -0700
Message-ID: <878vtuo07h.fsf@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-11-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:37582 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757207Ab1EYXAF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 19:00:05 -0400
Received: by mail-pv0-f180.google.com with SMTP id 21so84317pvc.11
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 16:00:05 -0700 (PDT)
In-Reply-To: <1306247094-25372-11-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 24 May 2011 19:54:49 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> By adding level and edge detection register offsets and then initializing them
> correctly according to OMAP versions during device registrations we can now remove
> lot of revision checks in these functions.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>

Looks good.

Kevin
