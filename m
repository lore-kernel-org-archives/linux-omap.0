From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 4/8] ARM: OMAP2+: hwmod: revise hardreset behavior
Date: Thu, 19 Apr 2012 14:07:58 +0200
Message-ID: <4F90001E.8060201@ti.com>
References: <20120228053524.16278.59430.stgit@dusk> <20120228053654.16278.73632.stgit@dusk> <alpine.DEB.2.00.1204182253550.29048@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34845 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754998Ab2DSMII (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Apr 2012 08:08:08 -0400
In-Reply-To: <alpine.DEB.2.00.1204182253550.29048@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

+ Omar and Ohad,

Salut Paul,

On 4/19/2012 8:53 AM, Paul Walmsley wrote:
> Hi Beno=EEt,
>
> On Mon, 27 Feb 2012, Paul Walmsley wrote:
>
>> Change the way that hardreset lines are handled by the hwmod code.
>> Hardreset lines are generally associated with initiator IP blocks.
>> Prior to this change, the hwmod code expected to control hardreset
>> lines itself, asserting them on shutdown and deasserting them upon
>> enable.  But driver authors inside TI have commented to us that thei=
r
>> drivers require direct control over these lines.  Unfortunately, the=
se
>> drivers haven't been posted publicly yet, so it's hard to determine
>> exactly what is needed, a priori.  This change attempts to set forth
>> some reasonable semantics that should be an improvement over the
>> current code.
>
> I took another look at this patch, and upon further thought, there ar=
e
> some aspects of this design that really don't make sense.

That's perfect timing, because I was struggling with some hardreset=20
issue on OMAP5 yesterday, so I thought as well about that patch.

This is just some more thoughts on that topic more than a pure comment=20
on this patch :-)

What I realized is that the main issue was due to the fake hwmods to=20
control processor reset lines. So these one has to be removed, it was=20
clearly a mistake.

The other issue was due to the wrong association between the reset line=
s=20
and the hwmod. In fact I was trying to create ipu & dsp hwmods, whereas=
=20
these subsystem do not have any direct connection with the main=20
interconnect but only through their MMU.
This is exactly what Omar raised when he tried to introduce the MMU hwm=
ods.
And in fact the new name used in OMAP5 are highlight that a little bit=20
netter than on OMAP4"

     'ipu':
         'rst_cpu0'
         'rst_cpu1'
         'rst_ipu_mmu_cache'

     'dsp':
         'rst_dsp'
         'rst_dsp_mmu_cache'

     'iva':
         'rst_seq1'
         'rst_seq2'
         'rst_logic'

The concern of the people doing SW in these embedded processors was=20
mainly because we were releasing the reset of processor without loading=
=20
any SW first and thus the processor was executing some random instructi=
ons.

So if we consider a better hwmods definition, we can potentially fix th=
e=20
MMU case:

     'mmu_ipu':
         'rst_ipu_mmu_cache'

     'mmu_dsp':
         'rst_dsp_mmu_cache'

     'iva_config':
         'rst_logic'


But then we do have the processor resets that have to be exposed somewh=
ere.

     'ipu':
         'rst_cpu0'
         'rst_cpu1'

     'dsp':
         'rst_dsp'

     'iva':
         'rst_seq1'
         'rst_seq2'

None of these one should be controlled automatically.

>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/=
omap_hwmod.c
>> index 5b368ee..db4ad41 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -805,6 +805,9 @@ static int _omap4_disable_module(struct omap_hwm=
od *oh)
>>   				    oh->clkdm->clkdm_offs,
>>   				    oh->prcm.omap4.clkctrl_offs);
>>
>> +	if (oh->rst_lines_cnt>=3D 0)
>> +		return 0;
>
> This change prevents any IP block from waiting for the target to disa=
ble
> -- which is not what we want.  The na=EFve fix would be to only skip =
the
> disable-wait if oh->rst_lines_cnt is greater than zero.  But if there=
 are
