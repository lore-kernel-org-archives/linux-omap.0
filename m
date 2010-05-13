From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH] DSPBRIDGE:Fix Kernel memory poison overwritten after
 	DSP_MMUFAULT
Date: Thu, 13 May 2010 16:15:45 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CB6CABB3@dlee06.ent.ti.com>
References: <1271177720-1299-1-git-send-email-deepak.chitriki@ti.com>
	 <496565EC904933469F292DDA3F1663E602CB215CB2@dlee06.ent.ti.com>
	 <AANLkTik46ilQPBGtsgWAMTlWrdWaaYTDC2aCYmf4iUIn@mail.gmail.com>
	 <496565EC904933469F292DDA3F1663E602CB5B99E5@dlee06.ent.ti.com>
	 <AANLkTikUc623KkBg88CYr9_Pskx_A6sqXikGEdqhhKm8@mail.gmail.com>
	 <496565EC904933469F292DDA3F1663E602CB6CA9FC@dlee06.ent.ti.com>
 <AANLkTim_duEcuI3jxT06l_-55v5_TOk-KJfNQ8PKsjG2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38682 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752484Ab0EMVPu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 17:15:50 -0400
In-Reply-To: <AANLkTim_duEcuI3jxT06l_-55v5_TOk-KJfNQ8PKsjG2@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Menon, Nishanth" <nm@ti.com>



Hi,


> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> Sent: Thursday, May 13, 2010 1:30 PM
> To: Guzman Lugo, Fernando
> Cc: Chitriki Rudramuni, Deepak; linux-omap; Ameya Palande; Felipe
> Contreras; Hiroshi Doyu; Ramirez Luna, Omar; Menon, Nishanth
> Subject: Re: [PATCH] DSPBRIDGE:Fix Kernel memory poison overwritten after
> DSP_MMUFAULT
> 
> On Thu, May 13, 2010 at 8:29 PM, Guzman Lugo, Fernando
> <fernando.lugo@ti.com> wrote:
> >> First of all, what is the DSP supposed to do with that memory? Do we
> >> really need to call hw_mmu_tlb_add at all?
> >
> > Once DSP MMUfault happens iva mmu module prevents DSP continue executing
> until mmu module is able get some physical address for the virtual address
> that the dsp wanted to access. Once mmu fault interrupt is acked the mmu
> module tries to translate the virtual address again and if it gets the
> physical address DSP continue executing.
> 
> This is if we want the DSP to continue executing, which all the code
> assumes we don't. If we wanted to do that, then we would need to know
> how to get the data that the DSP code was trying to access, but we
> don't. We always provide the data beforehand, and if the DSP code
> tries to access something else, there's nothing else to do.
> 
> > So in order to DSP can dumps its stack we need to map some physical
> address to that virtual address, so that mmu release DSP and it can dumps
> the stack.
> 
> But the DSP is not dumping the stack there, from what I can see
> bridge_brd_read() is used to read DSP internal memory.

DSP is dumping the stack after the MMUFault and mmu let DSP to continue.

Let's see what happens in successful case, so that the mmu fault
Mechanics can be understood better:

1.- DSP wants to write some virtual address which is not found by the 
	Mmu.

2.- MMU module does not allow to the DSP continue executing and
	Generates MMUfault interrupt which is attached to MPU side.

3.- MPU side allocates a dummy address, so that it can be mapped to 
	The DSP fault address.

dummy_va_addr = kzalloc(sizeof(char) * 0x1000, GFP_ATOMIC);


3.- MPU dumps the DLL loaded
	At the moment of the crash, at this point we don't need anything from
	DSP because MPU has the information of DLL's loaded.


		print_dsp_trace_buffer(dev_context);
		dump_dl_modules(dev_context);


4.- MPU maps the physical address of the dummy address to the fault address
	So that, if the DSP want to write into the fault address it will
	Be writing into the dummy buffer revered previously.

				hw_mmu_tlb_add(resources->dw_dmmu_base,
						mem_physical, fault_addr,
						HW_PAGE_SIZE4KB, 1,
						&map_attrs, HW_SET, HW_SET);

5.- MPU generates a GPT8 overflow interrupt.

			while (!(omap_dm_timer_read_status(timer) &
				GPTIMER_IRQ_OVERFLOW)) {
				if (cnt++ >= GPTIMER_IRQ_WAIT_MAX_CNT) {
					pr_err("%s: GPTimer interrupt failed\n",
								__func__);
					break;
				}
			}


