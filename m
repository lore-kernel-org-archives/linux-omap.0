From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH] DSPBRIDGE:Fix Kernel memory poison overwritten after
 DSP_MMUFAULT
Date: Mon, 19 Apr 2010 13:25:04 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CB215CB2@dlee06.ent.ti.com>
References: <1271177720-1299-1-git-send-email-deepak.chitriki@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34213 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173Ab0DSSZO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Apr 2010 14:25:14 -0400
In-Reply-To: <1271177720-1299-1-git-send-email-deepak.chitriki@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Menon, Nishanth" <nm@ti.com>



Hi all,

	I have found the really issue here:


The problem here is that after MMUFault the DSP is allowed to continue =
executing until here revices the message informing about the MMUFault a=
nd this problem since the patches for mailbox migration.


Previous code:

			if (DSP_SUCCEEDED(status)) {
				hwStatus =3D HW_MMU_TLBAdd(resources.dwDmmuBase,
					memPhysical, faultAddr,
					HW_PAGE_SIZE_4KB, 1, &mapAttrs,
					HW_SET, HW_SET);

<<<we add the dummy entry in the TBL, so that MMU module can translate =
the address, we always map pages so it does not matter if we pass the c=
omplete addrees (page + offset) or only the page aligned addres (page) =
we will write only the page.>>>

			}
			/* send an interrupt to DSP */
			HW_MBOX_MsgWrite(resources.dwMboxBase, MBOX_ARM2DSP,
					 MBX_DEH_CLASS | MBX_DEH_EMMU);

<<<we send a mailbox message to the DSP to inform it about MMUFault, th=
is function write the message into mailbox and trigger mailbox interrup=
t in the DSP side.>>>
			/* Clear MMU interrupt */
			HW_MMU_EventAck(resources.dwDmmuBase,
					 HW_MMU_TRANSLATION_FAULT);

<<<we acked the MMU faul interrupt (transition fault interrupt). After =
MMUFault MMU module stops DSP execution until the MMUfault flag is acke=
d and it can find the physical address of the virtual address requested=
 by the DSP. So in this moment the DSP continue executing again but bef=
ore it can use the address translated it had to attend mailbox interrup=
t (hardware interrupt) so it change context to mailbox ISR and the DSP =
is stuck in infinite while loop.>>>



However after mailbox migration patches the code looks like:

			if (DSP_SUCCEEDED(status)) {
				hw_status_obj =3D
				    hw_mmu_tlb_add(resources.dw_dmmu_base,
						   mem_physical, fault_addr,
						   HW_PAGE_SIZE4KB, 1,
						   &map_attrs, HW_SET, HW_SET);
			}
			/* send an interrupt to DSP */
			omap_mbox_msg_send(dev_context->mbox,
						MBX_DEH_CLASS | MBX_DEH_EMMU);

<<<the code looks pretty similar, however there is a difference inside =
 omap_mbox_msg_send function, this function does not write directly the=
 mailbox register to put the new messages, instead of schedule a workqu=
eue that will the in charge of doing that job>>>

			/* Clear MMU interrupt */
			hw_mmu_event_ack(resources.dw_dmmu_base,
					 HW_MMU_TRANSLATION_FAULT);

<<<So after we ack the MMU fault event the MMU lets DSP to continue exe=
cuting, like the mailbox interrupt was not trigger in this moment (beca=
use of the latency of the workque) and if the fault address was being u=
sed in the DSP to write, it can corrupt memory.>>>


The patch send to linux-omap list (DSPBRIDGE:Fix Kernel memory poison o=
verwritten after DSP_MMUFAULT) is just hidden the problem. Because in c=
ase the MPU had a lot of work the workqueue execution will be delay eve=
n more and the DSP side could reach the limit of the dummy page allocat=
ed and corrupt memory, or write memory in a downward way and corrupt pr=
eview memory maybe already map but not allowed to DSP write the entry p=
age.


Also the way we are using the dummymemory to allow DSP write/read from =
that is not correct. Because the offset of the dummymemory and the offs=
et of the DSP fault address should be match.

These values are taken from nokia logs:

=46ault address: 0x21fa0040
dmm_va_addr: 0xdf16d140
mem_physical: 0x9f16d000

The address returned by kmalloc is 0xccbd2080, so we can write I this b=
uffer from 0xdf16d140 until the end of the page and in physical memory =
from 0x9f16d140 until the end of the page. And in the DSP we map 0x9f16=
d000 <=3D> 0x21fa0000 and when it tries to write into 0x21fa0040 it is =
actually writing to 0x9f16d040 corrupting the memory. But in the previo=
us code we did not allowed to the DSP do anything more after the MMU fa=
ult, that why we did not see that problem before.

