From: Zumeng Chen <zumeng.chen@windriver.com>
Subject: Re: [PATCH 3/5] ARM: omap3evm: enable VBUS switch for EHCI tranceiver
Date: Thu, 21 Jun 2012 09:03:06 +0800
Message-ID: <4FE272CA.6090502@windriver.com>
References: <1340183693-3195-1-git-send-email-zumeng.chen@windriver.com> <1340183693-3195-4-git-send-email-zumeng.chen@windriver.com> <4FE1BC98.7050607@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:42261 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151Ab2FUBEP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jun 2012 21:04:15 -0400
In-Reply-To: <4FE1BC98.7050607@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: jon-hunter@ti.com, mike@compulab.co.il, linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, hvaibhav@ti.com, linux-arm-kernel@lists.infradead.org, ajay.gupta@ti.com

=E4=BA=8E 2012=E5=B9=B406=E6=9C=8820=E6=97=A5 20:05, Sergei Shtylyov =E5=
=86=99=E9=81=93:
> Hello.
>
> On 20-06-2012 13:14, Zumeng Chen wrote:
>
>> This was chosen by following the trace on the schematic from=20
>> component U131
>> and U134 to the CPEN pin on the USB3320 device.
>
>> TWL4030.GPIO2-...->(T2_GPIO2_3V3)U131-..>nUSB2_EN-..>U134-..>EXP_nUS=
B2_1V8=20
>>
>> which starts EHCI tranceiver USB3320.
>
>> This will set TWL4030.GPIO2 as output pin to drive EHCI tranceiver.
>
>> Signed-off-by: Zumeng Chen<zumeng.chen@windriver.com>
>> ---
>> arch/arm/mach-omap2/board-omap3evm.c | 9 +++++++++
>> 1 files changed, 9 insertions(+), 0 deletions(-)
>
>> diff --git a/arch/arm/mach-omap2/board-omap3evm.c=20
>> b/arch/arm/mach-omap2/board-omap3evm.c
>> index 1bfbe42..02d8047 100644
>> --- a/arch/arm/mach-omap2/board-omap3evm.c
>> +++ b/arch/arm/mach-omap2/board-omap3evm.c
>> @@ -360,6 +360,15 @@ static int omap3evm_twl_gpio_setup(struct devic=
e=20
>> *dev,
>>
>> platform_device_register(&leds_gpio);
>>
>> + /* Enable VBUS switch by setting TWL4030.GPIO2DIR as output
>> + * for starting USB tranceiver
>> + */
>> + if (get_omap3_evm_rev()>=3D OMAP3EVM_BOARD_GEN_2) {
>> + u8 val;
>
> Empty line after declaration block wouldn't hurt...
Yes, Agreed.

Regards,
Zumeng
>
>> + twl_i2c_read_u8(TWL4030_MODULE_GPIO,&val, REG_GPIODATADIR1);
>> + val |=3D 0x04; /* TWL4030.GPIO2DIR BIT at GPIODATADIR1(0x9B) */
>> + twl_i2c_write_u8(TWL4030_MODULE_GPIO, val, REG_GPIODATADIR1);
>> + }
>> return 0;
>> }
>
> WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
