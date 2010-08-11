From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH] OMAP: DSS2: don't power off a panel twice
Date: Wed, 11 Aug 2010 11:09:30 +0800
Message-ID: <4C62146A.4090006@windriver.com>
References: <1281442585-6511-1-git-send-email-stanley.miao@windriver.com> <AANLkTi=rq_myAkvRJLdZ3yHHTNr7sPYF2K9pEK-QEMtB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:56896 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758017Ab0HKCze (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 22:55:34 -0400
In-Reply-To: <AANLkTi=rq_myAkvRJLdZ3yHHTNr7sPYF2K9pEK-QEMtB@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laine Walker-Avina <lwalkera@ieee.org>
Cc: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org

Laine Walker-Avina wrote:
> On Tue, Aug 10, 2010 at 5:16 AM, Stanley.Miao
> <stanley.miao@windriver.com> wrote:
>   
>> <snip>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>     
>
> Instead of adding a new variable and a bunch of extra code, I solved
> this problem on my local tree by just not doing anything if we're
> already not active. See the follwoing for the generic panel driver.
>
> diff --git a/drivers/video/omap2/displays/panel-generic.c
> b/drivers/video/omap2/displays/panel-generic.c
> index 300eff5..abc03f4 100644
> --- a/drivers/video/omap2/displays/panel-generic.c
> +++ b/drivers/video/omap2/displays/panel-generic.c
> @@ -91,9 +91,12 @@ static int generic_panel_enable(struct
> omap_dss_device *dssdev)
>
>  static void generic_panel_disable(struct omap_dss_device *dssdev)
>  {
> -	generic_panel_power_off(dssdev);
> +	if(dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
> +	{
> +		generic_panel_power_off(dssdev);
>
> -	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
> +		dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
> +	}
>  }
>
>   

Yes, This is a good idea. If we add this check into power_off(), will it 
be better ? How do you think ?

Stanley.

>  static int generic_panel_suspend(struct omap_dss_device *dssdev)
>   