6.- MPU acked mmufault interrupt.


hw_mmu_event_ack(resources->dw_dmmu_base,
				HW_MMU_TRANSLATION_FAULT);


7.- MMU module tries to get the physical address of the DSP fault address
	A now it can, the address is the page of the dummy address + the
	Offset of the fault address.

8.- MMU module lets DSP to continue. But at that moment DSP has to attend
	The GPT8 hw interrupt so that it change the context to the GTP8
	overflow ISR and then dumps all the stack information in the same
	shared memory area which is use for SYS_printf traces.

9.- After doing the acked of the MMUfault interrupt MPU call 
	dump_dsp_stack function

		/* Clear MMU interrupt */
		hw_mmu_event_ack(resources->dw_dmmu_base,
				HW_MMU_TRANSLATION_FAULT);
		dump_dsp_stack(deh_mgr->hwmd_context);

10. Inside dump_dsp_stack we wait until DSP writes the special value
	MMU_FAULT_HEAD1 and MMU_FAULT_HEAD2 into tracing area, which
	States the DSP completed the stack dump.

		while ((mmu_fault_dbg_info.head[0] != MMU_FAULT_HEAD1 ||
			mmu_fault_dbg_info.head[1] != MMU_FAULT_HEAD2) &&
			poll_cnt < POLL_MAX) {

			/* Read DSP dump size from the DSP trace buffer... */
			status = (*intf_fxns->pfn_brd_read)(wmd_context,
				(u8 *)&mmu_fault_dbg_info, (u32)trace_begin,
				sizeof(mmu_fault_dbg_info), 0);

			if (DSP_FAILED(status))
				break;

			poll_cnt++;
		}


11 .- After writing the heads values, DSP just does an infinite while

12.- MPU then prints the information sent by DSP.


Please let me know if you have any doubt.


> 
> You said yourself that you could pass a totally dummy address like 0,
> and the stack will still be printed.
> 
> > Therefore we allocate some dummy buffer of one 4K page and get the
> physical address of that buffer and use that physical address to fill the
> tbl on the mmu module using hw_mmu_tlb_add function.
> 
> I think that's wrong. We should not give the DSP hopes that it will be
> able to read data from that fault address... it's over.
> 
> > However the address returned by kmalloc is not page aling, that's means
> this mpu virtual address has some offset, for examples in the log that
> were send the dummy address had an offset of 0x080 and the DSP side
> virtual memory had an offset of 0x040. base on the offset of the MPU side
> and as we allocate one page that means we can access from 0x080 - 0xfff of
> the first page and from 0x000 - 0x080 if the second page, but we always
> allocate the first page to the DSP side, then DSP access to the address it
> wanted to access and now there is no mmufault but it is accessing
> (actually writing because reading not cause corruption) to that page but
> with a offset of 0x040 causing the corruption.
> >
> > Using get_user_pages fixes that case because as it returns address page
> aligned the DSP side can access from 0x000 - 0xfff of that page.
> 
> You mean __get_free_pages?

Yes I do, sorry for the confusion.

> 
> > However this is not the right solution because lets suppose if DSP side
> virtual address offset is 0xfff. So we map a page and DSP can access that
> page from 0x000 - 0xfff, however is the DSP is able to continue executing
> it will reach the following page and maybe that page is already mapped but
> it only can access from an specific offset like for example 0x100, in this
> ca DSP will still corrupt from 0x000 to 0x0ff of the next page.
> 
> From what I understand it's impossible for the DSP to access memory
> that wasn't mapped. So if we map only that page, when the DSP tries to
> write to 0x100, another MMU fault will happen.

Yes, Only one page is mapped, if for example DSP wants to access 0x21230fff, only page 0x21230000 will be mapped, if the DSP wants access 0x21231000 it will cause another MMUfault.

> 
> 
> If I'm understanding things correctly, then we shouldn't map the
> faulty address again (through hw_mmu_tlb_add), and we shouldn't clear
> the interrupt either (HW_MMU_TRANSLATION_FAULT). (I haven't tested
> this yet).

If we do that, DSP would be able to dump the DSP stack. Also I am not sure
if after reloading the base image and resetting DSP MMU module, the 
HW_MMU_TRANSLATION_FAULT flag is reset too, maybe that whould have to take
care about that.


Regards,
Fanando.

> 
> Cheers.
> 
> --
> Felipe Contreras
