From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] DSPBRIDGE:Fix Kernel memory poison overwritten after
	DSP_MMUFAULT
Date: Thu, 13 May 2010 21:29:49 +0300
Message-ID: <AANLkTim_duEcuI3jxT06l_-55v5_TOk-KJfNQ8PKsjG2@mail.gmail.com>
References: <1271177720-1299-1-git-send-email-deepak.chitriki@ti.com>
	 <496565EC904933469F292DDA3F1663E602CB215CB2@dlee06.ent.ti.com>
	 <AANLkTik46ilQPBGtsgWAMTlWrdWaaYTDC2aCYmf4iUIn@mail.gmail.com>
	 <496565EC904933469F292DDA3F1663E602CB5B99E5@dlee06.ent.ti.com>
	 <AANLkTikUc623KkBg88CYr9_Pskx_A6sqXikGEdqhhKm8@mail.gmail.com>
	 <496565EC904933469F292DDA3F1663E602CB6CA9FC@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65535 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889Ab0EMS3v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 14:29:51 -0400
Received: by fxm6 with SMTP id 6so687885fxm.19
        for <linux-omap@vger.kernel.org>; Thu, 13 May 2010 11:29:49 -0700 (PDT)
In-Reply-To: <496565EC904933469F292DDA3F1663E602CB6CA9FC@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Menon, Nishanth" <nm@ti.com>

On Thu, May 13, 2010 at 8:29 PM, Guzman Lugo, Fernando
<fernando.lugo@ti.com> wrote:
>> First of all, what is the DSP supposed to do with that memory? Do we
>> really need to call hw_mmu_tlb_add at all?
>
> Once DSP MMUfault happens iva mmu module prevents DSP continue executing until mmu module is able get some physical address for the virtual address that the dsp wanted to access. Once mmu fault interrupt is acked the mmu module tries to translate the virtual address again and if it gets the physical address DSP continue executing.

This is if we want the DSP to continue executing, which all the code
assumes we don't. If we wanted to do that, then we would need to know
how to get the data that the DSP code was trying to access, but we
don't. We always provide the data beforehand, and if the DSP code
tries to access something else, there's nothing else to do.

> So in order to DSP can dumps its stack we need to map some physical address to that virtual address, so that mmu release DSP and it can dumps the stack.

But the DSP is not dumping the stack there, from what I can see
bridge_brd_read() is used to read DSP internal memory.

You said yourself that you could pass a totally dummy address like 0,
and the stack will still be printed.

> Therefore we allocate some dummy buffer of one 4K page and get the physical address of that buffer and use that physical address to fill the tbl on the mmu module using hw_mmu_tlb_add function.

I think that's wrong. We should not give the DSP hopes that it will be
able to read data from that fault address... it's over.

> However the address returned by kmalloc is not page aling, that's means this mpu virtual address has some offset, for examples in the log that were send the dummy address had an offset of 0x080 and the DSP side virtual memory had an offset of 0x040. base on the offset of the MPU side and as we allocate one page that means we can access from 0x080 - 0xfff of the first page and from 0x000 - 0x080 if the second page, but we always allocate the first page to the DSP side, then DSP access to the address it wanted to access and now there is no mmufault but it is accessing (actually writing because reading not cause corruption) to that page but with a offset of 0x040 causing the corruption.
>
> Using get_user_pages fixes that case because as it returns address page aligned the DSP side can access from 0x000 - 0xfff of that page.

You mean __get_free_pages?

> However this is not the right solution because lets suppose if DSP side virtual address offset is 0xfff. So we map a page and DSP can access that page from 0x000 - 0xfff, however is the DSP is able to continue executing it will reach the following page and maybe that page is already mapped but it only can access from an specific offset like for example 0x100, in this ca DSP will still corrupt from 0x000 to 0x0ff of the next page.

>From what I understand it's impossible for the DSP to access memory
that wasn't mapped. So if we map only that page, when the DSP tries to
write to 0x100, another MMU fault will happen.


If I'm understanding things correctly, then we shouldn't map the
faulty address again (through hw_mmu_tlb_add), and we shouldn't clear
the interrupt either (HW_MMU_TRANSLATION_FAULT). (I haven't tested
this yet).

Cheers.

-- 
Felipe Contreras
