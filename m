From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v3 0/4] AM437x: Add rtc-only + DDR mode support
Date: Tue, 9 Apr 2019 09:29:33 +0530
Message-ID: <643643f2-c855-5cb6-79b5-96a4f9752955@ti.com>
References: <20190403045742.2243-1-j-keerthy@ti.com>
 <20190408172654.GL49658@atomide.com> <20190408174349.GM49658@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190408174349.GM49658@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com, d-gerlach@ti.com, t-kristo@ti.com, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 08/04/19 11:13 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [190408 10:26]:
>> * Keerthy <j-keerthy@ti.com> [190402 21:57]:
>>> Changes in v3:
>>>
>>>    * Exported out omap_rtc_poweroff_program function & removed
>>>      the patch to add a generic rtc interface as it is specific
>>>      to am43 at the moment.
>>
>> Thanks I'll be applying this series into omap-for-v5.2/am4-pm
>> today.
> 
> Sorry correction for the branch named above. I noticed a build
> warning and folded in the following fix. We need to return
> -EINVAL if tm2bcd() fails like we do elsewhere in the driver.
> 
> So I just pushed out a new branch omap-for-v5.2/am4-pm-v2.
> Please just ignore the earlier branch omap-for-v5.2/am4-pm.

Thanks Tony!

> 
> Regards,
> 
> Tony
> 
> 8< --------------------
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -447,7 +447,7 @@ int omap_rtc_power_off_program(struct device *dev)
>   	if (tm2bcd(&tm) < 0) {
>   		dev_err(&rtc->rtc->dev, "power off failed\n");
>   		rtc->type->lock(rtc);
> -		return;
> +		return -EINVAL;
>   	}
>   
>   	rtc_wait_not_busy(rtc);
> 
