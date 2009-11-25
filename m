From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 6/9] DSPBRIDGE: Remove DPC, create, destroy and schedule
 wrappers
Date: Wed, 25 Nov 2009 17:05:03 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A530426F26882@dlee03.ent.ti.com>
References: <1259023830-7557-1-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-2-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-3-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-4-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-5-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-6-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-7-git-send-email-omar.ramirez@ti.com>
 <4B0DB0F1.7010506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46339 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759893AbZKYXFB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 18:05:01 -0500
In-Reply-To: <4B0DB0F1.7010506@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Artem Bityutskiy <dedekind1@gmail.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

>From: Menon, Nishanth
>
>> +/* The DPC object, passed to our priority event callback routine: */
>You may want to follow linux coding style. and not loose info from the
>comments.
>
>Documentation/kernel-doc-nano-HOWTO.txt

This file is removed anyway, I can keep that for later comment cleanups though.

>
>
>> +struct DPC_OBJECT {
>> +       u32 dwSignature;        /* Used for object validation.   */
>> +       void *pRefData;         /* Argument for client's DPC.    */
>> +       DPC_PROC pfnDPC;        /* Client's DPC.                 */
>> +       u32 numRequested;       /* Number of requested DPC's.      */
>> +       u32 numScheduled;       /* Number of executed DPC's.      */
>> +       struct tasklet_struct dpc_tasklet;
>[...]

Removed
>> diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
>> index 96a5aa6..60dbc62 100644
>> --- a/drivers/dsp/bridge/wmd/io_sm.c
>> +++ b/drivers/dsp/bridge/wmd/io_sm.c
>> @@ -251,7 +251,26 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
>>
>>         if (devType == DSP_UNIT) {
>>                 /* Create a DPC object: */
>> -               status = DPC_Create(&pIOMgr->hDPC, IO_DPC, (void *)pIOMgr);
>> +               MEM_AllocObject(pIOMgr->hDPC, struct DPC_OBJECT,
>> +                               IO_MGRSIGNATURE);
>> +               if (pIOMgr->hDPC) {
>> +                       tasklet_init(&pIOMgr->hDPC->dpc_tasklet,
>> +                               DPC_DeferredProcedure, (u32)pIOMgr->hDPC);
>> +                       /* Fill out our DPC Object: */
>> +                       pIOMgr->hDPC->pRefData = (void *)pIOMgr;
>> +                       pIOMgr->hDPC->pfnDPC = IO_DPC;
>> +                       pIOMgr->hDPC->numRequested = 0;
>> +                       pIOMgr->hDPC->numScheduled = 0;
>> +#ifdef DEBUG
>> +                       pIOMgr->hDPC->numRequestedMax = 0;
>> +                       pIOMgr->hDPC->cEntryCount = 0;
>> +#endif
>
>Do you want to do a memset with 0 instead and fill up the deltas?

This was an intermediate step before removing the dpc thing, in the last patch this looks like 
[snip]
+		/* Create an IO DPC */
+		tasklet_init(&pIOMgr->dpc_tasklet, IO_DPC, (u32)pIOMgr);
+
+		/* Initialize DPC counters */
+		pIOMgr->dpc_req = 0;
+		pIOMgr->dpc_sched = 0;
+
+		spin_lock_init(&pIOMgr->dpc_lock);
[snip]
>> +#ifdef DEBUG
>> +                       if (hIOMgr->hDPC->numRequested >
>> +                          hIOMgr->hDPC->numScheduled +
>> +                          hIOMgr->hDPC->numRequestedMax) {
>> +                               hIOMgr->hDPC->numRequestedMax =
>> +                                       hIOMgr->hDPC->numRequested -
>> +                                       hIOMgr->hDPC->numScheduled;
>a) is this safe?
>b) {} for a one liner ? mebbe the level of indentation is too much?

This was removed.

>
>> +                       }
>> +#endif
>[...]
>
>> --- a/drivers/dsp/bridge/wmd/ue_deh.c
>> +++ b/drivers/dsp/bridge/wmd/ue_deh.c
>> @@ -91,8 +91,27 @@ DSP_STATUS WMD_DEH_Create(OUT struct DEH_MGR **phDehMgr,
>>                         status = NTFY_Create(&pDehMgr->hNtfy);
>>
>>                 /* Create a DPC object. */
>> -               status = DPC_Create(&pDehMgr->hMmuFaultDpc, MMU_FaultDpc,
>> -                                  (void *)pDehMgr);
>> +               MEM_AllocObject(pDehMgr->hMmuFaultDpc, struct DPC_OBJECT,
>> +                               SIGNATURE);
>> +               if (pDehMgr->hMmuFaultDpc) {
>> +                       tasklet_init(&pDehMgr->hMmuFaultDpc->dpc_tasklet,
>> +                               DPC_DeferredProcedure,
>> +                               (u32)pDehMgr->hMmuFaultDpc);
>> +                       /* Fill out DPC Object */
>> +                       pDehMgr->hMmuFaultDpc->pRefData = (void *)pDehMgr;
>> +                       pDehMgr->hMmuFaultDpc->pfnDPC = MMU_FaultDpc;
>> +                       pDehMgr->hMmuFaultDpc->numRequested = 0;
>> +                       pDehMgr->hMmuFaultDpc->numScheduled = 0;
>> +#ifdef DEBUG
>> +                       pDehMgr->hMmuFaultDpc->numRequestedMax = 0;
>> +                       pDehMgr->hMmuFaultDpc->cEntryCount = 0;
>> +#endif
>> +                       spin_lock_init(&pDehMgr->hMmuFaultDpc->dpc_lock);
>> +               } else {
>> +                       DBG_Trace(GT_6CLASS, "DEH DPC Create: DSP_EMEMORY\n");
>> +                       status = DSP_EMEMORY;
>I think you give up at this point right? why continue the code? wont it
>be easier if your code did:
>if (!pDehMgr->hMmuFaultDpc) {
>	DBG_Trace(GT_6CLASS, "DEH DPC Create: DSP_EMEMORY\n");
>	return DSP_EMEMORY;
>}
>  do rest of code..
>

In the end (patch 9) this looks like:
+		/* Create a MMUfault DPC */
+		tasklet_init(&pDehMgr->dpc_tasklet, MMU_FaultDpc, (u32)pDehMgr);

I tried to split the changes to be cut and paste versions, and then cleaning up from there... like removing DeferredProcedure and replacing it for the actual DPC (IO_DPC or MMUfault), then removing DPC structure to avoid x->y->z things, I was trying to avoid a big patch with all the changes.

Thanks for the comments.

- omar
