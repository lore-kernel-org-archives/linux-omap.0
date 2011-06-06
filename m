From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 01/27] OMAP: change get_context_loss_count ret value to
 int
Date: Mon, 06 Jun 2011 10:28:06 +0300
Message-ID: <1307345286.1910.5.camel@deskari>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
	 <1307095237-14805-2-git-send-email-tomi.valkeinen@ti.com>
	 <871uzaj2oy.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:39202 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753580Ab1FFH2M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 03:28:12 -0400
In-Reply-To: <871uzaj2oy.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, b-cousson@ti.com

On Fri, 2011-06-03 at 09:32 -0700, Kevin Hilman wrote:
> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
> 
> > get_context_loss_count functions return context loss count as u32, and
> > zero means an error. However, zero is also returned when context has
> > never been lost and could also be returned when the context loss count
> > has wrapped and goes to zero.
> >
> > Change the functions to return an int, with negative value meaning an
> > error.
> >
> > OMAP HSMMC code uses omap_pm_get_dev_context_loss_count(), but as the
> > hsmmc code handles the returned value as an int, with negative value
> > meaning an error, this patch actually fixes hsmmc code also.
> >
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Acked-by: Kevin Hilman <khilman@ti.com>
> 
> This one should be separated out into a fix for v3.0-rc, and queued by
> Paul (also Cc'd to linux-arm-kernel.)

Yup, I added it here for completeness to get a working patch series. The
same patch has also been sent separately.

 Tomi


