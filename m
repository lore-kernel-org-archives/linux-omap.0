From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] ARM: OMAP: clk-next-omap emergency fixes
Date: Sat, 18 Jan 2014 09:50:21 -0800
Message-ID: <20140118175020.GF7235@atomide.com>
References: <1389990340-23358-1-git-send-email-t-kristo@ti.com>
 <20140117213729.4167.55693@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:21911 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751064AbaARRu0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Jan 2014 12:50:26 -0500
Content-Disposition: inline
In-Reply-To: <20140117213729.4167.55693@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, nm@ti.com, linux-arm-kernel@lists.infradead.org

* Mike Turquette <mturquette@linaro.org> [140117 13:39]:
> Quoting Tero Kristo (2014-01-17 12:25:37)
> > Hi,
> > 
> > Quick emergency band-aid for the build breakages introduced in clk-next
> > by Mike. I didn't have time to test this out (Nishanth will provide some
> > logs) and I will leave the decision whether/how to use these patches or not
> > to Tony + Mike.
> > 
> > I also pushed a test branch based on top of clk-next here:
> > tree: https://github.com/t-kristo/linux-pm.git
> > branch: clk-next-omap-fixes
> 
> Thanks Tero. I force updated the clk tree with the right branch, so
> these should not be necessary now.

Great, and just for reference if I did not do it yet for these:

Acked-by: Tony Lindgren <tony@atomide.com>
