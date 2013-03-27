From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: OMAP: clocks: Delay clk inits atleast until
 slab is initialized
Date: Wed, 27 Mar 2013 09:50:08 -0700
Message-ID: <20130327165007.GJ25575@atomide.com>
References: <1363863892-6810-1-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1303270456280.8161@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:46661 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750967Ab3C0QuN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 12:50:13 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1303270456280.8161@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, phaber@broadcom.com, mturquette@linaro.org, santosh.shilimkar@ti.com

* Paul Walmsley <paul@pwsan.com> [130326 22:01]:
> Hi
> 
> On Thu, 21 Mar 2013, Rajendra Nayak wrote:
> 
> > clk inits on OMAP happen quite early, even before slab is available.
> > The dependency comes from the fact that the timer init code starts to
> > use clocks and hwmod and we need clocks to be initialized by then.
> > 
> > There are various problems doing clk inits this early, one is,
> > not being able to do dynamic clk registrations and hence the
> > dependency on clk-private.h. The other is, inability to debug
> > early kernel crashes without enabling DEBUG_LL and earlyprintk.
> 
> ...
> 
> > Reported-by: Piotr Haber <phaber@broadcom.com>
> > Reported-by: Tony Lindgren <tony@atomide.com>
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> 
> Thanks, looks good to me.  Nice patch description!
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>

I applied this into omap-for-v3.9-rc3/fixes, will send a pull request
for those today.

Regards,

Tony
