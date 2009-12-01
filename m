From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 15/20] DSPBRIDGE: trivial cleanup and indentation for
	io_sm
Date: Tue, 1 Dec 2009 08:43:21 +0200
Message-ID: <5ec8ebd50911302243h338558eam7378b14de3fbaef4@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:59965 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbZLAGnR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 01:43:17 -0500
Received: by ewy19 with SMTP id 19so4596926ewy.21
        for <linux-omap@vger.kernel.org>; Mon, 30 Nov 2009 22:43:21 -0800 (PST)
In-Reply-To: <1259618101-8972-16-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Mon, Nov 30, 2009 at 11:54 PM, Omar Ramirez Luna <omar.ramirez@ti.co=
m> wrote:
> Remove duplicate set of braces from if statement and reduce
> indentation.

> diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/=
io_sm.c
> index af31831..96a5aa6 100644
> --- a/drivers/dsp/bridge/wmd/io_sm.c
> +++ b/drivers/dsp/bridge/wmd/io_sm.c
> @@ -115,7 +115,7 @@ struct IO_MGR {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* private extnd proc info; mmu setup */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct MGR_PROCESSOREXTINFO extProcInfo;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct CMM_OBJECT *hCmmMgr; =C2=A0 =C2=A0 =
/* Shared Mem Mngr =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
May be to fix commentary indentation?
> - =C2=A0 =C2=A0 =C2=A0 struct work_struct io_workq; =C2=A0 =C2=A0 /*w=
orkqueue */
> + =C2=A0 =C2=A0 =C2=A0 struct work_struct io_workq; =C2=A0 =C2=A0 /*w=
orkqueue */
I didn't get why the space after /* still absent.

> @@ -319,7 +321,7 @@ DSP_STATUS WMD_IO_Destroy(struct IO_MGR *hIOMgr)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SYNC_DeleteCS(=
hIOMgr->hCSObj); =C2=A0/* Leak Fix. */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Free this I=
O manager object: */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MEM_FreeObject=
(hIOMgr);
> - =C2=A0 =C2=A0 =C2=A0 } else
> + =C2=A0 =C2=A0 =C2=A0 } else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D DSP=
_EHANDLE;
Probably } else { ... } would be better. (1)

> @@ -609,7 +608,7 @@ func_cont1:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Copy remaining entries from CDB. All =
entries are 1 MB and should not
> + =C2=A0 =C2=A0 =C2=A0 /* Copy remaining entries from CDB. All entrie=
s are 1 MB and should not
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * conflict with SHM entries on MPU or DSP=
 side */
In previous hunks you fixed * ... */. Why not here? (2)

> @@ -1002,15 +995,10 @@ void IO_DPC(IN OUT void *pRefData)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0PrintDSPDebugTrace(pIOMgr);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0#endif
> -
> -#ifndef DSP_TRACEBUF_DISABLED
> - =C2=A0 =C2=A0 =C2=A0 PrintDSPDebugTrace(pIOMgr);
> -#endif
> =C2=A0func_end:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
No comments about this changes. (Intuitively I understand, but...)

> @@ -1028,29 +1016,28 @@ irqreturn_t IO_ISR(int irq, IN void *pRefData=
)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 } else
> + =C2=A0 =C2=A0 =C2=A0 } else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Ensure that=
, if WMD didn't claim it, the IRQ is shared. */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DBC_Ensure(hIO=
Mgr->fSharedIRQ);
The same as in (1).

> @@ -1380,10 +1365,10 @@ static void NotifyChnlComplete(struct CHNL_OB=
JECT *pChnl,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !pChnl->pIOCompletions || !pChirp)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto func_end;
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0/* =C2=A0Note: we signal the channel eve=
nt only if the queue of IO
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0completions is empty. =C2=A0If =
it is not empty, the event is sure to be
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0signalled by the only IO comple=
tion list consumer:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0WMD_CHNL_GetIOC(). =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 /* =C2=A0Note: we signal the channel event onl=
y if the queue of IO
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0completions is empty. =C2=A0If i=
t is not empty, the event is sure to be
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0signalled by the only IO complet=
ion list consumer:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0WMD_CHNL_GetIOC(). =C2=A0*/
The same as in (2).

--=20
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
