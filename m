From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Replace clk_use/unuse with clk_enable/disable,
	please test
Date: Fri, 13 Jan 2006 17:12:36 -0800
Message-ID: <20060114011236.GQ5499@atomide.com>
References: <7AF192DA69C59243838FF62851F64F5501B0057A@toebe101.NOE.Nokia.com>
	<7AF192DA69C59243838FF62851F64F5501B00590@toebe101.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <7AF192DA69C59243838FF62851F64F5501B00590@toebe101.NOE.Nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Toshihiro.Kobayashi@nokia.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Toshihiro.Kobayashi@nokia.com <Toshihiro.Kobayashi@nokia.com> [060113 04:27]:
> Sorry, the code to shut down dsp_ck was wrong in the previous patch.
> Please use this one.
> 
> BR,
> Toshihiro Kobayashi
> 
> >-----Original Message-----
> >From: linux-omap-open-source-bounces@linux.omap.com 
> >[mailto:linux-omap-open-source-bounces@linux.omap.com] 
> >Sent: Friday, January 13, 2006 9:10 PM
> >To: tony@atomide.com; linux-omap-open-source@linux.omap.com
> >Subject: RE: [PATCH] Replace clk_use/unuse with 
> >clk_enable/disable,please test
> >
> >Hi Tony,
> >
> >Sorry for the slow reply.

No problem!

> >>Toshihiro, can you please check the dsp related changes? The problem
> >>there seems to be that the dsp code may enable certain clocks and then
> >>they stay on during suspend.
> >>
> >>I've just added clk_enable() clk_disable() in few places there to shut
> >>down any clocks left on from dsp code.
> >
> >OK, Firstly please let me explain the intention of the old code.
> >The dsp_ck handling in the suspend sequence is as follows.
> >
> >omap_pm_suspend() {
> >    ARM_SAVE(ARM_CKCTL) (contains dsp_ck)    <-- (1)
> >    omap_dsp_pm_suspend() {
> >        clk_disable(dsp_ck)
> >            (forcingly disble because it is not shut down in
> >omapXXXX_idle_loop_suspend())
> >    }
> >    omapXXXX_idle_loop_suspend() {
> >        *** suspend ***
> >    }
> >    omap_dsp_pm_resume() {
> >    }
> >    ARM_RESTORE(ARM_CKCTL) to the value at (1)
> >}
> >
> >Now, we are losing (old) clk_disable() function, it must
> >be replaced with low-level register operation.
> >
> >Also, api_ck is handled as follows in each
> >omap_dsp_pm_suspend() and omap_dsp_pm_resume().
> >
> >omap_dsp_pm_suspend() {
> >    save ARMIDLECT2 (contains api_ck)
> >    clk_enable(api_ck) so that we can access DSP_IDLECT2 register
> >    here accessing to DSP_IDLECT2
> >    restore ARM_IDLECT2
> >}
> >
> >So the api_ck is handled correctly as well but this is not a very
> >intelligent. ;)
> >They could be simply done with clk_use() and clk_unuse().
> >(Maybe it's a negative heritage from old code before
> > the clock framework has been introduced)

Thanks for deciphering it :) I wonder if we could just take care of the
temporary enable in the clock framework?

> >Please find the patch attached that fixes those issues, in addition,
> >the low level register handlings are moved to pm.c.
> >(This patch should be applied over your patch)

Thanks, pushing today.

> >>Also, does api_ck_handle reference count work properly in
> >>dsp_cpustat_update()? It seems that clk_enable(api_ck_handle) and
> >>clk_disable(api_ck_handle) may get called multiple times...
> >
> >No, the cpustat.stat is the state machine that represents DSP state and
> >the code is written so that it calls clk_enable(api_ck) only when
> >the state changes to CPUSTAT_RUN from the other ones,
> >and calls clk_disable(api_ck) only when the state changes from
> >CPUSTAT_RUN to the other ones.

OK

Tony
