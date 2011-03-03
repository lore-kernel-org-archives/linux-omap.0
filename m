From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC 3/3] omap3+: sr: Reuse sr_[start|stop]_vddautocomp functions
Date: Thu, 03 Mar 2011 06:22:36 +0530
Message-ID: <4D6EE654.1090207@ti.com>
References: <1299081445-27938-1-git-send-email-jhnikula@gmail.com>	<1299081445-27938-4-git-send-email-jhnikula@gmail.com>	<4D6E775D.7040107@ti.com> <87vd01t4ex.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:42014 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752316Ab1CCAwo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 19:52:44 -0500
Received: by mail-vx0-f175.google.com with SMTP id 7so554867vxd.20
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 16:52:43 -0800 (PST)
In-Reply-To: <87vd01t4ex.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>

Kevin Hilman wrote, on 03/03/2011 06:18 AM:
> Nishanth Menon<nm@ti.com>  writes:
>
>> Jarkko Nikula wrote, on 03/02/2011 09:27 PM:
>>> sr_start_vddautocomp and sr_stop_autocomp functions can be reused from
>>> omap_sr_enable, omap_sr_disable and omap_sr_disable_reset_volt and by
>>> adding one additional argument sr_stop_autocomp.
>>>
>>> Signed-off-by: Jarkko Nikula<jhnikula@gmail.com>
>>> ---
>>>    arch/arm/mach-omap2/smartreflex.c |   41 ++++++------------------------------
>>>    1 files changed, 7 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
>>> index 11741d8..7e6002f 100644
>>> --- a/arch/arm/mach-omap2/smartreflex.c
>>> +++ b/arch/arm/mach-omap2/smartreflex.c
>>> @@ -227,7 +227,7 @@ static void sr_start_vddautocomp(struct omap_sr *sr)
>>>    		sr->autocomp_active = true;
>>>    }
>>>
>>> -static void sr_stop_vddautocomp(struct omap_sr *sr)
>>> +static void sr_stop_vddautocomp(struct omap_sr *sr, int is_volt_reset)
>>>    {
>>>    	if (!sr->autocomp_active)
>>>    		return;
>>> @@ -239,7 +239,7 @@ static void sr_stop_vddautocomp(struct omap_sr *sr)
>>>    		return;
>>>    	}
>>>
>>> -	if (!sr_class->disable(sr->voltdm, 1))
>>> +	if (!sr_class->disable(sr->voltdm, is_volt_reset))
>>>    		sr->autocomp_active = false;
>>>    }
>>>
>>> @@ -681,16 +681,7 @@ void omap_sr_enable(struct voltagedomain *voltdm)
>>>    		return;
>>>    	}
>>>
>>> -	if (!sr->autocomp_active)
>>> -		return;
>>> -
>>> -	if (!sr_class || !(sr_class->enable) || !(sr_class->configure)) {
>>> -		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
>>> -			"registered\n", __func__);
>>> -		return;
>>> -	}
>>> -
>>> -	sr_class->enable(voltdm);
>>> +	sr_start_vddautocomp(sr);
>>>    }
>>>
>>>    /**
>>> @@ -714,16 +705,7 @@ void omap_sr_disable(struct voltagedomain *voltdm)
>>>    		return;
>>>    	}
>>>
>>> -	if (!sr->autocomp_active)
>>> -		return;
>>> -
>>> -	if (!sr_class || !(sr_class->disable)) {
>>> -		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
>>> -			"registered\n", __func__);
>>> -		return;
>>> -	}
>>> -
>>> -	sr_class->disable(voltdm, 0);
>>> +	sr_stop_vddautocomp(sr, 0);
>>>    }
>>>
>>>    /**
>>> @@ -747,16 +729,7 @@ void omap_sr_disable_reset_volt(struct voltagedomain *voltdm)
>>>    		return;
>>>    	}
>>>
>>> -	if (!sr->autocomp_active)
>>> -		return;
>>> -
>>> -	if (!sr_class || !(sr_class->disable)) {
>>> -		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
>>> -			"registered\n", __func__);
>>> -		return;
>>> -	}
>>> -
>>> -	sr_class->disable(voltdm, 1);
>>> +	sr_stop_vddautocomp(sr, 1);
>>>    }
>>>
>>>    /**
>>> @@ -809,7 +782,7 @@ static int omap_sr_autocomp_store(void *data, u64 val)
>>>    	}
>>>
>>>    	if (!val)
>>> -		sr_stop_vddautocomp(sr_info);
>>> +		sr_stop_vddautocomp(sr_info, 1);
>>>    	else
>>>    		sr_start_vddautocomp(sr_info);
>>>
>>> @@ -976,7 +949,7 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
>>>    	}
>>>
>>>    	if (sr_info->autocomp_active)
>>> -		sr_stop_vddautocomp(sr_info);
>>> +		sr_stop_vddautocomp(sr_info, 1);
>>>
>>>    	list_del(&sr_info->node);
>>>    	iounmap(sr_info->base);
>>
>> Looks like a nice cleanup to me.
>>
>> if the motivation of patch 1/3 is to do this cleanup, I am altogether
>> for it (lesser code == lesser bugs ;) ). btw, this should not impact
>> class1.5 either - core sr.c sequencing has not been modified in sr1.5
>> :)
>>
>> Depending on Kevin's views, either you or I or both of us can rebase
>> depending on whose ever series gets pulled in first.. (either should
>> be a very minimal effort).
>
> Nishanth,
>
> I'd prefer if you handle these.  You can add them to the fixup/cleanup
> part of your SR1.5 series.

ok will pull this in as part of sr1.5 series if no further review comments.


-- 
Regards,
Nishanth Menon