> no hardreset lines asserted, then we should probably wait for the dis=
able
> in that case.
>
>>   	v =3D _omap4_wait_target_disable(oh);
>>   	if (v)
>>   		pr_warn("omap_hwmod: %s: _wait_target_disable failed\n",
>
> [...]
>
>> @@ -1575,7 +1568,19 @@ static int _enable(struct omap_hwmod *oh)
>>   	_enable_clocks(oh);
>>   	_enable_module(oh);
>>
>> -	r =3D _wait_target_ready(oh);
>> +	/*
>> +	 * If an IP contains HW reset lines, we leave them
>> +	 * asserted.  But this will block the module's idle state
>> +	 * transition - the PRCM will return Intransition status.  So
>> +	 * we need to avoid the target ready-wait in this case.  XXX
>> +	 * We also need to give the drivers a way to wait for the
>> +	 * target to become ready once they decide to deassert some
>> +	 * hardreset lines.  XXX Is this strategy going to break PM
>> +	 * because the clockdomain may not be able to enter idle while
>> +	 * the module's idle status is in-transition?  We may just need
>> +	 * custom reset blocks for all IPs with hardreset lines.
>> +	 */
>> +	r =3D (oh->rst_lines_cnt =3D=3D 0) ? _wait_target_ready(oh) : 1;
>
> And this part is at odds with the patch description.  If there are
> hardreset lines associated with an IP block, then this code will caus=
e the
> following code to unconditionally disable the module clocks.  Conside=
ring
> that this is the _enable() function, this seems counterproductive.
>
> I looked into changing this code to align with the original semantics=
 we
> discussed.  It seems quite challenging.  With the current codebase, w=
e'd
> have to bail out in the middle of the enable sequence.  Then we'd los=
e the
> clockdomain state (the 'hwsup' variable).
>
> So I've updated the patch to essentially bail out early from all hwmo=
d
> enable, idle, and shutdown code, if any hardreset lines associated wi=
th
> the IP block are asserted.  It will then be the driver integration co=
de's
> responsibility for enabling the IP block when the hardreset lines are
> asserted.  When the hardreset lines are deasserted, the usual hwmod c=
ode
> will be executed -- I'd assume this would be the case during normal
> operation of the device.  I think this is probably the best we can do
> until we actually hear back from the people responsible for drivers f=
or
> these special IP blocks.
>
> A revised patch is below.  Care to take a look and see if it makes se=
nse
> to you?
>
>
> regards,
>
> - Paul
>
>
> From: Paul Walmsley<paul@pwsan.com>
> Date: Wed, 18 Apr 2012 19:10:04 -0600
> Subject: [PATCH] ARM: OMAP2+: hwmod: revise hardreset behavior
>
> Change the way that hardreset lines are handled by the hwmod code.
> Hardreset lines are generally associated with initiator IP blocks.
> Prior to this change, the hwmod code expected to control hardreset
> lines itself, asserting them on shutdown and deasserting them upon
> enable.  But driver authors inside TI have commented to us that their
> drivers require direct control over these lines.  Unfortunately, thes=
e
> drivers haven't been posted publicly yet, so it's hard to determine
> exactly what is needed, a priori.  This change attempts to set forth
> some reasonable semantics that should be an improvement over the
> current code.
>
> The semantics implemented by this patch are as follows:
>
> - If the hwmod is not marked with HWMOD_INIT_NO_RESET, then assert al=
l
>    associated hardreset lines during IP block setup.  This is intende=
d
>    to place the IP blocks into a known state that will not interfere
>    with other devices during kernel boot.
>
> - IP blocks with hardreset lines will not be automatically enabled or
>    idled during setup.  Instead, they will be left in the INITIALIZED
>    state.
>
> - When the hwmod code is asked to enable, idle, or shutdown an IP
>    block with asserted hardreset lines, the hwmod code will do nothin=
g.
>    The driver integration code must do the remaining work needed to
>    control these IP blocks.  Once this driver integration code is pos=
ted
>    to the lists, hopefully we can consolidate it and move it inside t=
he
>    hwmod code.
>
> Custom reset functions for IP blocks with hardreset lines still shoul=
d
> be supported and are strongly endorsed.  It is intended that every
> subsystem with hardreset lines should have a custom reset function
> that can place their subsystem into quiescent idle with the hardreset
> lines deasserted.
>
> This reverts most of commit 5365efbe29250a227502256cc912351fe2157b42
> ("OMAP: hwmod: Add hardreset management support").  Later code
> reorganizations caused the sequencing of the code from this patch to
> be changed, anyway.
>
> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> Cc: Beno=EEt Cousson<b-cousson@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c |  140 ++++++++++++++++++++++-----=
-----------
>   1 file changed, 83 insertions(+), 57 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/o=
map_hwmod.c
> index e6aa14f..a5c3a9a 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -781,39 +781,6 @@ static int _omap4_wait_target_disable(struct oma=
p_hwmod *oh)
>   }
>
>   /**
> - * _omap4_disable_module - enable CLKCTRL modulemode on OMAP4
> - * @oh: struct omap_hwmod *
> - *
> - * Disable the PRCM module mode related to the hwmod @oh.
> - * Return EINVAL if the modulemode is not supported and 0 in case of=
 success.
> - */
> -static int _omap4_disable_module(struct omap_hwmod *oh)
> -{
> -	int v;
> -
> -	/* The module mode does not exist prior OMAP4 */
> -	if (!cpu_is_omap44xx())
> -		return -EINVAL;
> -
> -	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
> -		return -EINVAL;
> -
> -	pr_debug("omap_hwmod: %s: %s\n", oh->name, __func__);
> -
> -	omap4_cminst_module_disable(oh->clkdm->prcm_partition,
> -				    oh->clkdm->cm_inst,
> -				    oh->clkdm->clkdm_offs,
> -				    oh->prcm.omap4.clkctrl_offs);
> -
> -	v =3D _omap4_wait_target_disable(oh);
> -	if (v)
> -		pr_warn("omap_hwmod: %s: _wait_target_disable failed\n",
> -			oh->name);
> -
> -	return 0;
> -}
> -
> -/**
>    * _count_mpu_irqs - count the number of MPU IRQ lines associated w=
ith @oh
>    * @oh: struct omap_hwmod *oh
>    *
> @@ -1378,6 +1345,66 @@ static int _read_hardreset(struct omap_hwmod *=
oh, const char *name)
>   }
>
>   /**
> + * _are_any_hardreset_lines_asserted - return true if part of @oh is=
 hard-reset
> + * @oh: struct omap_hwmod *
> + *
> + * If any hardreset line associated with @oh is asserted, then retur=
n true.
> + * Otherwise, if @oh has no hardreset lines associated with it, or i=
f
> + * no hardreset lines associated with @oh are asserted, then return =
false.
> + * This function is used to avoid executing some parts of the IP blo=
ck
> + * enable/disable sequence if a hardreset line is set.
> + */
> +static bool _are_any_hardreset_lines_asserted(struct omap_hwmod *oh)
> +{
> +	int i;
> +
> +	if (oh->rst_lines_cnt =3D=3D 0)
> +		return false;
> +
> +	for (i =3D 0; i<  oh->rst_lines_cnt; i++)
> +		if (_read_hardreset(oh, oh->rst_lines[i].name)>  0)
> +			return true;
> +
> +	return false;
> +}
> +
> +/**
> + * _omap4_disable_module - enable CLKCTRL modulemode on OMAP4
> + * @oh: struct omap_hwmod *
> + *
> + * Disable the PRCM module mode related to the hwmod @oh.
> + * Return EINVAL if the modulemode is not supported and 0 in case of=
 success.
> + */
> +static int _omap4_disable_module(struct omap_hwmod *oh)
> +{
> +	int v;
> +
> +	/* The module mode does not exist prior OMAP4 */
> +	if (!cpu_is_omap44xx())
> +		return -EINVAL;
> +
> +	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
> +		return -EINVAL;
> +
> +	pr_debug("omap_hwmod: %s: %s\n", oh->name, __func__);
> +
> +	omap4_cminst_module_disable(oh->clkdm->prcm_partition,
> +				    oh->clkdm->cm_inst,
> +				    oh->clkdm->clkdm_offs,
> +				    oh->prcm.omap4.clkctrl_offs);
> +
> +	if (_are_any_hardreset_lines_asserted(oh))
> +		return 0;
> +
> +	v =3D _omap4_wait_target_disable(oh);
> +	if (v)
> +		pr_warn("omap_hwmod: %s: _wait_target_disable failed\n",
> +			oh->name);
> +
> +	return 0;
> +}
> +
> +/**
>    * _ocp_softreset - reset an omap_hwmod via the OCP_SYSCONFIG bit
>    * @oh: struct omap_hwmod *
>    *
> @@ -1519,7 +1546,7 @@ static int _reset(struct omap_hwmod *oh)
>    */
>   static int _enable(struct omap_hwmod *oh)
>   {
> -	int r, i;
> +	int r;
>   	int hwsup =3D 0;
>
>   	pr_debug("omap_hwmod: %s: enabling\n", oh->name);
> @@ -1551,14 +1578,16 @@ static int _enable(struct omap_hwmod *oh)
>   	}
>
>   	/*
> -	 * If an IP contains HW reset lines, then de-assert them in order
> -	 * to allow the module state transition. Otherwise the PRCM will re=
turn
> -	 * Intransition status, and the init will failed.
> +	 * If an IP block contains HW reset lines and any of them are
> +	 * asserted, we let integration code associated with that
> +	 * block handle the enable.  We've received very little
> +	 * information on what those driver authors need, and until
> +	 * detailed information is provided and the driver code is
> +	 * posted to the public lists, this is probably the best we
> +	 * can do.

Maybe we should keep that with some mechanism to prevent it for some IP=
=20
like processors .

I guess that with that patch, we cannot enable anymore IPU/DSP and IVA=20
at boot time.

Otherwise, it looks fine to me.

Thanks,
Benoit

>   	 */
> -	if (oh->_state =3D=3D _HWMOD_STATE_INITIALIZED ||
> -	    oh->_state =3D=3D _HWMOD_STATE_DISABLED)
> -		for (i =3D 0; i<  oh->rst_lines_cnt; i++)
> -			_deassert_hardreset(oh, oh->rst_lines[i].name);
> +	if (_are_any_hardreset_lines_asserted(oh))
> +		return 0;
>
>   	/* Mux pins for device runtime if populated */
>   	if (oh->mux&&  (!oh->mux->enabled ||
> @@ -1633,6 +1662,9 @@ static int _idle(struct omap_hwmod *oh)
>   		return -EINVAL;
>   	}
>
> +	if (_are_any_hardreset_lines_asserted(oh))
> +		return 0;
> +
>   	if (oh->class->sysc)
>   		_idle_sysc(oh);
>   	_del_initiator_dep(oh, mpu_oh);
> @@ -1715,6 +1747,9 @@ static int _shutdown(struct omap_hwmod *oh)
>   		return -EINVAL;
>   	}
>
> +	if (_are_any_hardreset_lines_asserted(oh))
> +		return 0;
> +
>   	pr_debug("omap_hwmod: %s: disabling\n", oh->name);
>
>   	if (oh->class->pre_shutdown) {
> @@ -1824,27 +1859,18 @@ static int __init _setup_reset(struct omap_hw=
mod *oh)
>   	if (oh->_state !=3D _HWMOD_STATE_INITIALIZED)
>   		return -EINVAL;
>
> -	/*
> -	 * In the case of hwmod with hardreset that should not be
> -	 * de-assert at boot time, we have to keep the module
> -	 * initialized, because we cannot enable it properly with the
> -	 * reset asserted. Exit without warning because that behavior
> -	 * is expected.
> -	 */
> -	if ((oh->flags&  HWMOD_INIT_NO_RESET)&&  oh->rst_lines_cnt>  0)
> -		return 0;
> -
> -	r =3D _enable(oh);
> -	if (r) {
> -		pr_warning("omap_hwmod: %s: cannot be enabled (%d)\n",
> -			   oh->name, oh->_state);
> -		return 0;
> +	if (oh->rst_lines_cnt =3D=3D 0) {
> +		r =3D _enable(oh);
> +		if (r) {
> +			pr_warning("omap_hwmod: %s: cannot be enabled for reset (%d)\n",
> +				   oh->name, oh->_state);
> +			return -EINVAL;
> +		}
>   	}
>
>   	if (!(oh->flags&  HWMOD_INIT_NO_RESET))
>   		r =3D _reset(oh);
>
> -
>   	return r;
>   }
>   /**

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
