From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 01/28] OMAP: change get_context_loss_count ret value
 to int
Date: Tue, 14 Jun 2011 10:24:17 +0300
Message-ID: <1308036257.1899.8.camel@deskari>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
	 <1307627810-3768-2-git-send-email-tomi.valkeinen@ti.com>
	 <1307958710.1847.56.camel@deskari>
	 <alpine.DEB.2.00.1106140111540.20723@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:48823 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754233Ab1FNHYY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Jun 2011 03:24:24 -0400
In-Reply-To: <alpine.DEB.2.00.1106140111540.20723@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-fbdev@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>

On Tue, 2011-06-14 at 01:13 -0600, Paul Walmsley wrote:
> Hi Tomi
> 
> On Mon, 13 Jun 2011, Tomi Valkeinen wrote:
> 
> > Paul, can you take this patch and queue it for an rc?
> 
> Generally I only queue regressions or fixes for major problems (crashes, 
> corruption, etc.) for -rc series.  So probably this one should go in via 
> the normal merge window, unless it's been causing major disruptions?

No, only disruptions for me as the DSS pm_runtime patches depend on this
one to function correctly. So merge window is ok, I'll handle the DSS
side somehow.

 Tomi


