From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC PATCH 6/6] ARM: OMAP3: Enable Hardware Save and Restore
 for USB Host
Date: Thu, 20 Jun 2013 15:42:08 +0300
Message-ID: <51C2F8A0.4040009@ti.com>
References: <1371650753-11452-1-git-send-email-rogerq@ti.com> <1371650753-11452-7-git-send-email-rogerq@ti.com> <51C1EA99.2020401@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51C1EA99.2020401@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: stern@rowland.harvard.edu, tony@atomide.com, balbi@ti.com, ruslan.bilovol@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 06/19/2013 08:30 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 06/19/2013 06:05 PM, Roger Quadros wrote:
> 
>> To ensure hardware context is restored while resuming from
>> OFF mode we need to enable the Hardware SAR bit for the
>> USB Host power domain.
> 
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   arch/arm/mach-omap2/powerdomains3xxx_data.c |    8 +-------
>>   1 files changed, 1 insertions(+), 7 deletions(-)
> 
>> diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
>> index f0e14e9..9554d2b 100644
>> --- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
>> +++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
>> @@ -289,13 +289,7 @@ static struct powerdomain usbhost_pwrdm = {
>>       .prcm_offs      = OMAP3430ES2_USBHOST_MOD,
>>       .pwrsts          = PWRSTS_OFF_RET_ON,
>>       .pwrsts_logic_ret = PWRSTS_RET,
>> -    /*
>> -     * REVISIT: Enabling usb host save and restore mechanism seems to
>> -     * leave the usb host domain permanently in ACTIVE mode after
>> -     * changing the usb host power domain state from OFF to active once.
>> -     * Disabling for now.
>> -     */
>> -    /*.flags      = PWRDM_HAS_HDWR_SAR,*/ /* for USBHOST ctrlr only */
>> +    .flags      = PWRDM_HAS_HDWR_SAR, /* for USBHOST ctrlr only */
> 
>    Looks like you're not indenting = right, in accordance to the other fields...

Will fix. Thanks.

cheers,
-roger
