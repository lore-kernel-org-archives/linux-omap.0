From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] ARM: avoid Cortex-A9 livelock on tight dmb loops
Date: Tue, 10 Apr 2018 17:12:37 +0300
Message-ID: <685f80e3-30b3-8806-b81c-8de456507001@ti.com>
References: <E1f5qij-00033R-Sl@rmk-PC.armlinux.org.uk>
 <20180410134149.GQ5700@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180410134149.GQ5700@atomide.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@armlinux.org.uk>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 10/04/18 16:41, Tony Lindgren wrote:
> * Russell King <rmk+kernel@armlinux.org.uk> [180410 10:43]:
>> diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
>> index 021b5a8b9c0a..d4ddc78b2a0b 100644
>> --- a/arch/arm/mach-omap2/prm_common.c
>> +++ b/arch/arm/mach-omap2/prm_common.c
>> @@ -523,7 +523,7 @@ void omap_prm_reset_system(void)
>>   	prm_ll_data->reset_system();
>>   
>>   	while (1)
>> -		cpu_relax();
>> +		cpu_do_idle();
>>   }
>>   
> 
> Hmm we need to check so the added WFI here does not cause an
> undesired change to a low power state. Adding Tero to Cc also.

Generally it is a bad idea to call arbitrary WFI within OMAP 
architecture, as this triggers a PRCM power transition and will most 
likely cause a hang if not controlled properly.

Has this patch been tested on any platform that supports proper power 
management?

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
