From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 4/8] DSPBRIDGE: Remove unused hDrvObject in
 bridge_[open|release]
Date: Fri, 8 Jan 2010 15:29:15 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A53042DC955C1@dlee03.ent.ti.com>
References: <1262912440-30050-1-git-send-email-omar.ramirez@ti.com>
 <4B469632.8030900@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46367 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145Ab0AHV3b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 16:29:31 -0500
In-Reply-To: <4B469632.8030900@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>

>From: Menon, Nishanth
>
>Omar Ramirez Luna had written, on 01/07/2010 07:00 PM, the following:
>> This patch removes an unused variable in bridge_open
>> and bridge_release functions, which reduces indentation.
>>
>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>> ---
>>  drivers/dsp/bridge/rmgr/drv_interface.c |   25 +++++--------------------
>>  1 files changed, 5 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
>> index 3a4d058..e551840 100644
>> --- a/drivers/dsp/bridge/rmgr/drv_interface.c
>> +++ b/drivers/dsp/bridge/rmgr/drv_interface.c
>> @@ -540,18 +540,10 @@ static void __exit bridge_exit(void)
>>  static int bridge_open(struct inode *ip, struct file *filp)
>>  {
>>  	int status = 0;
>> -	DSP_STATUS dsp_status;
>> -	HANDLE hDrvObject;
>>  	struct PROCESS_CONTEXT *pr_ctxt = NULL;
>>
>>  	GT_0trace(driverTrace, GT_ENTER, "-> bridge_open\n");
>>
>> -	dsp_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
>> -	if (DSP_FAILED(dsp_status)) {
>is this some sort of verification if the hDrvObject is valid?
>if so this is not an unused variable rt?

No, this drv object was used for inserting and removing the process
context, it doesn't work as validation at least not in this place.

>
>> -		status = -EIO;
>> -		goto err;
>> -	}
>> -
>>  	/*
>>  	 * Allocate a new process context and insert it into global
>>  	 * process context list.
>> @@ -564,7 +556,6 @@ static int bridge_open(struct inode *ip, struct file *filp)
>>
>>  	filp->private_data = pr_ctxt;
>>
>> -err:
>>  	GT_0trace(driverTrace, GT_ENTER, "<- bridge_open\n");
>>  	return status;
>>  }
>> @@ -576,8 +567,6 @@ err:
>>  static int bridge_release(struct inode *ip, struct file *filp)
>>  {
>>  	int status = 0;
>> -	DSP_STATUS dsp_status;
>> -	HANDLE hDrvObject;
>>  	struct PROCESS_CONTEXT *pr_ctxt;
>>
>>  	GT_0trace(driverTrace, GT_ENTER, "-> bridge_release\n");
>> @@ -588,15 +577,11 @@ static int bridge_release(struct inode *ip, struct file *filp)
>>  	}
>>
>>  	pr_ctxt = filp->private_data;
>> -	dsp_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
>> -	if (DSP_SUCCEEDED(dsp_status)) {
>is this some sort of verification if the hDrvObject is valid?
>if so this is not an unused variable rt?

No, this drv object was used for inserting and removing the process
context, it doesn't work as validation at least not in this place.

>> -		flush_signals(current);
>> -		DRV_RemoveAllResources(pr_ctxt);
>> -		PROC_Detach(pr_ctxt);
>> -		MEM_Free(pr_ctxt);
>> -	} else {
>> -		status = -EIO;
>> -	}
>> +	flush_signals(current);
>> +	DRV_RemoveAllResources(pr_ctxt);
>> +	PROC_Detach(pr_ctxt);
>> +	MEM_Free(pr_ctxt);
>> +
>>  	filp->private_data = NULL;
>>
>>  err:
>

- omar
