From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH v2 15/20] DSPBRIDGE: trivial cleanup and indentation for
 	io_sm
Date: Tue, 1 Dec 2009 12:16:37 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A530426FE2A96@dlee03.ent.ti.com>
References: <1259618101-8972-1-git-send-email-omar.ramirez@ti.com>
	 <1259618101-8972-8-git-send-email-omar.ramirez@ti.com>
	 <1259618101-8972-9-git-send-email-omar.ramirez@ti.com>
	 <1259618101-8972-10-git-send-email-omar.ramirez@ti.com>
	 <1259618101-8972-11-git-send-email-omar.ramirez@ti.com>
	 <1259618101-8972-12-git-send-email-omar.ramirez@ti.com>
	 <1259618101-8972-13-git-send-email-omar.ramirez@ti.com>
	 <1259618101-8972-14-git-send-email-omar.ramirez@ti.com>
	 <1259618101-8972-15-git-send-email-omar.ramirez@ti.com>
	 <1259618101-8972-16-git-send-email-omar.ramirez@ti.com>
 <5ec8ebd50911302243h338558eam7378b14de3fbaef4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44449 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753126AbZLASQd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 13:16:33 -0500
In-Reply-To: <5ec8ebd50911302243h338558eam7378b14de3fbaef4@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

>From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
>
>On Mon, Nov 30, 2009 at 11:54 PM, Omar Ramirez Luna <omar.ramirez@ti.c=
om> wrote:
>> Remove duplicate set of braces from if statement and reduce
>> indentation.
>
>> diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd=
/io_sm.c
>> index af31831..96a5aa6 100644
>> --- a/drivers/dsp/bridge/wmd/io_sm.c
>> +++ b/drivers/dsp/bridge/wmd/io_sm.c
>> @@ -115,7 +115,7 @@ struct IO_MGR {
>> =A0 =A0 =A0 =A0/* private extnd proc info; mmu setup */
>> =A0 =A0 =A0 =A0struct MGR_PROCESSOREXTINFO extProcInfo;
>> =A0 =A0 =A0 =A0struct CMM_OBJECT *hCmmMgr; =A0 =A0 /* Shared Mem Mng=
r =A0 =A0 =A0 =A0 =A0 =A0*/
>May be to fix commentary indentation?
>> - =A0 =A0 =A0 struct work_struct io_workq; =A0 =A0 /*workqueue */
>> + =A0 =A0 =A0 struct work_struct io_workq; =A0 =A0 /*workqueue */
>I didn't get why the space after /* still absent.

Removed on the next patch (trivial fix for multiline comments on io_sm)
-	struct CMM_OBJECT *hCmmMgr; 	/* Shared Mem Mngr	      */
-	struct work_struct io_workq;     /*workqueue */
+	struct CMM_OBJECT *hCmmMgr; 	/* Shared Mem Mngr */
+	struct work_struct io_workq;     /* workqueue */

>
>> @@ -319,7 +321,7 @@ DSP_STATUS WMD_IO_Destroy(struct IO_MGR *hIOMgr)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SYNC_DeleteCS(hIOMgr->hCSObj); =A0/* =
Leak Fix. */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Free this IO manager object: */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MEM_FreeObject(hIOMgr);
>> - =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 } else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D DSP_EHANDLE;
>Probably } else { ... } would be better. (1)
>

Agree

>> @@ -609,7 +608,7 @@ func_cont1:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 =A0/* Copy remaining entries from CDB. All entries are=
 1 MB and should not
>> + =A0 =A0 =A0 /* Copy remaining entries from CDB. All entries are 1 =
MB and should not
>> =A0 =A0 =A0 =A0 * conflict with SHM entries on MPU or DSP side */
>In previous hunks you fixed * ... */. Why not here? (2)

trivial fix for multiline comments on io_sm, I tried to split the two p=
atches because I thought there would be a lot of changes=20
0015-DSPBRIDGE-trivial-cleanup-and-indentation-for-io_sm.patch
0016-DSPBRIDGE-trivial-fix-for-multiline-comments-on-io_.patch

But I guess I can join them into one patch and resend (btw fixed on pat=
ch 16)

>
>> @@ -1002,15 +995,10 @@ void IO_DPC(IN OUT void *pRefData)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PrintDSPDebugTrace(pI=
OMgr);
>> =A0 =A0 =A0 =A0}
>> =A0#endif
>> -
>> -#ifndef DSP_TRACEBUF_DISABLED
>> - =A0 =A0 =A0 PrintDSPDebugTrace(pIOMgr);
>> -#endif
>> =A0func_end:
>> =A0 =A0 =A0 =A0return;
>No comments about this changes. (Intuitively I understand, but...)
>
>> @@ -1028,29 +1016,28 @@ irqreturn_t IO_ISR(int irq, IN void *pRefDat=
a)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> - =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 } else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Ensure that, if WMD didn't claim i=
t, the IRQ is shared. */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DBC_Ensure(hIOMgr->fSharedIRQ);
>The same as in (1).

Agree

>
>> @@ -1380,10 +1365,10 @@ static void NotifyChnlComplete(struct CHNL_O=
BJECT *pChnl,
>> =A0 =A0 =A0 =A0 =A0 !pChnl->pIOCompletions || !pChirp)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto func_end;
>>
>> - =A0 =A0 =A0 =A0/* =A0Note: we signal the channel event only if the=
 queue of IO
>> - =A0 =A0 =A0 =A0 * =A0completions is empty. =A0If it is not empty, =
the event is sure to be
>> - =A0 =A0 =A0 =A0 * =A0signalled by the only IO completion list cons=
umer:
>> - =A0 =A0 =A0 =A0 * =A0WMD_CHNL_GetIOC(). =A0*/
>> + =A0 =A0 =A0 /* =A0Note: we signal the channel event only if the qu=
eue of IO
>> + =A0 =A0 =A0 =A0* =A0completions is empty. =A0If it is not empty, t=
he event is sure to be
>> + =A0 =A0 =A0 =A0* =A0signalled by the only IO completion list consu=
mer:
>> + =A0 =A0 =A0 =A0* =A0WMD_CHNL_GetIOC(). =A0*/
>The same as in (2).
>

=46ixed on patch 16, will join both of the patches and resend

>--
>With Best Regards,
>Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
