From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP3EVM: Marking omap3_evm_display_init() with
 CONFIG_BROKEN
Date: Fri, 26 Jul 2013 20:00:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307261956520.25740@utopia.booyaka.com>
References: <alpine.DEB.2.02.1307220523380.4804@utopia.booyaka.com> <51ED33F1.4000801@cogentembedded.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37859 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253Ab3GZUAw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Jul 2013 16:00:52 -0400
In-Reply-To: <51ED33F1.4000801@cogentembedded.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: stable@vger.kernel.org, tony@atomide.com, lokeshvutla@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@ti.com

Hi Sergei

On Mon, 22 Jul 2013, Sergei Shtylyov wrote:

>    Perhaps it's better to follow what Documentation/SubmittingPatches
> suggests:
> 
> #else
> static inline __init void omap3_evm_display_init(void) {}

...

>    ... and eliminate #ifdef here?

While I agree with you in principle, the original patch is already merged.  
In my view, it's not worth checking in another patch on top of it to 
address such a cosmetic, non-functional issue.  I certainly don't think 
it's worth delaying getting v3.10-stable to boot on 37xx EVM...


- Paul
