From: "Franklin S Cooper Jr." <fcooper@ti.com>
Subject: Re: [PATCH v3 1/5] pwms: pwm-ti*: Remove support for local clock
 gating
Date: Mon, 29 Feb 2016 16:30:53 -0600
Message-ID: <56D4C69D.1090100@ti.com>
References: <1456439796-28546-1-git-send-email-fcooper@ti.com>
 <1456439796-28546-2-git-send-email-fcooper@ti.com>
 <20160229220444.GQ13417@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160229220444.GQ13417@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: paul@pwsan.com, t-kristo@ti.com, vigneshr@ti.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 02/29/2016 04:04 PM, Tony Lindgren wrote:
> * Franklin S Cooper Jr <fcooper@ti.com> [160225 14:37]:
>> The PWMSS local clock gating registers have no real purpose on OMAP ARM
>> devices. These registers were left over registers from DSP IP where the
>> PRCM doesn't exist. There is a silicon bug where gating and ungating clocks
>> don't function properly. TRMs will be update to indicate that these
>> registers shouldn't be touched.
>>
>> Therefore, all code that accesses the PWMSS_CLKCONFIG or PWMSS_CLKSTATUS
>> will be removed by this patch with zero loss of functionality by the ECAP
>> and EPWM drivers.
>> @@ -243,40 +240,15 @@ static int ecap_pwm_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	pm_runtime_enable(&pdev->dev);
>> -	pm_runtime_get_sync(&pdev->dev);
>> -
>> -	status = pwmss_submodule_state_change(pdev->dev.parent,
>> -			PWMSS_ECAPCLK_EN);
>> -	if (!(status & PWMSS_ECAPCLK_EN_ACK)) {
>> -		dev_err(&pdev->dev, "PWMSS config space clock enable failed\n");
>> -		ret = -EINVAL;
>> -		goto pwmss_clk_failure;
>> -	}
>> -
>> -	pm_runtime_put_sync(&pdev->dev);
>>  
>>  	platform_set_drvdata(pdev, pc);
>>  	return 0;
>> -
>> -pwmss_clk_failure:
>> -	pm_runtime_put_sync(&pdev->dev);
>> -	pm_runtime_disable(&pdev->dev);
>> -	pwmchip_remove(&pc->chip);
>> -	return ret;
>>  }
> Hmm but why are you also removing the pm_runtime calls? Those
> actually do take care of gating the clocks via the interconnect
> level code that is hwmod in this case.
I removed all PM runtime calls that revolved around
pwmss_submodule_state_change. Originally the driver would do
a pm_runtime_get_sync then call pwmss_submodule_state_change
and then immediately call pm_runtime_put_sync. Without
pwmss_submodule_state_change those calls would be
meaningless.  I also removed pm_runtime calls in error paths
that no longer existed.

Within ecap and epwm driver pm_runtime_get is done when
pwm_enable is called  and pm_runtime_sync calls are done
when pwm_disable is called. Similar pm_runtime_get and
pm_runtime_sync calls are done in functions that ended up
touching register's within the IP.
>
> Regards,
>
> Tony
