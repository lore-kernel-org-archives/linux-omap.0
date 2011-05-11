From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] arm: omap2plus: fix ads7846 pendown gpio request
Date: Wed, 11 May 2011 10:35:50 +0300
Message-ID: <4DCA3C56.9020502@compulab.co.il>
References: <1304521495-20578-1-git-send-email-grinberg@compulab.co.il>
	<4DC18B64.2020903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4DC18B64.2020903@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Thomas Weber <thomas.weber.linux@googlemail.com>, linux-arm-kernel@lists.infradead.org, Mike Rapoport <mike@compulab.co.il>
List-Id: linux-omap@vger.kernel.org

Tony,


You can fold this one to the original patch from Mike as well,

or do you want it into the rc1?



On 05/04/11 20:22, Thomas Weber wrote:

> Am 04.05.2011 17:04, schrieb Igor Grinberg:
>> introduced by: 96974a24
>> (omap: consolidate touch screen initialization among different boards)
>>
>> ads7846 driver can use either gpio_pendown or get_pendown_state()
>> callback. In case of gpio_pendown, it requests the provided gpio_pendown
>> thus resulting in double requesting that gpio:
>>
>> ads7846 spi1.0: failed to request pendown GPIO57
>> ads7846: probe of spi1.0 failed with error -16
>>
>> Fix this by restricting the gpio request to the case of
>> get_pendown_state() callback is used.
>>
>> Signed-off-by: Igor Grinberg<grinberg@compulab.co.il>
>> ---
>>   arch/arm/mach-omap2/common-board-devices.c |   20 ++++++++++----------
>>   1 files changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
>> index d57c71d..61fee80 100644
>> --- a/arch/arm/mach-omap2/common-board-devices.c
>> +++ b/arch/arm/mach-omap2/common-board-devices.c
>> @@ -83,17 +83,17 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
>>       struct spi_board_info *spi_bi =&ads7846_spi_board_info;
>>       int err;
>>
>> -    err = gpio_request(gpio_pendown, "TS PenDown");
>> -    if (err) {
>> -        pr_err("Could not obtain gpio for TS PenDown: %d\n", err);
>> -        return;
>> -    }
>> -
>> -    gpio_direction_input(gpio_pendown);
>> -    gpio_export(gpio_pendown, 0);
>> +    if (board_pdata&&  board_pdata->get_pendown_state) {
>> +        err = gpio_request_one(gpio_pendown, GPIOF_IN, "TSPenDown");
>> +        if (err) {
>> +            pr_err("Couldn't obtain gpio for TSPenDown: %d\n", err);
>> +            return;
>> +        }
>> +        gpio_export(gpio_pendown, 0);
>>
>> -    if (gpio_debounce)
>> -        gpio_set_debounce(gpio_pendown, gpio_debounce);
>> +        if (gpio_debounce)
>> +            gpio_set_debounce(gpio_pendown, gpio_debounce);
>> +    }
>>
>>       ads7846_config.gpio_pendown = gpio_pendown;
>>
> Tested-by: Thomas Weber <weber@corscience.de>
>
> On Devkit8000.
>

-- 
Regards,
Igor.
