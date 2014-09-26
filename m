From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] clk: prevent erronous parsing of children during rate
 change
Date: Thu, 25 Sep 2014 18:35:54 -0700
Message-ID: <5424C2FA.4000508@codeaurora.org>
References: <1408628866-32351-1-git-send-email-t-kristo@ti.com> <20140922191816.GF10233@codeaurora.org> <542177E5.9060606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <542177E5.9060606@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 09/23/14 06:38, Tero Kristo wrote:
> On 09/22/2014 10:18 PM, Stephen Boyd wrote:
>> On 08/21, Tero Kristo wrote:
>>>           /* Skip children who will be reparented to another clock */
>>>           if (child->new_parent && child->new_parent != clk)
>>>               continue;
>>
>> Are we not hitting the new_parent check here? I don't understand
>> how we can be changing parents here unless the check is being
>> avoided, in which case I wonder why determine_rate isn't being
>> used.
>>
>
> It depends how the clock underneath handles the situation. The error I
> am seeing actually happens with a SoC specific compound clock (DPLL)
> which integrates set_rate + mux functionality into a single clock
> node. A call to the clk_set_rate changes the parent of this clock
> (from bypass clock to reference clock), in addition to changing the
> rate (tune the mul+div.) I looked at using the determine rate call
> with this type but it breaks everything up... the parent gets changed
> but not the clock rate, in addition to some other issues.

Ok. Is this omap3_noncore_dpll_set_rate()? Can we use determine_rate +
clk_set_parent_and_rate()? At least clk_set_parent_and_rate() would
allow us to do the mult+div and the parent in the same op call, although
I don't understand why setting the parent and then setting the rate is
not going to work. I'm interested in the other issues that you mentioned
too.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
