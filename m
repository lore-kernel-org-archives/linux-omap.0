From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] ARM: OMAP: Conditionally compile counter_32k
Date: Mon, 26 Nov 2012 16:09:34 +0200
Message-ID: <50B3781E.3040205@compulab.co.il>
References: <1353922083-1094-1-git-send-email-alessio.bogani@elettra.trieste.it> <50B35A4D.8080501@compulab.co.il> <50B36B81.4010709@elettra.trieste.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50B36B81.4010709@elettra.trieste.it>
Sender: linux-kernel-owner@vger.kernel.org
To: Alessio Igor Bogani <alessio.bogani@elettra.trieste.it>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/26/12 15:15, Alessio Igor Bogani wrote:
> Hi Igor,
> 
> On 26/11/2012 13:02, Igor Grinberg wrote:
>> On 11/26/12 11:28, Alessio Igor Bogani wrote:
> [...]
>>>   # Common support
>>> -obj-y := sram.o dma.o fb.o counter_32k.o
>>> +obj-y := sram.o dma.o fb.o
>>>   obj-m :=
>>>   obj-n :=
>>>   obj-  :=
>>>
>>> +obj-$(CONFIG_OMAP_32K_TIMER) += counter_32k.o
>>
>> We are moving away from this config option in favor of runtime detection,
> 
> Well, I'll be happy when it'll happen.
> 
>> Why do you need this?
> 
> Because until now the build system doesn't honour the config file. Indeed it builds that source code file also when I set CONFIG_OMAP_32K_TIMER to n.
> 
> The runtime detection isn't a good excuse for doesn't make the build system working like users expect.

So, the problem is the users expectations...
If you look, at Tony's omap-for-v3.8/timer branch,
patch: ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
it should change the expectations (at least I tried to do this in Kconfig file).

So, to the question of honoring the config option - yes,
but it is a work in progress on removing that one.

If you have a real issue that you are trying to fix - it is totally different thing,
but if it is just config option honoring... then I don't think we should merge this patch.

-- 
Regards,
Igor.
