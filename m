From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP2+: hwmod: remove unused voltagedomain pointer from kerneldoc
Date: Fri, 09 Dec 2011 14:26:59 -0800
Message-ID: <874nx9mle4.fsf@ti.com>
References: <1323454481-26782-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:42667 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751026Ab1LIW1G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 17:27:06 -0500
Received: by mail-iy0-f176.google.com with SMTP id k12so5221867iak.7
        for <linux-omap@vger.kernel.org>; Fri, 09 Dec 2011 14:27:01 -0800 (PST)
In-Reply-To: <1323454481-26782-1-git-send-email-j-pihet@ti.com> (jean pihet's
	message of "Fri, 9 Dec 2011 19:14:41 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

jean.pihet@newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> Commit fa17f20f (OMAP2+: hwmod: remove unused voltagedomain pointer)
> did remove the voltdm field from the struct omap_hwmod.
> Remove it from the kerneldoc as well.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>

Acked-by: Kevin Hilman <khilman@ti.com>

Jean, please re-post with linux-arm-kernel in Cc.  Paul can then pick
it up and queue it.

Thanks,

Kevin
