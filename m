From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Tue, 3 Jul 2012 00:09:26 -0700
Message-ID: <20120703070926.GI1122@atomide.com>
References: <1337803690-30116-1-git-send-email-andy.gross@ti.com>
 <CAF6AEGs0OYSUg0uGi5y0HgsHzqJYUwWj7Hx1Tupzu7mxa3VvLQ@mail.gmail.com>
 <CABT81PhCGAwFBgVCk7CJGg7_erVZjS0DUM9ajg9uaQh5wf6ZRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:40635 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027Ab2GCHJa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jul 2012 03:09:30 -0400
Content-Disposition: inline
In-Reply-To: <CABT81PhCGAwFBgVCk7CJGg7_erVZjS0DUM9ajg9uaQh5wf6ZRQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gross, Andy" <andy.gross@ti.com>
Cc: Rob Clark <rob.clark@linaro.org>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, greg@kroah.com, tomi.valkeinen@ti.com

* Gross, Andy <andy.gross@ti.com> [120619 14:17]:
> Tony,
> 
> Please queue this patch at your earliest convenience.
> 
> We had some discussion on the splitting out of the DMM/Tiler driver
> from the omapdrm driver.  There might be some interest in leveraging
> the Tiler for omapfb.  However, we agreed this can be deferred until
> some other device (omapfb or otherwise) needs to use the Tiler.

OK I'll apply this into devel-board as that's seems to fit the platform
data area.

Regards,

Tony
