From: George Cherian <george.cherian@ti.com>
Subject: Re: [PATCH v3 0/3] cleanup of gpio_pcf857x.c
Date: Mon, 2 Sep 2013 12:50:46 +0530
Message-ID: <52243C4E.8000007@ti.com>
References: <1378089004-14478-1-git-send-email-george.cherian@ti.com> <87a9jvsofz.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87a9jvsofz.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linus.walleij@linaro.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, n.a.balandin@gmail.com
List-Id: linux-omap@vger.kernel.org

On 9/2/2013 12:25 PM, Kuninori Morimoto wrote:
> Hi
>
> Sorry for my many response.
No Issues. and thanks for the review.
>> This patch series
>>          - removes the irq_demux_work
>>          - Uses devm_request_threaded_irq
>>          - Call the user handler iff gpio_to_irq is done.
>>
>> v1 --> v2
>>          Split v1 to 3 patches
>> v2 --> v3
>> 	Remove the unnecessary dts patches.
>>
>>
>> George Cherian (3):
>>    gpio: pcf857x: change to devm_request_threaded_irq
>>    gpio: pcf857x: remove the irq_demux_work
>>    gpio: pcf857x: call the gpio user handler iff gpio_to_irq is done
>>
>>   drivers/gpio/gpio-pcf857x.c | 51 +++++++++++++++++++++++----------------------
>>   1 file changed, 26 insertions(+), 25 deletions(-)
> Basically, I have no objection about these patches,
> but I have 2 opinions
>   - I guess we can merge #1 and #2 patches ?
>     ("as is" is very OK for me though)
>   - we don't need gpio->irq any more ?
>     (additional patch is very OK for me)
I will sent one patch removing gpio->irq too.
>
> Best regards
> ---
> Kuninori Morimoto


-- 
-George
