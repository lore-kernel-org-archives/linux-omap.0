From: George Cherian <george.cherian@ti.com>
Subject: Re: [PATCH v2 1/3] gpio: pcf857x: change to  devm_request_threaded_irq
Date: Mon, 2 Sep 2013 07:32:16 +0530
Message-ID: <5223F1A8.4090509@ti.com>
References: <1377859713-13460-1-git-send-email-george.cherian@ti.com> <1377859713-13460-2-git-send-email-george.cherian@ti.com> <87ppssrpci.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <87ppssrpci.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linus.walleij@linaro.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, n.a.balandin@gmail.com
List-Id: linux-omap@vger.kernel.org

On 9/2/2013 6:50 AM, Kuninori Morimoto wrote:
> Hi
>
>> Remove the request_irq and use devm_request_threaded_irq
>> also cleanup free_irq. devm_* takes care of that.
>>
>> Signed-off-by: George Cherian <george.cherian@ti.com>
>> ---
>>   arch/arm/boot/dts/dra7-evm.dts |  2 +-
>>   drivers/gpio/gpio-pcf857x.c    | 28 ++++++++++++++++++++++++----
>>   2 files changed, 25 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
>> index 8b0738a..39b44bc 100644
>> --- a/arch/arm/boot/dts/dra7-evm.dts
>> +++ b/arch/arm/boot/dts/dra7-evm.dts
>> @@ -65,7 +65,7 @@
>>   		n_latch = <0x1408>;
>>   		gpio-controller;
>>   		#gpio-cells = <2>;
>> -		interrupt-parent = <&pcf_20>;
>> +		interrupt-parent = <&gpio20>;
>>   		interrupts = <14 2>;
>>   		interrupt-controller;
>>   		#interrupt-cells = <2>;
> I'm not sure detail,
> but does above "exchange interrupt-parent" and "using devm_request_threaded_irq()"
> have any relationship ?
Exactly. will resend this change alone.
> Separate patch seems nice ?

okay
> Best regards
> ---
> Kuninori Morimoto


-- 
-George

