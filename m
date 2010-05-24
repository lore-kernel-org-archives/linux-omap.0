From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 14/14] omap: mailbox: reorganize headers
Date: Mon, 24 May 2010 22:14:24 +0300
Message-ID: <AANLkTimEtI3pDJKJOCyiBK8f0y1p0nyyIeptcS2eyy_v@mail.gmail.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
	 <1274548465-20208-15-git-send-email-felipe.contreras@gmail.com>
	 <20100524171634.GA23202@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63146 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526Ab0EXTO0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 15:14:26 -0400
Received: by bwz7 with SMTP id 7so1188457bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 24 May 2010 12:14:25 -0700 (PDT)
In-Reply-To: <20100524171634.GA23202@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>

On Mon, May 24, 2010 at 8:16 PM, Felipe Balbi <felipe.balbi@nokia.com> wrote:
> personally I don't like this patch since it makes the C-sources rely on
> indirect header inclusion by another header. That's really error prone and
> will cause build failures if someone decides to remove the include
> <linux/device.h> from plat/mailbox.h.

First of all, you cannot expect each and every source file to include
each and every header it's using directly. It would be nice, but it's
not happening now, and probably will not happen ever.

Now, with a few exceptions, I didn't assume somebody else would be
loading anything, in fact, the patch is mostly _adding_ headers that
were missing.

If you take a look at the modified files regarding kernel.h and module.h:

* arch/arm/mach-omap1/mailbox.c:
 Not really using kernel.h, missing module.h

* arch/arm/mach-omap2/mailbox.c:
 Missing module.h

* arch/arm/plat-omap/mailbox.c
 Missing kernel.h

So it was clear to me that these were not carefully added, and
probably were redundant, so I choose to remove them completely. If you
have something against that, I can add them where it makes sense but
the current patch is not really making the situation much worst.

Now, regarding device.h:

* arch/arm/mach-omap2/mailbox.c
 Using it, but missing

* arch/arm/plat-omap/include/plat/mailbox.h
 Was using it, but a 'struct device' would suffice

 * arch/arm/plat-omap/mailbox.c
 Using it correctly

Now, I am pretty sure that platform_device.h will always depend on
device.h that's why I removed them, but I can add them again if
somebody wants to, but again, the situation is already bad.

-- 
Felipe Contreras
