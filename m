From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup for sidetone
Date: Fri, 15 Apr 2016 08:16:51 -0700
Message-ID: <20160415151651.GP5995@atomide.com>
References: <20160411212845.GJ5995@atomide.com>
 <570CC54E.6020703@ti.com>
 <20160412163750.GR5995@atomide.com>
 <570E3428.5020804@ti.com>
 <20160413152829.GQ5995@atomide.com>
 <570F4804.4050006@ti.com>
 <20160414165514.GL5995@atomide.com>
 <570FF163.1050603@ti.com>
 <20160414203457.GM5995@atomide.com>
 <5710C10A.6040908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5710C10A.6040908-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [160415 03:24]:
> On 04/14/16 23:34, Tony Lindgren wrote:
> > * Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [160414 12:38]:
> >>
> >> Yes it has registers, but it has no prcm level existence, it is part of McBSP
> >> module. I guess when the OMAP3 was designed the HW people did not wanted to
> >> create new version of the McBSP core for McBSP2/3 so they attached a new core
> >> to the McBSP cores with different targets, etc, but w/o external dependency.
> > 
> > Yeah well we do have a bunch of modules that don't need any separate
> > functional clock and are clocked only by the interface clock. So in this
> > case McBSP and sidetone are both consumers for the clock we just happen
> > to call McBSP interface clock. They should be able to share that no
> > problem.
> > 
> >>>> OK. I will go with the assumption that the sidetone hwmod can be removed (as
> >>>> it is not correct) and rework my current series to use pdata callback for the
> >>>> iclk autogate allow/deny. With this set the ST will be operational in legacy
> >>>> and DT boot.
> >>>
> >>> Sorry, no I did not want to drop the sidetone hwmod, I was just trying to
> >>> come up with ideas on how to make the driver changes easier. It sounds like
> >>> you already figured out the driver changes part though with two drivers.
> >>
> >> If I need to keep the sidetone hwmod around I don't see how it can be done in
> >> a safe and clean way. It is part of McBSP module, it is accessible only if the
> >> McBSP module is enabled, you can not enable the Sidetone alone you need to go
> >> and enable the McBSP module. I don't think it is a good idea to let two
> >> separate hwmods to poke around the same PRCM bits. Have not checked, but I
> >> don't think we have refcounting for the PRCM register bits.
> > 
> > Yeah there's no refcounting on the PRCM, but the clock framework has it
> > for the share McBSP interface clock.
> 
> The hwmod checks the bits described by prcm.omap2. If two hwmods are set up to
> manage/monitor the same bits in PRCM, what will happen when the two driver
> does pm_runtime?
> 
> CM_ICLKEN_PER[0] = 1
> McBSP2: runtime_get_sync()
> CM_ICLKEN_PER[0] = 0
> ...
> CM_ICLKEN_PER[0] = 0
> McBSP2.ST: runtime_get_sync() // hwmod might complain as the idlest was not 1?
> CM_ICLKEN_PER[0] = 0
> ...
> CM_ICLKEN_PER[0] = 0
> McBSP2.ST: runtime_put_sync()
> CM_ICLKEN_PER[0] = 0 // hwmod might warn that the module did not went idle?
> ...
> CM_ICLKEN_PER[0] = 0
> McBSP2: runtime_put_sync()
> CM_ICLKEN_PER[0] = 1
>
> We can hack this around by adding HWMOD_NO_IDLEST to the sidetone hwmod I
> guess. As the sidetone does not have PRCM level control - it is part of McBSP.

Heh if they are using the same register bits for two separate modules,
then that's a bug for sure :) I think the sidetone module only has the
clock gating bit in the ST_SYSCONFIG.

> > Then there are two separate sets of sysconfig registers that PM runtime should manage.
> 
> The sidetone core's sysconfig register is internal to McBSP module. This is
> what the TRM has to say about McBSPi.ST_SYSCONFIG_REG[0] AUTOIDLE bit:
> - When this bit is asserted (set to 1), the McBSPi_ICLK clock auto-gating is
> enabled and this clock is disabled internally to the SIDETONE feature, thus
> reducing power consumption, but not to the McBSP module that contains this
> feature.

Some confusion here.. The McBSPi_ICLK is external, it's just shared
between the McBSP and sidetone modules. So the ST_SYSCONFIG gates
internally separately to the sidetone.

> After reset, the automatic clock gating is enabled; thus, this bit must be
> disabled by software for activated SIDETONE feature.
> - When this bit is set to 0, the McBSPi_ICLK clock auto-gating is disabled and
> this clock is enabled. The SIDETONE feature can be used normally.
> 
> The ST_SYSCONFIG_REG is internal to the McBSP module the ST is integrated into.

The ST_SYSCONFIG is internal to the sidetone module only. Then the
McBSP module has it's own SYSCONFIG register that's internal to the
McBSP module only.

I think the confusion comes from the McBSPi_ICLK naming, that's not
internal to the module(s) in question, it comes from an external
shared source that the SYSCONFIG registers control.

Some SYSCONFIG registers have autoidle features that signal the
source clockdomain too.

> I'm still not convinced about the benefits of creating separate device for the
> ST core of McBSP.
> From my point of view:
> McBSP2 module consist of:
> - McBSP core
>  - clock generator subcore
>  - tx subcore
>  - rx subcore
> - Sidetone core

I think it's more like this for the clocking and
intermodule lines:

clockdomain
clock generarator ---+
subcore              |
                     +- McBSP
                     |  internal gating
                     |  and signaling to
                     |  clockdomain via
                     |  SYSCONFIG register
                     |        | |
                     |        | | intermodule lines
                     |        | | not on the interconnect
                     |        | |
                     +- sidetone
                     |  internal gating
                     |  (and signaling to
                     |  clockdomain via
                     |  SYSCONFIG register?)

Then all these modules just sit on the L4 interconnet at
separate targets, including the clockdomain.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
