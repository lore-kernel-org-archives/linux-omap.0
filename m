From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod data: Fix wrong lostcontext_mask
 for OMAP4 l4_abe
Date: Tue, 16 Oct 2012 10:59:10 -0700
Message-ID: <20121016175909.GZ15569@atomide.com>
References: <507D20F2.9060007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:47360 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755016Ab2JPR7O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 13:59:14 -0400
Content-Disposition: inline
In-Reply-To: <507D20F2.9060007@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Guiriec, Sebastien" <s-guiriec@ti.com>, Tero Kristo <t-kristo@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Benoit Cousson <b-cousson@ti.com> [121016 01:56]:
> The following commit added the support for the lostcontext_mask
> along with the usage of the flag for l4_abe.
> 
>  commit ce80979aedfce937926a8dd40a1f92fd4bc2fd53
>  Author: Tero Kristo <t-kristo@ti.com>
>  Date:   Sun Sep 23 17:28:19 2012 -0600
> 
>     ARM: OMAP4: hwmod data: add support for lostcontext_mask
> 
> Unfortunately, the l4_abe does not contain this memory and thus
> cannot contain that flag.
> 
> Remove the flag from the l4_abe hwmod.
> 
> Change as well the mask for omap44xx_aess_hwmod to avoid missing
> the status in case LOSTMEM_AESSMEM is set. The AESS logic does
> not support retention and thus only the memory state is useful.
> It is even mandatory to avoid a crash in the case of the AESS
> resume.
> 
> TBD: Ideally each hwmod should contain an extra entry for memory
> context attached to it. The AESS does contain only one, but some
> IP like the IVAHD does have three memories with dedicated status.
> The granularity is never used, but at least one global information
> for all the memory banks is useful.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>

Thanks applying into omap-for-v3.7-rc1/fixes-part2.

Regards,

Tony
