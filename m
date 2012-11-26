From: Alessio Igor Bogani <alessio.bogani@elettra.trieste.it>
Subject: Re: [PATCH] ARM: OMAP: Conditionally compile counter_32k
Date: Mon, 26 Nov 2012 14:15:45 +0100
Message-ID: <50B36B81.4010709@elettra.trieste.it>
References: <1353922083-1094-1-git-send-email-alessio.bogani@elettra.trieste.it> <50B35A4D.8080501@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50B35A4D.8080501@compulab.co.il>
Sender: linux-kernel-owner@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Igor,

On 26/11/2012 13:02, Igor Grinberg wrote:
> On 11/26/12 11:28, Alessio Igor Bogani wrote:
[...]
>>   # Common support
>> -obj-y := sram.o dma.o fb.o counter_32k.o
>> +obj-y := sram.o dma.o fb.o
>>   obj-m :=
>>   obj-n :=
>>   obj-  :=
>>
>> +obj-$(CONFIG_OMAP_32K_TIMER) += counter_32k.o
>
> We are moving away from this config option in favor of runtime detection,

Well, I'll be happy when it'll happen.

> Why do you need this?

Because until now the build system doesn't honour the config file. 
Indeed it builds that source code file also when I set 
CONFIG_OMAP_32K_TIMER to n.

The runtime detection isn't a good excuse for doesn't make the build 
system working like users expect.

Ciao,
Alessio
