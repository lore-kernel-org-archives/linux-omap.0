From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH] OMAP: DSS2: don't power off a panel twice
Date: Wed, 11 Aug 2010 13:29:44 +0800
Message-ID: <4C623548.2050507@canonical.com>
References: <1281442585-6511-1-git-send-email-stanley.miao@windriver.com> <AANLkTi=rq_myAkvRJLdZ3yHHTNr7sPYF2K9pEK-QEMtB@mail.gmail.com> <4C62146A.4090006@windriver.com>
Reply-To: bryan.wu@canonical.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:37352 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304Ab0HKFaK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 01:30:10 -0400
In-Reply-To: <4C62146A.4090006@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "stanley.miao" <stanley.miao@windriver.com>
Cc: Laine Walker-Avina <lwalkera@ieee.org>, tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org

On 08/11/2010 11:09 AM, stanley.miao wrote:
> Laine Walker-Avina wrote:
>> On Tue, Aug 10, 2010 at 5:16 AM, Stanley.Miao
>> <stanley.miao@windriver.com> wrote:
>>  
>>> <snip>
>>>
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>     
>>
>> Instead of adding a new variable and a bunch of extra code, I solved
>> this problem on my local tree by just not doing anything if we're
>> already not active. See the follwoing for the generic panel driver.
>>
>> diff --git a/drivers/video/omap2/displays/panel-generic.c
>> b/drivers/video/omap2/displays/panel-generic.c
>> index 300eff5..abc03f4 100644
>> --- a/drivers/video/omap2/displays/panel-generic.c
>> +++ b/drivers/video/omap2/displays/panel-generic.c
>> @@ -91,9 +91,12 @@ static int generic_panel_enable(struct
>> omap_dss_device *dssdev)
>>
>>  static void generic_panel_disable(struct omap_dss_device *dssdev)
>>  {
>> -    generic_panel_power_off(dssdev);
>> +    if(dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
>> +    {
>> +        generic_panel_power_off(dssdev);
>>
>> -    dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
>> +        dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
>> +    }
>>  }
>>
>>   
> 
> Yes, This is a good idea. If we add this check into power_off(), will it
> be better ? How do you think ?
> 

Both you guys' patches can solve a issue here:
https://bugs.edge.launchpad.net/ubuntu/+source/linux-ti-omap/+bug/588243

Laine,

I suspect we still need whose checks in suspend/resume routines, Stanley's V2
patch should be better.

Although I did following test on my Beagle board, I failed to see any oops.
root@beagle1:/# echo 1 > /sys/devices/platform/omapfb/graphics/fb0/blank
root@beagle1:/# echo mem > /sys/power/state

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer    +86.138-1617-6545 Mobile
Ubuntu Kernel Team | Hardware Enablement Team
Canonical Ltd.      www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
