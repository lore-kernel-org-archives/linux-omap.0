From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 0/2] OMAP2+: optional clock handling fixes
Date: Thu, 8 May 2014 12:29:51 +0530
Message-ID: <536B2B67.9070808@ti.com>
References: <1398233465-8845-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.02.1405080000400.23579@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1405080000400.23579@utopia.booyaka.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, linux-gpio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thursday 08 May 2014 05:38 AM, Paul Walmsley wrote:
> Hi Rajendra,
> 
> On Wed, 23 Apr 2014, Rajendra Nayak wrote:
> 
>> The patches fix some opt clock handling in gpio and in
>> hwmod.
>>
>> Rajendra Nayak (2):
>>   gpio: omap: prepare and unprepare the debounce clock
>>   ARM: OMAP2+: hwmod: Don't leave the optional clocks in
>>     clk_prepare()ed state
>>
>>  arch/arm/mach-omap2/omap_hwmod.c |   13 ++-----------
>>  drivers/gpio/gpio-omap.c         |   10 +++++-----
>>  2 files changed, 7 insertions(+), 16 deletions(-)
> 
> Can these patches be merged separately?  Looks to me that the two options 
> are either to:
> 
> A. to merge them together, or 
> 
> B. to merge patch 1 first, then patch 2

Thats right.

> 
> Or will things break if only patch 1 is merged?

Things will break if only patch 2 is merged as gpios clk_enable()
request would fail. Merging only patch 1 has no issues.

> 
> 
> If we merge them together, I'd say the best situation would be to take 
> them through the OMAP tree, since the changes are all OMAP-specific.  In 
> that case we'll want an ack for the first patch from the GPIO maintainers, 
> Linus Walleij <linus.walleij@linaro.org> and Alexandre Courbot 
> <gnurou@gmail.com>.
> 
> Otherwise the path of least resistance would be (B) - you can get patch 1 
> merged via the GPIO tree.  The GPIO maintainers can then provide a 
> stable branch for us to base our changes on, or we can wait until the 
> change reaches Linus.  Then we can subsequently merge patch 2 via the  
> OMAP side.
> 
> Thoughts?

I am fine either way. I will check with Linus W. what he prefers. Thanks.

regards,
Rajendra
> 
> 
> - Paul
> 

