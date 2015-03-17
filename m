From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 7/7] ARM: omap2plus_defconfig: Enable EXTCON_GPIO_USB
Date: Tue, 17 Mar 2015 11:29:45 +0200
Message-ID: <5507F409.3010903@ti.com>
References: <1422274532-9488-1-git-send-email-rogerq@ti.com> <1422274532-9488-8-git-send-email-rogerq@ti.com> <20150316175355.GS5264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150316175355.GS5264-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 16/03/15 19:53, Tony Lindgren wrote:
> * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [150126 04:19]:
>> This driver is needed for USB cable type detection on dra7-evm,
>> dra72-evm and am57xx-beagle-x15.
>>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> 
> Applying this into omap-for-v4.1/defconfig. I think it's all
> queued up after this, please check and repost patches if
> it's still missing something as I've marked all the extcon
> related threads as read here now.

Thanks Tony.

We just need to revert the following commit.
addfcde7c485 ("ARM: dts: dra7x-evm: beagle-x15: Fix USB Host")

I'll send a patch on l-o for that.

cheers,
-roger


> 
> Regards,
> 
> Tony
> 
>> ---
>>  arch/arm/configs/omap2plus_defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
>> index 667d9d5..7e10e58 100644
>> --- a/arch/arm/configs/omap2plus_defconfig
>> +++ b/arch/arm/configs/omap2plus_defconfig
>> @@ -326,6 +326,7 @@ CONFIG_DMADEVICES=y
>>  CONFIG_TI_EDMA=y
>>  CONFIG_DMA_OMAP=y
>>  CONFIG_EXTCON=y
>> +CONFIG_EXTCON_USB_GPIO=m
>>  CONFIG_EXTCON_PALMAS=y
>>  CONFIG_PWM=y
>>  CONFIG_PWM_TIECAP=y
>> -- 
>> 2.1.0
>>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
