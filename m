From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH 2/3] DSPBRIDGE: Move resource cleanup to bridge_release
Date: Thu, 06 Aug 2009 21:12:00 +0300
Message-ID: <4A7B1CF0.5000603@nokia.com>
References: <1249478717-4446-1-git-send-email-ameya.palande@nokia.com> <1249478717-4446-2-git-send-email-ameya.palande@nokia.com> <B852767254C5C94EBB1040EE0EFA06006821961B@dlee01.ent.ti.com> <4A79FF1A.6080307@nokia.com> <B852767254C5C94EBB1040EE0EFA06006821A0FC@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:51009 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbZHFSMX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 14:12:23 -0400
In-Reply-To: <B852767254C5C94EBB1040EE0EFA06006821A0FC@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Ramos Falcon, Ernesto" <ernesto@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Tereshonkov Roman (Nokia-D/Helsinki)" <roman.tereshonkov@nokia.com>, "Moogi, Suyog" <suyog@ti.com>

Hi Ernesto,

ext Ramos Falcon, Ernesto wrote:
> Hi Ameya,
> 
>> -----Original Message-----
>> From: Ameya Palande [mailto:ameya.palande@nokia.com]
>> Sent: Wednesday, August 05, 2009 4:52 PM
>> To: Ramos Falcon, Ernesto
>> Cc: linux-omap@vger.kernel.org; Doyu Hiroshi (Nokia-D/Helsinki); Guzman
>> Lugo, Fernando; Ramirez Luna, Omar; Tereshonkov Roman (Nokia-D/Helsinki);
>> Moogi, Suyog
>> Subject: Re: [PATCH 2/3] DSPBRIDGE: Move resource cleanup to
>> bridge_release
>>
>> Hi Ernesto,
>>
>> ext Ramos Falcon, Ernesto wrote:
>>> Hi,
>>>
>>> We have detected a use case where if an application creates a child
>> process using fork call, and then the child and father processes call
>> DSPProcessor_Attach() and create a new process context with new tgid; when
>> the processes are terminated, only the last process calls bridge_release
>> cleaning only the resources in the father process, leaving the child
>> resources unreleased.
>>> One solution we have seen is to perform goes through the entire process
>> context list, clean up all the resources for all terminated processes or
>> in "zombie" state, as below,
>>> DRV_GetProcCtxtList(&pCtxtclosed, (struct DRV_OBJECT *)hDrvObject);
>>> while (pCtxtclosed != NULL) {
>>> 	printk("pCtxtclosed->pid = %d\n",pCtxtclosed->pid);
>>> 	tsk = find_task_by_pid(pCtxtclosed->pid);
>>>
>>> 	if ((tsk == NULL) || (tsk->exit_state == EXIT_ZOMBIE)) {
>>>
>>> 		GT_1trace(driverTrace, GT_5CLASS,
>>> 			"***Task structure not existing for "
>>> 			 "process***%d\n", pCtxtclosed->pid);
>>> 		DRV_RemoveAllResources(pCtxtclosed);
>>> 		if (pCtxtclosed->hProcessor != NULL) {
>>> 					PROC_Detach
>>> 						 (pCtxtclosed->hProcessor);
>>> 		}
>>> 		pTmp = pCtxtclosed->next;
>>> 		DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject,
>>> 					 pCtxtclosed,
>>> 					 (void *)pCtxtclosed->pid);
>>> 	} else {
>>> 		pTmp = pCtxtclosed->next;
>>> 	}
>>> 	pCtxtclosed = pTmp;
>>> }
>>>
>>> Please let me know your comments.
>>>
>>> /Ernesto
>> Good point :)
>>
>> I would like to simplify this use case ;)
>>
>> If we call DSPProcessor_Attach() twice in the same process and kill the
>> process,
>> then it will leak memory for 1st instance of PROCESSOR object.
>>
>> When we call open() on /dev/DspBridge a new PROCESS_CONTEXT is allocated,
>> and it
>> should be allocated **only once** in bridge_open() unlike in
>> NODE_Allocate() and
>> PROC_Attach(). PROCESS_CONTEXT tracks all the resources allocated on
>> behalf of
>> an open file handle(and not the process / thread). When this handle is
>> closed
>> all these resources should be freed in bridge_release(). Accountability of
>> resources should be done using PROCESS_CONTEXT and **not pid (which will
>> be
>> different for different thread) / tgid (which will be different for parent
>> and
>> child).
>>
>> Above problem occurs because PROCESS_CONTEXT by design tracks only one
>> PROCESSOR
>> object which gets freed in bridge_release().
>>
>> Let me know your comments on this, and then we can proceed to fix this
>> issue.
>>
>> Cheers,
>> Ameya.
> You're right; I think using the PROCESS_CONTEXT to track the resources would resolve the issue. Also, with his approach we don't need to create a new context in the PROC_Attach /NODE_Allocate.
> 
> We can solve the issue by implementing a counter to track the number of calls to the PROC_Attach/Detach, so in that way we create a process handle only for the first time, and for the subsequent calls we need to return the existing handle. In the other hand PROC_Detach would be executed for the last call to this function.
> 
> I don't know yet how we would access or if there is an easy way to get the private_data as if get the pid using the "current", though.
> 
> /Ernesto

Thanks for your comment :)
I am working on this and will try to provide a solution by 10th Aug 2009.

Cheers,
Ameya.
