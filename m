From: Vaibhav Bedia <vaibhav.bedia@gmail.com>
Subject: Re: [PATCH V6 02/15] ARM: OMAP2+: AM33XX: add lateinit hook for
 calling pm late init
Date: Thu, 10 Oct 2013 09:33:10 -0400
Message-ID: <CANacCWyoWZHP07UXptM-oANKpvARRmB5zqsxQXfUJrdHhS=a9Q@mail.gmail.com>
References: <1381354144-7134-1-git-send-email-nm@ti.com>
	<1381361098-8283-1-git-send-email-nm@ti.com>
	<52563BD8.1060703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <52563BD8.1060703@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: joelf@ti.com
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, linux-doc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <bcousson@baylibre.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Joel.

On Thu, Oct 10, 2013 at 1:32 AM, Joel Fernandes <joelf@ti.com> wrote:
> On 10/09/2013 06:24 PM, Nishanth Menon wrote:
>> Call OMAP2+ generic lateinit hook from AM specific late init hook.
>> This allows the generic late initializations such as cpufreq hooks
>> to be active.
>>
>> Cc: Benoit Cousson <bcousson@baylibre.com>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>  arch/arm/mach-omap2/board-generic.c |    1 +
>>  arch/arm/mach-omap2/common.h        |    1 +
>>  arch/arm/mach-omap2/io.c            |    6 ++++++
>>  3 files changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
>> index 87162e1..b474498 100644
>> --- a/arch/arm/mach-omap2/board-generic.c
>> +++ b/arch/arm/mach-omap2/board-generic.c
>> @@ -180,6 +180,7 @@ DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
>>       .init_irq       = omap_intc_of_init,
>>       .handle_irq     = omap3_intc_handle_irq,
>>       .init_machine   = omap_generic_init,
>> +     .init_late      = am33xx_init_late,
>
> Instead of adding a new a *_init_late function for every platform, perhaps
> better to just do:
> .init_late      = omap2_common_pm_late_init;
>
> since that's the only function you're calling.
>
For now...

As the PM support gets added there will be other function calls
and that can and is at times soc specific.

Regards,
Vaibhav
