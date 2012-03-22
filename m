From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH RFC] usb: musb: omap: fix the error check for pm_runtime_get_sync
Date: Thu, 22 Mar 2012 19:06:11 +0530
Message-ID: <4F6B2ACB.60302@ti.com>
References: <1332400686-27674-1-git-send-email-shubhrajyoti@ti.com> <4F6B1E2D.8020802@mvista.com> <20120322125550.GG32368@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:38866 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753875Ab2CVNgY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Mar 2012 09:36:24 -0400
Received: by mail-gy0-f182.google.com with SMTP id r20so2156008ghr.41
        for <linux-omap@vger.kernel.org>; Thu, 22 Mar 2012 06:36:23 -0700 (PDT)
In-Reply-To: <20120322125550.GG32368@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>


>>    You haven't run it thru scripts/checkpatch.pl either, I guess?
>>

Actually modified the patch a little afterwards.
>>>  drivers/usb/musb/omap2430.c |    5 +++--
>>>  1 files changed, 3 insertions(+), 2 deletions(-)
>>> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
>>> index 2ae0bb3..e5dd18f 100644
>>> --- a/drivers/usb/musb/omap2430.c
>>> +++ b/drivers/usb/musb/omap2430.c
>> [...]
>>> @@ -301,7 +302,7 @@ static int omap2430_musb_init(struct musb *musb)
>>>
>>>  	status = pm_runtime_get_sync(dev);
>>>  	if (status<  0) {
>>> -		dev_err(dev, "pm_runtime_get_sync FAILED");
>>> +		dev_err(dev, "pm_runtime_get_sync FAILED %d \n",status);
>>    If I don't mistake, scripts/checkpatch.pl should warn about
>> unneeded spaces before '\n'. And also about missing spaces after
>> commas.
> I fixed in my branch, thanks
>
Thanks Felipe,
Anyways resent the patch.

