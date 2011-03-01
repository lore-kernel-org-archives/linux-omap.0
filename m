From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2+: sdrc: fix compile break on OMAP4-only config
 on current omap-for-linus
Date: Mon, 28 Feb 2011 17:58:18 -0800
Message-ID: <20110301015818.GM20560@atomide.com>
References: <alpine.DEB.2.00.1102251839360.6198@utopia.booyaka.com>
 <4D6916D0.1080501@ru.mvista.com>
 <alpine.DEB.2.00.1102271701450.4608@utopia.booyaka.com>
 <4D6B8BB2.2010503@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:24011 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab1CAB61 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 20:58:27 -0500
Content-Disposition: inline
In-Reply-To: <4D6B8BB2.2010503@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Sergei Shtylyov <sshtylyov@mvista.com> [110228 03:48]:
> 
> On 28-02-2011 3:03, Paul Walmsley wrote:
> 
> >Tony, do you want to take this one?

Applying..
 
> >+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> >  void __init omap2_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
> >  			    struct omap_sdrc_params *sdrc_cs1);
> >+#else
> >+static inline void __init omap2_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
> 
>    No need to annotate it as __init.

..modified this.

Tony
