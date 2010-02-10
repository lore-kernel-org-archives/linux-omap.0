From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: RE: [PATCH] DSPBRIDGE: check pointer before calling Proc_Detach
Date: Wed, 10 Feb 2010 11:14:50 -0600
Message-ID: <B852767254C5C94EBB1040EE0EFA06008C9126AA@dlee01.ent.ti.com>
References: <1265318253-20308-1-git-send-email-omar.ramirez@ti.com>
 <1265809659.30481.52.camel@sanganak>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54517 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755279Ab0BJRPY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 12:15:24 -0500
In-Reply-To: <1265809659.30481.52.camel@sanganak>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>



>-----Original Message-----
>From: Ameya Palande [mailto:ameya.palande@nokia.com]
>Sent: Wednesday, February 10, 2010 7:48 AM
>To: Ramirez Luna, Omar
>Cc: linux-omap; Doyu Hiroshi (Nokia-D/Helsinki); Contreras Felipe (Nokia-
>D/Helsinki); Menon, Nishanth; Ramos Falcon, Ernesto
>Subject: Re: [PATCH] DSPBRIDGE: check pointer before calling Proc_Detach
>
>Hi,
>
>On Thu, 2010-02-04 at 22:17 +0100, ext Omar Ramirez Luna wrote:
>> From: Ernest Ramos Falcon <ernesto@ti.com>
>>
>> This patch adds a check before calling Proc_Detach, otherwise
>> in case a failure occurs on PROC_Attach and hProcessor is
>> invalid when the userspace task closes its handle, unexpected
>> behavior might be seen as this pointer is dereferenced in
>> PROC_Detach.
>>
>> Signed-off-by: Ernest Ramos Falcon <ernesto@ti.com>
>> ---
>>  drivers/dsp/bridge/rmgr/drv_interface.c |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c
>b/drivers/dsp/bridge/rmgr/drv_interface.c
>> index 32aff66..b0f0d93 100644
>> --- a/drivers/dsp/bridge/rmgr/drv_interface.c
>> +++ b/drivers/dsp/bridge/rmgr/drv_interface.c
>> @@ -539,7 +539,8 @@ static int bridge_release(struct inode *ip, struct
>file *filp)
>>  	pr_ctxt = filp->private_data;
>>  	flush_signals(current);
>>  	DRV_RemoveAllResources(pr_ctxt);
>> -	PROC_Detach(pr_ctxt);
>> +	if (pr_ctxt->hProcessor)
>> +		PROC_Detach(pr_ctxt);
>>  	MEM_Free(pr_ctxt);
>>
>>  	filp->private_data = NULL;
>
>I guess PROC_Detach already checks for a valid hProcessor handle!
>Why we need this check here again?
>
Sorry, I think this applied for different version of dspbridge.


>Also if you go ahead with this patch, then how are you going to cover a
>use case where userspace application calls PROC_Attach() which fails,
>but without checking the failure userspace application calls
>PROC_Detach()!
>
PROC_Detach can not be called directly from user space, is deprecated; the only place where this is function is called is bridge_release, so nothing would happen. Anyway, dismiss this patch.

>Cheers,
>Ameya.

