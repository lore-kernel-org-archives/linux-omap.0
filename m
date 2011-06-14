From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 01/28] OMAP: change get_context_loss_count ret value
 to int
Date: Tue, 14 Jun 2011 01:13:53 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1106140111540.20723@utopia.booyaka.com>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>  <1307627810-3768-2-git-send-email-tomi.valkeinen@ti.com> <1307958710.1847.56.camel@deskari>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34351 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271Ab1FNHNy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jun 2011 03:13:54 -0400
In-Reply-To: <1307958710.1847.56.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>

Hi Tomi

On Mon, 13 Jun 2011, Tomi Valkeinen wrote:

> Paul, can you take this patch and queue it for an rc?

Generally I only queue regressions or fixes for major problems (crashes, 
corruption, etc.) for -rc series.  So probably this one should go in via 
the normal merge window, unless it's been causing major disruptions?


- Paul
