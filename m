From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] DSPBRIDGE:Fix Kernel memory poison overwritten after
	DSP_MMUFAULT
Date: Fri, 14 May 2010 01:33:33 +0300
Message-ID: <AANLkTimN2cdm1oF5vfDv82tHuQ2Bk7vXpL27evDdVLHD@mail.gmail.com>
References: <1271177720-1299-1-git-send-email-deepak.chitriki@ti.com>
	 <496565EC904933469F292DDA3F1663E602CB215CB2@dlee06.ent.ti.com>
	 <AANLkTik46ilQPBGtsgWAMTlWrdWaaYTDC2aCYmf4iUIn@mail.gmail.com>
	 <496565EC904933469F292DDA3F1663E602CB5B99E5@dlee06.ent.ti.com>
	 <AANLkTikUc623KkBg88CYr9_Pskx_A6sqXikGEdqhhKm8@mail.gmail.com>
	 <496565EC904933469F292DDA3F1663E602CB6CA9FC@dlee06.ent.ti.com>
	 <AANLkTim_duEcuI3jxT06l_-55v5_TOk-KJfNQ8PKsjG2@mail.gmail.com>
	 <496565EC904933469F292DDA3F1663E602CB6CABB3@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63117 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab0EMWdf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 18:33:35 -0400
Received: by fxm6 with SMTP id 6so915922fxm.19
        for <linux-omap@vger.kernel.org>; Thu, 13 May 2010 15:33:33 -0700 (PDT)
In-Reply-To: <496565EC904933469F292DDA3F1663E602CB6CABB3@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Menon, Nishanth" <nm@ti.com>

On Fri, May 14, 2010 at 12:15 AM, Guzman Lugo, Fernando
<fernando.lugo@ti.com> wrote:
>> But the DSP is not dumping the stack there, from what I can see
>> bridge_brd_read() is used to read DSP internal memory.
>
> DSP is dumping the stack after the MMUFault and mmu let DSP to contin=
ue.
>
> Let's see what happens in successful case, so that the mmu fault
> Mechanics can be understood better:
>
> 1.- DSP wants to write some virtual address which is not found by the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Mmu.
>
> 2.- MMU module does not allow to the DSP continue executing and
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Generates MMUfault interrupt which is atta=
ched to MPU side.
>
> 3.- MPU side allocates a dummy address, so that it can be mapped to
> =C2=A0 =C2=A0 =C2=A0 =C2=A0The DSP fault address.
>
> dummy_va_addr =3D kzalloc(sizeof(char) * 0x1000, GFP_ATOMIC);
>
>
> 3.- MPU dumps the DLL loaded
> =C2=A0 =C2=A0 =C2=A0 =C2=A0At the moment of the crash, at this point =
we don't need anything from
> =C2=A0 =C2=A0 =C2=A0 =C2=A0DSP because MPU has the information of DLL=
's loaded.
>
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_dsp_trac=
e_buffer(dev_context);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dump_dl_module=
s(dev_context);
>
>
> 4.- MPU maps the physical address of the dummy address to the fault a=
ddress
> =C2=A0 =C2=A0 =C2=A0 =C2=A0So that, if the DSP want to write into the=
 fault address it will
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Be writing into the dummy buffer revered p=
reviously.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hw_mmu_tlb_add(resources->dw_=
dmmu_base,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0mem_physical, fault_addr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0HW_PAGE_SIZE4KB, 1,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&map_attrs, HW_SET, HW_SET);
>
> 5.- MPU generates a GPT8 overflow interrupt.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0while (!(omap_dm_timer_read_status(timer) &
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GPTIMER_IRQ_OVERFLOW)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cnt++ >=3D GPTIMER_IRQ_WA=
IT_MAX_CNT) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p=
r_err("%s: GPTimer interrupt failed\n",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0__func__);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b=
reak;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}
>
>
> 6.- MPU acked mmufault interrupt.
>
>
> hw_mmu_event_ack(resources->dw_dmmu_base,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0HW_MMU_TRANSLATION_FAULT);
>
>
> 7.- MMU module tries to get the physical address of the DSP fault add=
ress
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A now it can, the address is the page of t=
he dummy address + the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Offset of the fault address.
>
> 8.- MMU module lets DSP to continue. But at that moment DSP has to at=
tend
> =C2=A0 =C2=A0 =C2=A0 =C2=A0The GPT8 hw interrupt so that it change th=
e context to the GTP8
> =C2=A0 =C2=A0 =C2=A0 =C2=A0overflow ISR and then dumps all the stack =
information in the same
> =C2=A0 =C2=A0 =C2=A0 =C2=A0shared memory area which is use for SYS_pr=
intf traces.
>
> 9.- After doing the acked of the MMUfault interrupt MPU call
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dump_dsp_stack function
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Clear MMU i=
nterrupt */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hw_mmu_event_a=
ck(resources->dw_dmmu_base,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0HW_MMU_TRANSLATION_FAULT);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dump_dsp_stack=
(deh_mgr->hwmd_context);
>
> 10. Inside dump_dsp_stack we wait until DSP writes the special value
> =C2=A0 =C2=A0 =C2=A0 =C2=A0MMU_FAULT_HEAD1 and MMU_FAULT_HEAD2 into t=
racing area, which
> =C2=A0 =C2=A0 =C2=A0 =C2=A0States the DSP completed the stack dump.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while ((mmu_fa=
ult_dbg_info.head[0] !=3D MMU_FAULT_HEAD1 ||
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0mmu_fault_dbg_info.head[1] !=3D MMU_FAULT_HEAD2) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0poll_cnt < POLL_MAX) {
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0/* Read DSP dump size from the DSP trace buffer... */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0status =3D (*intf_fxns->pfn_brd_read)(wmd_context,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(u8 *)&mmu_fault_dbg_info, (u=
32)trace_begin,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(mmu_fault_dbg_info), 0=
);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (DSP_FAILED(status))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0poll_cnt++;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
>
> 11 .- After writing the heads values, DSP just does an infinite while
>
> 12.- MPU then prints the information sent by DSP.
>
>
> Please let me know if you have any doubt.

You repeated step 3 twice. So let's assume the first one is 3.1.

1) What happens if you skip step 3.1 and 4?

You are assuming that the MMU unit would not let the DSP continue
running, but I fail to see why. Then the stack information would not
be available.

=46irst of all, I don't see any stack information anyway:
dump_dsp_stack:No DSP MMU-Fault information available. Now Deepak has
used 0 in hw_mmu_tlb_add() and he is able to see the stack just fine.

>> If I'm understanding things correctly, then we shouldn't map the
>> faulty address again (through hw_mmu_tlb_add), and we shouldn't clea=
r
>> the interrupt either (HW_MMU_TRANSLATION_FAULT). (I haven't tested
>> this yet).
>
> If we do that, DSP would be able to dump the DSP stack.

You mean we _woudn't_? First, I'm not really worried about loosing a
feature that doesn't seem to be working anyway. And second, we assume
we actually want that feature. For development purposes, sure, but in
a production device, no... we actually don't want all that debugging
code which seems to be quite big.

> Also I am not sure
> if after reloading the base image and resetting DSP MMU module, the
> HW_MMU_TRANSLATION_FAULT flag is reset too, maybe that whould have to=
 take
> care about that.

Seems to be working fine here. Probably all interrupts are cleared
when reloading.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
