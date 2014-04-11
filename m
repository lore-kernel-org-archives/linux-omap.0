From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: fix missing braces in _init()
Date: Fri, 11 Apr 2014 18:27:57 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1404111827410.14347@utopia.booyaka.com>
References: <1394788517-15014-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:60250 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbaDKS16 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2014 14:27:58 -0400
In-Reply-To: <1394788517-15014-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Suman Anna <s-anna@ti.com>, Nishanth Menon <nm@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>

On Fri, 14 Mar 2014, Rajendra Nayak wrote:

> From: Suman Anna <s-anna@ti.com>
> 
> Bug was introduced by commit 'f92d959: ARM: OMAP2+: hwmod:
> Extract no-idle and no-reset info from DT'
> 
> There were 2 versions of the patch posted which resulted in the above
> commit. While v1 [1] had the bug, v2 [2] had it fixed.
> However v1 apparently seemed to have been pulled in by mistake
> introducing the bug.
> 
> Given of_find_property() does return NULL when the node passed is
> NULL, it did not introduce any functional issues as such, just the
> fact that the second if check was executed unnecessarily.
> 
> [1] https://www.mail-archive.com/linux-omap@vger.kernel.org/msg94220.html
> [2] http://www.spinics.net/lists/linux-omap/msg98490.html
> 
> Cc: Nishanth Menon <nm@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks, queued for v3.15-rc.


- Paul
