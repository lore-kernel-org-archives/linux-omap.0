From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 01/28] OMAP: change get_context_loss_count ret value
 to int
Date: Thu, 6 Oct 2011 17:11:10 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110061710510.4611@utopia.booyaka.com>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com> <1307627810-3768-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39099 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759419Ab1JFXLN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 19:11:13 -0400
In-Reply-To: <1307627810-3768-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, b-cousson@ti.com, khilman@ti.com

On Thu, 9 Jun 2011, Tomi Valkeinen wrote:

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

Acked-by: Paul Walmsley <paul@pwsan.com>> 


- Paul
