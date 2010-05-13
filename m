From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] DSPBRIDGE:Fix Kernel memory poison overwritten after
	DSP_MMUFAULT
Date: Thu, 13 May 2010 14:39:04 +0300
Message-ID: <AANLkTikUc623KkBg88CYr9_Pskx_A6sqXikGEdqhhKm8@mail.gmail.com>
References: <1271177720-1299-1-git-send-email-deepak.chitriki@ti.com>
	 <496565EC904933469F292DDA3F1663E602CB215CB2@dlee06.ent.ti.com>
	 <AANLkTik46ilQPBGtsgWAMTlWrdWaaYTDC2aCYmf4iUIn@mail.gmail.com>
	 <496565EC904933469F292DDA3F1663E602CB5B99E5@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37659 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758737Ab0EMLjE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 07:39:04 -0400
Received: by mail-fx0-f46.google.com with SMTP id 6so227239fxm.19
        for <linux-omap@vger.kernel.org>; Thu, 13 May 2010 04:39:04 -0700 (PDT)
In-Reply-To: <496565EC904933469F292DDA3F1663E602CB5B99E5@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Menon, Nishanth" <nm@ti.com>

On Thu, May 13, 2010 at 12:09 AM, Guzman Lugo, Fernando
<fernando.lugo@ti.com> wrote:
>> If you are referring to this patch:
>> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-
>> 2.6.git;a=commit;h=26ad62f03578a12e942d8bb86d0e52ef1afdee22
>
> Yes, that's the patch. Could you make sure that the GPT8 interrupt is generated before acking MMU fault interrupt?

I'll try tomorrow when I have access to the hw.

>> I tried to backport it to minimize the changes to a reproducible
>> test-case. I guess in the l-o branch the commit would be dd1fd0b.
>> Unfortunately that didn't fix the corruption. So I don't by that GPT8
>> theory.
>>
>> > - we don't need allocate memory for dummy_va_addr, if some patch should
>> be created should be the patch to remove dummy_va_addr allocation and
>> deletion.
>>
>> I tried that, and that actually fixes the corruption for me (passing 0
>> to hw_mmu_tlb_add).
>
> I think first page DSP side memory is never mapped to MPU side, so even if the DSP corrupts that page it does not affect MPU side. However the right solution is the one explained before: avoid DSP continues executing after MMUfault.

First of all, what is the DSP supposed to do with that memory? Do we
really need to call hw_mmu_tlb_add at all?

We really, absolutely want the DSP to don't corrupt memory on ARM
side, so if we pass something, it should be full pages.

Sure, it would be nice to wait for the DSP to stop, but if for some
reason it doesn't, we need to know that the DSP doesn't have the power
to corrupt memory.

Now, I went back to commit 72110f1 and tried the patch you mentioned.
There's no GPT8 involved, and I cannot reproduce any corruption on a
beagleboard.

--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -193,6 +193,7 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr,
u32 ulEventMask, u32 dwErrInfo)
                                        &resources);

        if (MEM_IS_VALID_HANDLE(deh_mgr_obj, SIGNATURE)) {
+               void *temp1, *temp2;
                printk(KERN_INFO
                       "bridge_deh_notify: ********** DEVICE EXCEPTION "
                       "**********\n");
@@ -227,8 +228,11 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr,
u32 ulEventMask, u32 dwErrInfo)
                        printk(KERN_INFO
                               "bridge_deh_notify: DSP_MMUFAULT, fault "
                               "address = 0x%x\n", (unsigned int)fault_addr);
-                       dummy_va_addr =
-                           (u32) mem_calloc(sizeof(char) * 0x1000, MEM_PAGED);
+                       temp1 = kmalloc(0x100000, GFP_ATOMIC);
+                       temp2 = kmalloc(0x1000, GFP_ATOMIC);
+                       kfree(temp1);
+                       kfree(temp2);
+                       dummy_va_addr = (u32) kmalloc(0x1000, GFP_ATOMIC);
                        mem_physical =
                            VIRT_TO_PHYS(PG_ALIGN_LOW
                                         ((u32) dummy_va_addr, PG_SIZE4K));

Is there anything special I should do?

Also, wouldn't it be easier to trigger this by doing:

                        printk(KERN_INFO
                               "bridge_deh_notify: DSP_MMUFAULT, fault "
                               "address = 0x%x\n", (unsigned int)fault_addr);
-                       dummy_va_addr =
-                           (u32) mem_calloc(sizeof(char) * 0x1000, MEM_PAGED);
+                       temp1 = kmalloc(0x100000, GFP_ATOMIC);
+                       temp2 = kmalloc(0x1000, GFP_ATOMIC);
+                       kfree(temp1);
                        mem_physical =
                            VIRT_TO_PHYS(PG_ALIGN_LOW
-                                        ((u32) dummy_va_addr, PG_SIZE4K));
+                                        ((u32) temp2, PG_SIZE4K));
+                       kfree(temp2);
                        dev_context = (struct wmd_dev_context *)
                            deh_mgr_obj->hwmd_context;
                        /* Reset the dynamic mmu index to fixed count if it

Cheers.

-- 
Felipe Contreras
