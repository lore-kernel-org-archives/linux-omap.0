From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 4/8] DSPBRIDGE: Remove unused hDrvObject in bridge_[open|release]
Date: Fri, 8 Jan 2010 15:37:47 -0600
Message-ID: <4B47A5AB.6080001@ti.com>
References: <1262912440-30050-1-git-send-email-omar.ramirez@ti.com> <4B469632.8030900@ti.com> <27F9C60D11D683428E133F85D2BB4A53042DC955C1@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39079 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752458Ab0AHViR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Jan 2010 16:38:17 -0500
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53042DC955C1@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>

Ramirez Luna, Omar had written, on 01/08/2010 03:29 PM, the following:
>> From: Menon, Nishanth
>>
>> Omar Ramirez Luna had written, on 01/07/2010 07:00 PM, the following:
>>> This patch removes an unused variable in bridge_open
>>> and bridge_release functions, which reduces indentation.
>>>
>>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>>> ---
>>>  drivers/dsp/bridge/rmgr/drv_interface.c |   25 +++++--------------------
>>>  1 files changed, 5 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
>>> index 3a4d058..e551840 100644
>>> --- a/drivers/dsp/bridge/rmgr/drv_interface.c
>>> +++ b/drivers/dsp/bridge/rmgr/drv_interface.c
>>> @@ -540,18 +540,10 @@ static void __exit bridge_exit(void)
>>>  static int bridge_open(struct inode *ip, struct file *filp)
>>>  {
>>>  	int status = 0;
>>> -	DSP_STATUS dsp_status;
>>> -	HANDLE hDrvObject;
>>>  	struct PROCESS_CONTEXT *pr_ctxt = NULL;
>>>
>>>  	GT_0trace(driverTrace, GT_ENTER, "-> bridge_open\n");
>>>
>>> -	dsp_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
>>> -	if (DSP_FAILED(dsp_status)) {
>> is this some sort of verification if the hDrvObject is valid?
>> if so this is not an unused variable rt?
> 
> No, this drv object was used for inserting and removing the process
> context, it doesn't work as validation at least not in this place.
thanks.
Acked-by: Nishanth Menon <nm@ti.com>

> 
>>> -		status = -EIO;
>>> -		goto err;
>>> -	}
>>> -
>>>  	/*
>>>  	 * Allocate a new process context and insert it into global
>>>  	 * process context list.
>>> @@ -564,7 +556,6 @@ static int bridge_open(struct inode *ip, struct file *filp)
>>>
>>>  	filp->private_data = pr_ctxt;
>>>
>>> -err:
>>>  	GT_0trace(driverTrace, GT_ENTER, "<- bridge_open\n");
>>>  	return status;
>>>  }
>>> @@ -576,8 +567,6 @@ err:
>>>  static int bridge_release(struct inode *ip, struct file *filp)
>>>  {
>>>  	int status = 0;
>>> -	DSP_STATUS dsp_status;
>>> -	HANDLE hDrvObject;
>>>  	struct PROCESS_CONTEXT *pr_ctxt;
>>>
>>>  	GT_0trace(driverTrace, GT_ENTER, "-> bridge_release\n");
>>> @@ -588,15 +577,11 @@ static int bridge_release(struct inode *ip, struct file *filp)
>>>  	}
>>>
>>>  	pr_ctxt = filp->private_data;
>>> -	dsp_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
>>> -	if (DSP_SUCCEEDED(dsp_status)) {
>> is this some sort of verification if the hDrvObject is valid?
>> if so this is not an unused variable rt?
> 
> No, this drv object was used for inserting and removing the process
> context, it doesn't work as validation at least not in this place.
> 
>>> -		flush_signals(current);
>>> -		DRV_RemoveAllResources(pr_ctxt);
>>> -		PROC_Detach(pr_ctxt);
>>> -		MEM_Free(pr_ctxt);
>>> -	} else {
>>> -		status = -EIO;
>>> -	}
>>> +	flush_signals(current);
>>> +	DRV_RemoveAllResources(pr_ctxt);
>>> +	PROC_Detach(pr_ctxt);
>>> +	MEM_Free(pr_ctxt);
>>> +
>>>  	filp->private_data = NULL;
>>>
>>>  err:
> 
> - omar


-- 
Regards,
Nishanth Menon
