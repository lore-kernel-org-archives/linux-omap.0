From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/3] OMAP: change get_context_loss_count ret value to int
Date: Thu, 26 May 2011 10:23:33 -0700
Message-ID: <871uzlgyui.fsf@ti.com>
References: <1306428307-1360-1-git-send-email-tomi.valkeinen@ti.com>
	<1306428307-1360-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:44017 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758017Ab1EZRXh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 13:23:37 -0400
Received: by mail-px0-f177.google.com with SMTP id 10so676106pxi.36
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 10:23:36 -0700 (PDT)
In-Reply-To: <1306428307-1360-2-git-send-email-tomi.valkeinen@ti.com> (Tomi
	Valkeinen's message of "Thu, 26 May 2011 19:45:05 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> get_context_loss_count functions return context loss count as u32, and
> zero means an error. However, zero is also returned when context has
> never been lost and could also be returned when the context loss count
> has wrapped and goes to zero.
>
> Change the functions to return an int, with negative value meaning an
> error.
>
> OMAP HSMMC code uses omap_pm_get_dev_context_loss_count(), but as the
> hsmmc code handles the returned value as an int, with negative value
> meaning an error, this patch actually fixes hsmmc code also.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Acked-by: Kevin Hilman <khilman@ti.com>
