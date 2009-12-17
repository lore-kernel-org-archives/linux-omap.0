From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] OMAP: McBSP: Fix possible port lockout
Date: Thu, 17 Dec 2009 09:19:18 +0200
Message-ID: <20091217091918.1ae3c388.jhnikula@gmail.com>
References: <200912161716.30041.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:57845 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756942AbZLQHSA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 02:18:00 -0500
Received: by bwz27 with SMTP id 27so1310959bwz.21
        for <linux-omap@vger.kernel.org>; Wed, 16 Dec 2009 23:17:58 -0800 (PST)
In-Reply-To: <200912161716.30041.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-omap@vger.kernel.org

On Wed, 16 Dec 2009 17:16:28 +0100
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> More and more looking at this, I think that omap_mcbsp_request() should be 
> cleaned up frist in respect of freeing resources on error before we put any 
> new functionality there.
> 
Good idea.

> I'm not sure if it is really required to revert any  
> mcbsp->pdata->ops->request() or omap34xx_mcbsp_request() applied changes by 
> calling mcbsp->pdata->ops->free() or omap34xx_mcbsp_free() from here.
> 
It is allways worth/must to keep request and free calls in balance as
your patch does. In this case some clocks may left running
(omap1_mcbsp_request/_free) or wakeup behavior (34xx) otherwise.

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
