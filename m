From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 6/8] OMAP3 PM: Enable DPLL4 autoidle after system off.
Date: Wed, 20 Jan 2010 22:58:11 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001202236150.24456@utopia.booyaka.com>
References: <1264001442-20078-1-git-send-email-thara@ti.com> <1264001442-20078-2-git-send-email-thara@ti.com> <1264001442-20078-3-git-send-email-thara@ti.com> <1264001442-20078-4-git-send-email-thara@ti.com> <1264001442-20078-5-git-send-email-thara@ti.com>
 <1264001442-20078-6-git-send-email-thara@ti.com> <1264001442-20078-7-git-send-email-thara@ti.com> <alpine.DEB.2.00.1001201033120.3977@utopia.booyaka.com> <5A47E75E594F054BAF48C5E4FC4B92AB031E3F0B49@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45812 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499Ab0AUF6P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 00:58:15 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031E3F0B49@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Thara,

On Thu, 21 Jan 2010, Gopinath, Thara wrote:

> >>-----Original Message-----
> >>From: Paul Walmsley [mailto:paul@pwsan.com]
> >>Sent: Wednesday, January 20, 2010 11:05 PM
> >>To: Gopinath, Thara
> >>Cc: linux-omap@vger.kernel.org
> >>Subject: Re: [PATCH 6/8] OMAP3 PM: Enable DPLL4 autoidle after system off.
> >>
> >>On Wed, 20 Jan 2010, Thara Gopinath wrote:
> >>
> >>> DPLL4 autoidle is controlled through the register CM_PLL_AUTOIDLE
> >>> which is to be restored by rom code from the scratchpad in case
> >>> of a core domain context loss. But enabling this bit in scratchpad
> >>> causes rom code to take an extra 20 ms delay in the restore path.
> >>> To avoid this delay this bit is not enabled in the scratchpad today.
> >>> This means after a core off happens DPLL4 autoidle is never again
> >>> enabled back.
> >>> This patch enables DPLL4 autoidle in case of core domain losing
> >>> context.
> >>
> >>Shouldn't this be contingent on whether DPLL4 autoidle was enabled before
> >>the CORE off transition?
> 
> Hi Paul, Hmmm may be yes.. But you see today we enable all autoidle bits 
> in the init.

That may change depending on device wakeup latency constraints.  If a 
device has a low wakeup latency, we may choose to keep a DPLL running.  
Sometimes this is also changed to work around silicon bugs.  So we should 
avoid adding code that makes assumptions about any of those autoidle bits.

> Why I had to make this unconditional is because later before core 
> entering OSWR I explicitly disable this bit in the register. This is so 
> as to match this register content with those of scratchpad during OSWR. 
> Failing to do this rom code while exiting OSWR will take the path it 
> takes while coming out of core off . This causes a crash in the system 
> today. 

Fine, but can't you save the previous state of the DPLL autoidle with 
omap3_dpll_autoidle_read() before you disable it prior to OSWR, and just 
restore it afterwards?

> Also another reason is omap3_prcm_save_context needs to be called 
> only during core off today.

Is this because the CM registers are part of the logic section of the CORE 
powerdomain?

> If I move saving of this bit and restoring it back into 
> omap3_prcm_save_context and omap3_prcm_restore_context I will have to 
> call it during core OSWR also.

If you're not calling those now for OSWR, you shouldn't have to call them 
just to save and restore the DPLL4 autoidle state, right?  Wouldn't it 
work to simply read the current autoidle state with 
omap3_dpll_autoidle_read() before entering OSWR, then restore it 
afterwards with omap3_dpll_{allow,deny}_idle() ?

> Wanted to avoid the extra complications. 

And the extra delay.  Reads and writes from L4_WAKEUP-connected devices 
are sllloooooowwwww.

> But if this approach is not ok, I can modify the save restore APIs to 
> take power state as a parameter and do only dpll4 autoidle save and 
> restore in case of OSWR. Is this ok?

Well, let me know what you think of the above...

> >>> Signed-off-by: Thara Gopinath <thara@ti.com>
> >>> ---
> >>>  arch/arm/mach-omap2/pm34xx.c |    8 ++++++++
> >>>  1 files changed, 8 insertions(+), 0 deletions(-)
> >>>
> >>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> >>> index e4db1ea..6e6d954 100644
> >>> --- a/arch/arm/mach-omap2/pm34xx.c
> >>> +++ b/arch/arm/mach-omap2/pm34xx.c
> >>> @@ -520,6 +520,14 @@ void omap_sram_idle(void)
> >>>  			 */
> >>>  			if (cpu_is_omap3430())
> >>>  				usb_musb_disable_autoidle();
> >>> +			/* We do not program the scratchpad to restore back
> >>> +			 * PER DPLL in autoidle due to 20 ms delay in
> >>> +			 * rom code restore path. So enable it explicitly
> >>> +			 * after core off
> >>> +			 */
> >>
> >>This multi-line comment needs to be fixed to conform to
> >>Documentation/CodingStyle.
> 
> Oops.. My bad. Will fix and resend the patch. Don't know why checkpatch 
> is not catching this. I will wait a couple of days for comments on other 
> patches also and resend all of them after fixing the relevant comments.
>
> >>> +			cm_rmw_mod_reg_bits(
> >>> +				0x0, (1 << OMAP3430_AUTO_PERIPH_DPLL_SHIFT),
> >>> +				PLL_MOD, CM_AUTOIDLE);

One other comment.  Any reason why this patch can't use the 
omap3_dpll_allow_idle() and omap3_dpll_deny_idle() functions, rather than 
writing to the register directly?

> >>>  		}
> >>>  		omap_uart_resume_idle(0);
> >>>  		omap_uart_resume_idle(1);
> >>> --
> >>> 1.5.6.3


- Paul
