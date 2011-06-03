From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 01/27] OMAP: change get_context_loss_count ret value to int
Date: Fri, 03 Jun 2011 09:32:29 -0700
Message-ID: <871uzaj2oy.fsf@ti.com>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
	<1307095237-14805-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:36389 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751052Ab1FCQcc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 12:32:32 -0400
In-Reply-To: <1307095237-14805-2-git-send-email-tomi.valkeinen@ti.com> (Tomi
	Valkeinen's message of "Fri, 3 Jun 2011 13:00:11 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, b-cousson@ti.com, paul@pwsan.com

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
> Acked-by: Kevin Hilman <khilman@ti.com>

This one should be separated out into a fix for v3.0-rc, and queued by
Paul (also Cc'd to linux-arm-kernel.)

Kevin
