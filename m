From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: DRA7: hwmod: Fix boot crash with DEBUG_LL
Date: Thu, 26 Dec 2013 04:13:31 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312260413190.15949@utopia.booyaka.com>
References: <1386841969-765-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41770 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477Ab3LZENc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Dec 2013 23:13:32 -0500
In-Reply-To: <1386841969-765-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, bcousson@baylibre.com, lokeshvutla@ti.com

On Thu, 12 Dec 2013, Rajendra Nayak wrote:

> With commit '7dedd34: ARM: OMAP2+: hwmod: Fix a crash in _setup_reset() with
>  DEBUG_LL' we moved from parsing cmdline to identify uart used for earlycon
> to using the requsite hwmod CONFIG_DEBUG_OMAPxUARTy FLAGS.
> 
> On DRA7 though, we seem to be missing this flag, and atleast on the DRA7 EVM
> where we use uart1 for console, boot fails with DEBUG_LL enabled.
> 
> Reported-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, queued with Lokesh's Tested-by.


- Paul
