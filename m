From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [Cocci] [PATCH v13 3/6] clk: Make clk API return per-user struct
 clk instances
Date: Thu, 05 Feb 2015 18:15:31 -0800
Message-ID: <54D423C3.9030105@codeaurora.org>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com> <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com> <20150201212432.22722.70917@quantum> <54CFE1FE.7040404@codeaurora.org> <alpine.DEB.2.02.1502022230110.2045@localhost6.localdomain6> <54CFFBCF.90706@codeaurora.org> <20150202225036.421.43421@quantum> <54D0F179.1040906@gmail.com> <54D2AA9B.7010800@codeaurora.org> <54D3900A.9060200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54D3900A.9060200@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Lambert <lambert.quentin@gmail.com>, Mike Turquette <mturquette@linaro.org>, Julia Lawall <julia.lawall@lip6.fr>
Cc: Paul Walmsley <paul@pwsan.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux-omap@vger.kernel.org, cocci@systeme.lip6.fr, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 02/05/15 07:45, Quentin Lambert wrote:
>
> On 05/02/2015 00:26, Stephen Boyd wrote:
>>> If you want me to I can enlarge the search to other directories.
>> Yes please do. And if you could share the coccinelle patch that would be
>> great. Thanks.
>>
> structclk.cocci is the coccinelle patch
> structclk-arm.patch is the result I got when applying it to the
> arch/arm directory
>
> Is there anything else I can do to help?
>
>

Thanks for the coccinelle patch. Thinking more about it, I don't think
we care if the pointer is dereferenced because that would require a
definition of struct clk and that is most likely not the case outside of
the clock framework. Did you scan the entire kernel? I'm running it now
but it seems to be taking a while.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
