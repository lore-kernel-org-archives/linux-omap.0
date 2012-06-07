From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] ARM: omap: clock: Get rid of unwanted clkdm assocations
 within clks
Date: Thu, 07 Jun 2012 16:22:45 +0530
Message-ID: <4FD087FD.9040401@ti.com>
References: <1337250245-29274-1-git-send-email-rnayak@ti.com> <4FD04A2A.4080207@ti.com> <alpine.DEB.2.00.1206070104060.6684@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:33040 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760603Ab2FGKww (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:52:52 -0400
Received: by obbeh20 with SMTP id eh20so952287obb.31
        for <linux-omap@vger.kernel.org>; Thu, 07 Jun 2012 03:52:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1206070104060.6684@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

On Thursday 07 June 2012 12:37 PM, Paul Walmsley wrote:
> Hi
>
> On Thu, 7 Jun 2012, Rajendra Nayak wrote:
>
>> On Thursday 17 May 2012 03:54 PM, Rajendra Nayak wrote:
>>> clkdm assocations with clocks in the clock framework are useful
>>> only for 'gate' clocks which have enable/disable ops populated.
>>> Get rid of the clkdm_names populated in any other type of clocks.
>
> I don't really see the point in changing this before the common clock
> conversion.  The design of most of the current low-level OMAP PM layers
> was predicated on each clock belonging to a clockdomain.  The testing
> overhead of changing this before the common clock conversion is something
> that I don't have time for, and almost no one else seems interested in
> doing.
>
> Your common clock conversion moots this patch anyway, right?

Yes, I can include this as part of the common clock conversion series.
What I was trying to say is that neither the clock framework not any
other OMAP PM layer today makes any use of this information except for
gate clocks. The only 2 places in the clock framework this is used is
in omap2_dflt_clk_enable()/omap2_dflt_clk_disable() functions, which
are nops for non gate clocks.
So I don;t fully understand what you mean by our current low-level PM
design being based on this assumption that every clock belongs to a
clockdomain.
Did I miss anything else our PM frameworks do with the clock<->clkdm
association? The reason I am asking is because I am doing a lot of 
changes around based on this assumption and would really like to know
if I am missing something.

regards,
Rajendra

>
> - Paul
>

