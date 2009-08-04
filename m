From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 2/2] DSPBRIDGE: introduce VMA checking for cache
 operation
Date: Tue, 4 Aug 2009 16:59:37 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A5304193E7C55@dlee03.ent.ti.com>
References: <1248250970-417-1-git-send-email-Hiroshi.DOYU@nokia.com>
 <1248250970-417-2-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53591 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933165AbZHDV7q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Aug 2009 17:59:46 -0400
In-Reply-To: <1248250970-417-2-git-send-email-Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Menon, Nishanth" <nm@ti.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

Hi Doyu-san,

>From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
>Sent: Wednesday, July 22, 2009 3:23 AM
>To: linux-omap@vger.kernel.org
>Cc: Menon, Nishanth; ameya.palande@nokia.com; Ramirez Luna, Omar; Guzman Lugo, Fernando; Kanigeri,
>Hari; Hiroshi DOYU
>Subject: [PATCH 2/2] DSPBRIDGE: introduce VMA checking for cache operation
>
>Check if the given area blongs to process virtul memory address space.
>
>Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>---
> drivers/dsp/bridge/rmgr/proc.c |   32 ++++++++++++++++++++++++++++++++
> 1 files changed, 32 insertions(+), 0 deletions(-)
>

Is this patch solving any specific issue?

>diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
>index 3a2879f..fe9dabf 100644
>--- a/drivers/dsp/bridge/rmgr/proc.c
>+++ b/drivers/dsp/bridge/rmgr/proc.c
>@@ -735,6 +735,30 @@ DSP_STATUS PROC_EnumNodes(DSP_HPROCESSOR hProcessor, OUT DSP_HNODE *aNodeTab,
> 	return status;
> }
>
>+/* Check if the given area blongs to process virtul memory address space */
>+static int memory_check_vma(unsigned long start, u32 len)
>+{
>+	int err = 0;
>+	unsigned long end;
>+	struct vm_area_struct *vma;
>+
>+	len = PAGE_ALIGN(len);
>+	end = start + len;
>+	if (end <= start)
>+		return -EINVAL;
>+
>+	down_read(&current->mm->mmap_sem);
>+
>+	vma = find_vma(current->mm, start);
>+	if (!vma || start < vma->vm_start) {
>+		pr_err("%s: no vma for %08lx %08lx\n", __func__, start, end);
>+		err = -EINVAL;
>+	}
>+
>+	up_read(&current->mm->mmap_sem);
>+
>+	return err;
>+}
>
> static DSP_STATUS proc_memory_sync(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
> 				   u32 ulSize, u32 ulFlags,
>@@ -757,6 +781,14 @@ static DSP_STATUS proc_memory_sync(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
> 		goto err_out;
> 	}
>
>+	if (memory_check_vma((u32)pMpuAddr, ulSize)) {
>+		GT_3trace(PROC_DebugMask, GT_7CLASS,
>+			  "%s: InValid address parameters\n",
>+			  __func__, pMpuAddr, ulSize);
>+		status = DSP_EHANDLE;
>+		goto err_out;
>+	}
>+
> 	(void)SYNC_EnterCS(hProcLock);
> 	MEM_FlushCache(pMpuAddr, ulSize, FlushMemType);
> 	(void)SYNC_LeaveCS(hProcLock);
>--
>1.6.0.4
>

Regards,

Omar
