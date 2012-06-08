From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] ARM: omap: clock: Get rid of unwanted clkdm assocations
 within clks
Date: Fri, 08 Jun 2012 13:38:25 +0530
Message-ID: <4FD1B2F9.7050400@ti.com>
References: <1337250245-29274-1-git-send-email-rnayak@ti.com> <4FD04A2A.4080207@ti.com> <alpine.DEB.2.00.1206070104060.6684@utopia.booyaka.com> <4FD087FD.9040401@ti.com> <alpine.DEB.2.00.1206080130570.14977@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:41474 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759264Ab2FHIId (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jun 2012 04:08:33 -0400
Received: by obbuo19 with SMTP id uo19so2418431obb.26
        for <linux-omap@vger.kernel.org>; Fri, 08 Jun 2012 01:08:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1206080130570.14977@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

On Friday 08 June 2012 01:10 PM, Paul Walmsley wrote:
> Hi
>
> On Thu, 7 Jun 2012, Rajendra Nayak wrote:
>
>> Yes, I can include this as part of the common clock conversion series.
>> What I was trying to say is that neither the clock framework not any
>> other OMAP PM layer today makes any use of this information except for
>> gate clocks. The only 2 places in the clock framework this is used is
>> in omap2_dflt_clk_enable()/omap2_dflt_clk_disable() functions, which
>> are nops for non gate clocks.
>> So I don;t fully understand what you mean by our current low-level PM
>> design being based on this assumption that every clock belongs to a
>> clockdomain.
>> Did I miss anything else our PM frameworks do with the clock<->clkdm
>> association? The reason I am asking is because I am doing a lot of changes
>> around based on this assumption and would really like to know
>> if I am missing something.
>
> Well I guess the best thing to do is for you to do PM tests with the
> converted code and data to make sure it works.  That's what I'm worried
> most about right now for the CCF conversion; it's the most time-consuming
> part of what I do.  If the conversion works without them and everything is
> relatively clean then I probably won't have many issues with it.

The more I read your response, the more I feel you have mistaken what
this patch is doing and what I am proposing.
This patch only gets rid of clkdm assocation from *non gate* clocks.
And what I am trying to say is that, this information in not
used at all (for non gate clocks) in any of the frameworks today
including clock framework.
So why should getting rid of some *unused* data have any testing
overhead?
I did propose sometime back about getting rid of *all* clk<-> clkdm
assocation for OMAP2/3 and my testing also showed some positive
results, but that was just preliminary testing and I know to be able to
do that we need to much more testing, so thats definitely not what I am
doing here.
All the gate clocks still have the clk<->clkdm association. Even if you
look at my common clk conversion series, I have retained all
clk<->clkdm associations for all gate clocks across OMAP2 and OMAP3.
For any other form of clock it was never used and hence I am getting rid
of them.

regards,
Rajendra
>
> ...
>
> BTW, just to continue on the clk->clkdm topic: while we might be able to
> get rid of the clk->clkdm association for OMAP4 soon, and maybe someday
> for OMAP2/3, it looks like we'll need to keep it around for at least one
> AM335x clock -- this CLKDIV32K clock.  Definitely something to keep in
> mind...
>
>
> - Paul

