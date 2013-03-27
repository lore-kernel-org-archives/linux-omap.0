From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2] ARM: OMAP: clocks: Delay clk inits atleast until slab
 is initialized
Date: Wed, 27 Mar 2013 04:57:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303270456280.8161@utopia.booyaka.com>
References: <1363863892-6810-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:43100 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754359Ab3C0E5e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 00:57:34 -0400
In-Reply-To: <1363863892-6810-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, phaber@broadcom.com, mturquette@linaro.org, santosh.shilimkar@ti.com

Hi

On Thu, 21 Mar 2013, Rajendra Nayak wrote:

> clk inits on OMAP happen quite early, even before slab is available.
> The dependency comes from the fact that the timer init code starts to
> use clocks and hwmod and we need clocks to be initialized by then.
> 
> There are various problems doing clk inits this early, one is,
> not being able to do dynamic clk registrations and hence the
> dependency on clk-private.h. The other is, inability to debug
> early kernel crashes without enabling DEBUG_LL and earlyprintk.

...

> Reported-by: Piotr Haber <phaber@broadcom.com>
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, looks good to me.  Nice patch description!

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
