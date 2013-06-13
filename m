From: Ambresh K <ambresh@ti.com>
Subject: Re: [Patch 3/3] clk: Avoid re-parenting orphan clk's having invalid
 parent index.
Date: Thu, 13 Jun 2013 12:36:43 +0530
Message-ID: <51B96F83.10309@ti.com>
References: <1367475929-32166-1-git-send-email-ambresh@ti.com> <1367475929-32166-4-git-send-email-ambresh@ti.com> <20130529071809.6058.24017@quantum> <51AD9450.5090107@ti.com> <20130611220744.8816.8856@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130611220744.8816.8856@quantum>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Rajendra <rnayak@ti.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org




>> Sorry for not being descriptive in commit message.  
>>
>> a) Avoids unnecessary re-parenting cycle for orphan clock's with invalid parent for every clock
>>
> 
> True, but this is a minor optimisation.  If this is a big optimization
> for you then you really need to fix your bootloader.  We shouldn't be
> optimizing slow error paths just because we refuse to fix the errors.

Got it! Should be fixed in boot-loader. 

> 
>> b) With patch [1/3], after a clk with invalid parent was encountered, for every clk registered thereafter seeing following logs. 
>> <Snippet>
>> [    0.000000] __clk_init: orphan clk(gpu_core_gclk_mux) invalid parent
>> [    0.000000] __clk_init: orphan clk(gpu_core_gclk_mux) invalid parent
>> [    0.000000] __clk_init: orphan clk(gpu_core_gclk_mux) invalid parent
>> [    0.000000] __clk_init: orphan clk(gpu_core_gclk_mux) invalid parent
>> [    0.000000] __clk_init: orphan clk(gpu_core_gclk_mux) invalid parent
>> [    0.000000] __clk_init: orphan clk(gpu_core_gclk_mux) invalid parent
>> [    0.000000] __clk_init: orphan clk(gpu_core_gclk_mux) invalid parent
>> [    0.000000] __clk_init: orphan clk(gpu_core_gclk_mux) invalid parent  
>>
>> Please advice, if can be handled better. 
>>
> 
> First off, I don't think we should create new structures to work around
> bugs that should be fixed.  pr_err_once() will let us know something is
> wrong and won't flood the log.  Even then I'm inclined to say that
> flooding the log is OK and will motivate you to fix up your bootloader.
> Error prints are there for a reason.
> 
> Secondly, I spent like 10 minutes looking at this code and I'm still
> confused.  For a clock with invalid parent programming, are you adding
> it to BOTH the orphan list and the has_invalid_parent list?  Why?  Is
> this just avoid the spurious prints?  For everyone clock registered we
> walk the list of orphans to see if that orphan can be reparented.  This
> patch adds another nested list walk (likely a short list) for each of
> those orphans in the first list walk, so it starts to look like O(n^2).
> I don't like it.
> 
> I think the first two patches in the series look good, but unless I am
> misunderstanding this patch I feel that it can be dropped entirely.
> 

Thanks for your time! 
Will drop this patch and send V2 for first 2 patches. 


Regards,
Ambresh