The patch "DSPBRIDGE: MMU-Fault debugging enhancements" already sent to=
 linux-omap list fix this problem indirectly. Now the way to inform abo=
ut the MMUFault is not using a mailbox message, instead of we the GTP8 =
overflow interrupt.


				omap_dm_timer_set_load_start(timer, 0,
								0xfffffffe);
			<<<we set timer counter almost to overflue >>>


				/* Wait 80us for timer to overflow */
				udelay(80);

				/*
				 * Check interrupt status and
				 * wait for interrupt
				 */
				cnt =3D 0;
				while (!(omap_dm_timer_read_status(timer) &
					GPTIMER_IRQ_OVERFLOW)) {
					if (cnt++ >=3D
						GPTIMER_IRQ_WAIT_MAX_CNT) {
						pr_err("%s: GPTimer interrupt"
							" failed\n", __func__);
						break;
					}
				}
		<<<we wait until interrupt is trigger>>>>

			}
			hw_mmu_event_ack(resources->dw_dmmu_base,
					 HW_MMU_TRANSLATION_FAULT);
<<<DSP can continue in this point, but how the GTP8 interrupt was alrea=
dy trigger it change the context to the GTP8 ISR and it dumps DSP stack=
 and then stuck in the infinite while loop>>>

			dump_dsp_stack(deh_mgr_obj->hwmd_context);
			omap_dm_timer_disable(timer);



I could reproduce the issue doing some change in the top of "DSPBRIDGE:=
 MMU-Fault debugging enhancements":

			temp1 =3D kmalloc(0x100000, GFP_ATOMIC);
			temp2 =3D kmalloc(0x1000, GFP_ATOMIC);
			kfree(temp1);
			kfree(temp2);
	<<<doing some allocations and frees to fill slap with poison and redzo=
ne pattern>>>
			dummy_va_addr =3D (u32) kmalloc(0x1000, GFP_ATOMIC);

=2E..
			/* Clear MMU interrupt */
			hw_mmu_event_ack(resources->dw_dmmu_base,
					 HW_MMU_TRANSLATION_FAULT);
	<<<Acked MMU fault flag, so that DSP can continue executing, before ge=
nerate GTP8 interrupt>>>
			/*
			 * Send a GP Timer interrupt to DSP
			 * The DSP expects a GP timer interrupt after an
			 * MMU-Fault Request GPTimer
			 */
			if (timer) {


And this is what I get:

BUG kmalloc-64: Redzone overwritten
-----------------------------------------------------------------------=
------

INFO: 0xccbeea40-0xccbeea43. First byte 0x0 instead of 0xbb
INFO: Allocated in 0xe3510001 age=3D3858725493 cpu=3D2583691266 pid=3D-=
481230846
INFO: Freed in 0xea000007 age=3D473713215 cpu=3D3785367565 pid=3D-47380=
9537
INFO: Slab 0xc0706d78 objects=3D32 used=3D31 fp=3D0xccbeea00 flags=3D0x=
00c2
INFO: Object 0xccbeea00 @offset=3D2560 fp=3D0x0a00000d

Bytes b4 0xccbee9f0:  0b 00 00 ea 00 00 a0 e3 0d 00 00 ea 0d 20 a0 e1 .=
=2E.=EA...=E3..
=2E=EA...=E1
  Object 0xccbeea00:  7f 3d c2 e3 3f 30 c3 e3 0c 10 a0 e1 04 20 8d e2 .=
=3D=C2=E3?0=C3=E3..
=2E=E1...=E2
  Object 0xccbeea10:  04 30 93 e5 01 c1 d3 e3 20 30 a0 13 d0 30 a0 03 .=
0.=E5.=C1=D3=E3.0 ..=D00..
  Object 0xccbeea20:  fe ff ff eb 00 00 50 e3 04 30 9d 15 00 30 86 15 =FE=
=FF=FF=EB..P=E3.0 ...0..
  Object 0xccbeea30:  00 00 00 1a 00 00 86 e5 7c 80 bd e8 08 00 00 00 .=
=2E.....=E5|.
=BD=E8....
 Redzone 0xccbeea40:  00 00 50 e3                                     .=
=2EP=E3

 Padding 0xccbeea68:  04 30 93 e5 01 21 d3 e3 20 10 a0 13 d0 10 a0 03 .=
0.=E5.!=D3=E3..
=2E.=D0...
 Padding 0xccbeea78:  fe ff ff ea fe ff ff ea

I am getting the Redzone overwritten instead of Poison overwritten beca=
use was the start of the slab which was corrupted.


Keeping the code as before just changing the MMU fault ack after genera=
ting GTP8 interrupt is trigger the issue is not seen.

				while (!(omap_dm_timer_read_status(timer) &
					GPTIMER_IRQ_OVERFLOW)) {
					if (cnt++ >=3D
						GPTIMER_IRQ_WAIT_MAX_CNT) {
						pr_err("%s: GPTimer interrupt"
							" failed\n", __func__);
						break;
					}
				}
		<<< wait until GTP8 interrupt is generated>>>
			}
			hw_mmu_event_ack(resources->dw_dmmu_base,
					 HW_MMU_TRANSLATION_FAULT);


