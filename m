From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH 01/14] thermal: ti-soc-thermal: fix TALERT IRQ handling
 for DRA752
Date: Wed, 11 Jul 2018 07:49:41 +0530
Message-ID: <fd458da1-75d6-84ed-838a-0495045fad77@ti.com>
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180514114302epcas1p1890ad3296302900a736262b5d67aa10e@epcas1p1.samsung.com>
 <1526298141-14045-2-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526298141-14045-2-git-send-email-b.zolnierkie@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 5/14/2018 5:12 PM, Bartlomiej Zolnierkiewicz wrote:
> .report_temperature is not set in dra752_data which
> results in temperature updates not being propagated by
> ti_bandgap_talert_irq_handler() (it doesn't make much
> sense to handle TALERT IRQ without reporting temperature
> updates to the thermal core). Fix it.

ATM no one is using TALERT as the thermal software polls on the 
temperature. No real benefit from TALERT.

TALERT is set at different temperature and software polling thresholds 
come from Device tree and i believe its best for software to go by 
polling and then act on trip points.

> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>   drivers/thermal/ti-soc-thermal/dra752-thermal-data.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
> index 33a3030..e8ab7e5 100644
> --- a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
> +++ b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
> @@ -338,6 +338,7 @@
>   	.adc_end_val = DRA752_ADC_END_VALUE,
>   	.expose_sensor = ti_thermal_expose_sensor,
>   	.remove_sensor = ti_thermal_remove_sensor,
> +	.report_temperature = ti_thermal_report_sensor_temperature,
>   	.sensors = {
>   		{
>   		.registers = &dra752_mpu_temp_sensor_registers,
> 
