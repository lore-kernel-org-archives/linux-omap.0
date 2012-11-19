From: Tushar Behera <tushar.behera@linaro.org>
Subject: Re: [PATCH] OMAPDSS: OMAPFB: Fix possible null pointer dereferencing
Date: Mon, 19 Nov 2012 15:11:55 +0530
Message-ID: <50A9FEE3.70002@linaro.org>
References: <1353301815-21277-1-git-send-email-tushar.behera@linaro.org> <50A9F151.3010607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54076 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451Ab2KSJl0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Nov 2012 04:41:26 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so3344057pbc.19
        for <linux-omap@vger.kernel.org>; Mon, 19 Nov 2012 01:41:25 -0800 (PST)
In-Reply-To: <50A9F151.3010607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, archit@ti.com, patches@linaro.org

On 11/19/2012 02:14 PM, Tomi Valkeinen wrote:
> On 2012-11-19 07:10, Tushar Behera wrote:
>> If display is NULL, display->output would lead to kernel panic.
>>
>> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
>> ---
>>  drivers/video/omap2/omapfb/omapfb-ioctl.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
>> index 55a39be..532a31b 100644
>> --- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
>> +++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
>> @@ -787,7 +787,7 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
>>  
>>  	case OMAPFB_WAITFORVSYNC:
>>  		DBG("ioctl WAITFORVSYNC\n");
>> -		if (!display && !display->output && !display->output->manager) {
>> +		if (!display || !display->output || !display->output->manager) {
>>  			r = -EINVAL;
>>  			break;
>>  		}
>>
> 
> Thanks, good catch. However, the patch description is not very good.

I agree.

> If you agree with the change, I'll apply the patch with the description:
> 

Please go ahead with the description that you have written here.

> 
> OMAPFB: Fix possible null pointer dereferencing                          
>                                                                          
> Commit 952cbaaa9b8beacc425f9aedf370468cbb737a2c (OMAPFB: Change          
> dssdev->manager references) added checks for OMAPFB_WAITFORVSYNC ioctl   
> to verify that the display, output and overlay manager exist. However,   
> the code erroneously uses && for each part, which means that             
> OMAPFB_WAITFORVSYNC may crash the kernel if no display, output or        
> manager is associated with the framebuffer.                              
>                                                                          
> This patch fixes the issue by using ||.                                  
> 
> 
>  Tomi
> 
> 

Thanks.

-- 
Tushar Behera