Even if I pass an address already freed to the tlb just to make sure th=
at the DSP is not able to write to that address after MMUFault the issu=
e is not seen:

			temp1 =3D kmalloc(0x100000, GFP_ATOMIC);
			temp2 =3D kmalloc(0x1000, GFP_ATOMIC);
			kfree(temp1);
			kfree(temp2);
=2E..
				    hw_mmu_tlb_add(resources->dw_dmmu_base,
						   temp2, fault_addr,
			<<<using temp2 address, which is already free>>>

						   HW_PAGE_SIZE4KB, 1,
						   &map_attrs, HW_SET, HW_SET);

The issue is not even seen, the conclusion of this test is: we can pass=
 a really "dummy" address (any address) to fill up the TLB, DSP is actu=
ally not using that, therefore we don't need even allocate memory for d=
ummy_va_addr, I can even used NULL and there is not problem.



To sum up:

- "DSPBRIDGE:Fix Kernel memory poison overwritten after DSP_MMUFAULT" i=
s only hidden the problem, we don't need aligned memory in this point, =
that patch should be removed if it is already apply.

- There is no need to create a patch for the issue because it is alread=
y indirectly fix with "DSPBRIDGE: MMU-Fault debugging enhancements".

- we don't need allocate memory for dummy_va_addr, if some patch should=
 be created should be the patch to remove dummy_va_addr allocation and =
deletion.

Regards,
=46ernando.


>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Chitriki Rudramuni, Deepak
>Sent: Tuesday, April 13, 2010 11:55 AM
>To: linux-omap
>Cc: Chitriki Rudramuni, Deepak; Ameya Palande; Felipe Contreras; Hiros=
hi
>Doyu; Ramirez Luna, Omar; Menon, Nishanth
>Subject: [PATCH] DSPBRIDGE:Fix Kernel memory poison overwritten after
>DSP_MMUFAULT
>
>kmalloc() does not guarantee page aligned memory always,hence
>resulting in virtual addresses not getting aligned to page boundary.
>This patch replaces kmalloc() with __get_free_pages() which
>allocates kernel memory in terms of PAGES fixing the Kernel
>memory corruption after DSP_MMUFAULT.
>
>Cc: Ameya Palande <ameya.palande@nokia.com>
>Cc: Felipe Contreras <felipe.contreras@nokia.com>
>Cc: Hiroshi Doyu <hiroshi.doyu@nokia.com>
>Cc: Omar Ramirez Luna <omar.ramirez@ti.com>
>Cc: Nishanth Menon <nm@ti.com>
>
>Signed-off-by: Deepak Chitriki <deepak.chitriki@ti.com>
>---
> drivers/dsp/bridge/wmd/ue_deh.c |    5 +++--
> 1 files changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/dsp/bridge/wmd/ue_deh.c
>b/drivers/dsp/bridge/wmd/ue_deh.c
>index 14dd8ae..7ed5f60 100644
>--- a/drivers/dsp/bridge/wmd/ue_deh.c
>+++ b/drivers/dsp/bridge/wmd/ue_deh.c
>@@ -239,7 +239,8 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u=
32
>ulEventMask, u32 dwErrInfo)
> 			       "bridge_deh_notify: DSP_MMUFAULT, fault "
> 			       "address =3D 0x%x\n", (unsigned int)fault_addr);
> 			dummy_va_addr =3D
>-			    (u32) mem_calloc(sizeof(char) * 0x1000, MEM_PAGED);
>+			    (void *)__get_free_pages(GFP_ATOMIC | __GFP_ZERO,
>+						     0);
> 			mem_physical =3D
> 			    VIRT_TO_PHYS(PG_ALIGN_LOW
> 					 ((u32) dummy_va_addr, PG_SIZE4K));
>@@ -338,6 +339,6 @@ dsp_status bridge_deh_get_info(struct deh_mgr
>*hdeh_mgr,
>  */
> void bridge_deh_release_dummy_mem(void)
> {
>-	kfree((void *)dummy_va_addr);
>+	free_pages((void *)dummy_va_addr, 0);
> 	dummy_va_addr =3D 0;
> }
>--
>1.6.3.3
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" =
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
