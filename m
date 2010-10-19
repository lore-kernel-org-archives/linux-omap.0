From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH] omap2plus: wdt: Fix boot warn when CONFIG_PM_RUNTIME=n
Date: Tue, 19 Oct 2010 16:57:40 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030D170ABE@dbde02.ent.ti.com>
References: <1286798556-22749-1-git-send-email-charu@ti.com>
 <4CB40B07.8080301@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB030CFC553C@dbde02.ent.ti.com>
 <4CB45E0E.6080104@ti.com> <87mxqj1d2v.fsf@deeprootsystems.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB030D09A22D@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1010141234190.21196@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49907 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758274Ab0JSL1t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 07:27:49 -0400
In-Reply-To: <alpine.DEB.2.00.1010141234190.21196@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Friday, October 15, 2010 12:08 AM
> To: Varadarajan, Charulatha
> Cc: Kevin Hilman; Cousson, Benoit; linux-omap@vger.kernel.org
> Subject: RE: [PATCH] omap2plus: wdt: Fix boot warn when
> CONFIG_PM_RUNTIME=3Dn
>
> Hello Charu, Kevin, Beno=EEt,
>
> On Thu, 14 Oct 2010, Varadarajan, Charulatha wrote:
>
> > Please provide your input on this.
>
> Thinking about this problem -- and the earlier problem of how to
> determine what state to leave the watchdog in -- what occurs to me is
> that we should probably:

Thanks for providing detailed input on this.

>
> 1. add a function pointer in the struct omap_hwmod_class for a custom
>    pre-shutdown function, called before clocks are disabled, etc.; th=
at
>    can do the appropriate register writes needed during an
>    omap_hwmod_shutdown() while the device is still considered to be
>    enabled;
>
> 2. add a function to allow OMAP core code or board-*.c code to tell
>    the hwmod code to leave a hwmod disabled at the end of _setup(),
>    rather than idled or left enabled -- something like
>    omap_hwmod_set_postsetup_state(HWMOD_STATE_DISABLED);
>
> 3. look to see if we can detect if the watchdog is enabled before the
>    hwmod code starts -- perhaps by reading WSPR? -- and if it is not
>    enabled, calling
>    omap_hwmod_set_postsetup_state(HWMOD_STATE_DISABLED) prior to
>    calling omap_hwmod_late_init();
>
> 4. disable the MPU watchdog by default if #3 is not possible, and the=
n
>    allow specific board files to indicate that it should be enabled i=
f
>    they want full kernel boot watchdog coverage with something like
>    omap_hwmod_set_postsetup_state(HWMOD_STATE_IDLE); and possibly als=
o
>    add a kernel command line parameter like "enable_omapwdt_boot" tha=
t
>    can specify that the watchdog should be left enabled upon boot.
>
> This arrangement is a little more complicated, but it ensures that
> omap_hwmod_shutdown() really will shut down the watchdog.  It also
> makes it possible for individual board files or bootloader
> configurations to ensure full watchdog coverage of the kernel
> initialization process.  If I were designing a commercial OMAP-based
> device, I'd probably want full watchdog coverage of the entire boot
> process from the bootloader onwards.  But simultaneously we don't wan=
t
> to change the existing kernel behavior too much -- most of our
> developer users would probably be shocked if, upon upgrading to a new
> kernel, suddenly the watchdog started rebooting their machines -- so
> it makes sense to me to disable the watchdog unless instructed
> otherwise.
>
> Enclosed below is a work-in-progress patch to illustrate the proposal=
=2E
> It clearly needs some more work and should be split into at least two
> patches, but it might help clarify what I am proposing.
>
> We also should, IMHO, move the struct omap_hwmod_class definitions ou=
t of
> the main hwmod data files, since they may contain function pointers. =
 (We
> will probably also need a .reset function pointer there also to deal
> with complicated IPs like the IVA2, as we discussed a few months ago.=
)
> We should try to restrict the main omap_hwmod data files to be relati=
vely
> OS-independent data structures.
>
> Regarding the omap_hwmod_is_enabled() proposal: it seems racy to me. =
 In
> theory the system state can change after the result of
> omap_hwmod_is_enabled() is tested, but before the consequence of the
> conditional statement runs.  There used to be a similar problem in th=
e
> clock framework with a clk_is_enabled() function (a similar race stil=
l
> exists with the clk_get_rate() function).  If possible, I think we
> should try to avoid creating APIs that are explicitly racy.
>
> Charu, I think that functions like omap2_disable_wdt() and any relate=
d
> watchdog device manipulation functions should go into their own file
> -- something like arch/arm/mach-omap2/wd_timer.c ? -- and not live in
> devices.c.

Yes, you are right. I can do this in a new file
arch/arm/mach-omap2/wd_timer.c. After doing this, I can also move the
omap_device_build of wdt device from devices.c to mach-omap2/wd_timer.c=
=2E

-V Charulatha

>
> One last thing: Beno=EEt, in the hwmod data, I think we should separa=
te
> watchdog IPs that are automatically enabled upon reset (like the MPU
> watchdog), from watchdogs that are disabled after reset (like the IVA=
2
> watchdog).  It doesn't matter to me whether we create a second class,
> or whether we just use a dev_attr flag.  If we separate these, then
> code can use omap_hwmod_for_each_class() to ensure that all watchdogs
> of this type are disabled upon boot, rather than hardcoding a specifi=
c
> hwmod.
>
>
> Thoughts?
>
> ...
>
> As an aside, we seem to again be skirting issues of what it means for
> a hwmod to be "enabled" and "idle."  If we read "enabled" as "fully
> functional and registers accessible," that seems to make sense; but i=
f
> we consider idle as meaning "configured but nonfunctional," that does
> not match up to the state that modules like WDT and GPIO are left in.
> The issue with WDT is that it probably does not IdleAck when enabled
> and its clocks are turned off, as Beno=EEt mentioned; and the issue w=
ith
> GPIO is that it can generate asynchronous interrupts, even when all
> its clocks are off.  It would be good if we could clarify the
> semantics for these states in some formal way.  Perhaps more states
> are needed at the hwmod level?  Or perhaps we just need to clarify
> what "idle" really means...
>
>
> - Paul
>
>
> From 2e05f1c33b2c5b081146079a2908fe5bbb4350d6 Mon Sep 17 00:00:00 200=
1
> From: Paul Walmsley <paul@pwsan.com>
> Date: Thu, 14 Oct 2010 11:47:46 -0600
> Subject: [RFC PATCH] OMAP2+: hwmod: add postsetup state suppotr
>
> Experimental, didactic patch to add postsetup state, selected at runt=
ime.
> This patch needs major work before merging; it's simply intended to
> illustrate a proposal.
>
> Not-yet-signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/io.c                     |   53 ++++++++++++++++=
++++-
> --
>  arch/arm/mach-omap2/omap_hwmod.c             |   59 ++++++++++++++++=
+++--
> -----
>  arch/arm/plat-omap/include/plat/omap_hwmod.h |   16 +++++++-
>  3 files changed, 105 insertions(+), 23 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 40562dd..e3a423d 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -311,10 +311,15 @@ static int __init _omap2_init_reprogram_sdrc(vo=
id)
>       return v;
>  }
>
> -void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
> -                              struct omap_sdrc_params *sdrc_cs1)
> +/* XXX document */
> +static int _set_hwmod_postsetup_state(struct omap_hwmod *oh, void *d=
ata)
> +{
> +     return omap_hwmod_set_postsetup_state(oh, *(u8 *)data);
> +}
> +
> +static void __init omap2_init_common_infra(void)
>  {
> -     u8 skip_setup_idle =3D 0;
> +     u8 postsetup_state;
>
>       pwrdm_init(powerdomains_omap);
>       clkdm_init(clockdomains_omap, clkdm_autodeps);
> @@ -327,6 +332,24 @@ void __init omap2_init_common_hw(struct
> omap_sdrc_params *sdrc_cs0,
>       else if (cpu_is_omap44xx())
>               omap44xx_hwmod_init();
>
> +     /* Set the default postsetup state for all hwmods ... */
> +#ifdef CONFIG_PM_RUNTIME
> +     postsetup_state =3D _HWMOD_STATE_IDLE;
> +#else
> +     postsetup_state =3D _HWMOD_STATE_ENABLED;
> +#endif
> +     omap_hwmod_for_each(_set_hwmod_postsetup_state, &postsetup_stat=
e);
> +
> +     /* ... then handle the exceptions for unusual modules (like MPU=
 WDT)
> */
> +     /*
> +      * XXX ideally we could detect whether the MPU WDT was currentl=
y
> +      * enabled here and make this conditional
> +      */
> +     postsetup_state =3D _HWMOD_STATE_DISABLED;
> +     omap_hwmod_for_each_by_class("wd_timer_enabled_on_reset",
> +                                  _set_hwmod_postsetup_state,
> +                                  &postsetup_state);
> +
>       /* The OPP tables have to be registered before a clk init */
>       omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
>
> @@ -340,16 +363,32 @@ void __init omap2_init_common_hw(struct
> omap_sdrc_params *sdrc_cs0,
>               omap4xxx_clk_init();
>       else
>               pr_err("Could not init clock framework - unknown CPU\n"=
);
> +}
>
> +static void __init omap2_init_common_devices(struct omap_sdrc_params
> *sdrc_cs0,
> +                                          struct omap_sdrc_params *s=
drc_cs1)
> +{
>       omap_serial_early_init();
>
> -#ifndef CONFIG_PM_RUNTIME
> -     skip_setup_idle =3D 1;
> -#endif
> -     omap_hwmod_late_init(skip_setup_idle);
> +     omap_hwmod_late_init();
> +
>       if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
>               omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
>               _omap2_init_reprogram_sdrc();
>       }
>       gpmc_init();
>  }
> +
> +/*
> + * XXX this function should go away and the board-*.c files should c=
all
> + * both omap2_init_common_infra() and omap2_init_common_devices(),
> + * so the board-*.c files can override some default hwmod
> postsetup_states
> + * (e.g., for watchdog) between the two functions.
> + */
> +void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
> +                              struct omap_sdrc_params *sdrc_cs1)
> +{
> +     omap2_init_common_infra();
> +     omap2_init_common_devices(sdrc_cs0, sdrc_cs1);
> +}
> +
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-
> omap2/omap_hwmod.c
> index 5a30658..618e135 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1298,24 +1298,19 @@ static int _shutdown(struct omap_hwmod *oh)
>  /**
>   * _setup - do initial configuration of omap_hwmod
>   * @oh: struct omap_hwmod *
> - * @skip_setup_idle_p: do not idle hwmods at the end of the fn if 1
>   *
>   * Writes the CLOCKACTIVITY bits @clockact to the hwmod @oh
> - * OCP_SYSCONFIG register.  @skip_setup_idle is intended to be used =
on
> - * a system that will not call omap_hwmod_enable() to enable devices
> - * (e.g., a system without PM runtime).  Returns -EINVAL if the hwmo=
d
> - * is in the wrong state or returns 0.
> + * OCP_SYSCONFIG register.  Returns -EINVAL if the hwmod is in the
> + * wrong state or returns 0.
>   */
>  static int _setup(struct omap_hwmod *oh, void *data)
>  {
>       int i, r;
> -     u8 skip_setup_idle;
> +     u8 postsetup_state;
>
>       if (!oh || !data)
>               return -EINVAL;
>
> -     skip_setup_idle =3D *(u8 *)data;
> -
>       /* Set iclk autoidle mode */
>       if (oh->slaves_cnt > 0) {
>               for (i =3D 0; i < oh->slaves_cnt; i++) {
> @@ -1368,8 +1363,24 @@ static int _setup(struct omap_hwmod *oh, void
> *data)
>               }
>       }
>
> -     if (!(oh->flags & HWMOD_INIT_NO_IDLE) && !skip_setup_idle)
> +     postsetup_state =3D oh->_postsetup_state;
> +     if (postsetup_state =3D=3D _HWMOD_STATE_UNKNOWN)
> +             postsetup_state =3D _HWMOD_STATE_ENABLED;
> +
> +     /*
> +      * XXX HWMOD_INIT_NO_IDLE does not belong in hwmod data -
> +      * it should be set by the core code as a runtime flag during
> startup
> +      */
> +     if (!(oh->flags & HWMOD_INIT_NO_IDLE))
> +             postsetup_state =3D _HWMOD_STATE_IDLE;
> +
> +     if (postsetup_state =3D=3D _HWMOD_STATE_IDLE)
>               _omap_hwmod_idle(oh);
> +     else if (postsetup_state =3D=3D _HWMOD_STATE_DISABLED)
> +             _shutdown(oh);
> +     else
> +             WARN(1, "hwmod: %s: unknown postsetup state %d! default=
ing to
> enabled\n",
> +                  oh->name, postsetup_state);
>
>       return 0;
>  }
> @@ -1570,13 +1581,12 @@ int omap_hwmod_init(struct omap_hwmod **ohs)
>
>  /**
>   * omap_hwmod_late_init - do some post-clock framework initializatio=
n
> - * @skip_setup_idle: if 1, do not idle hwmods in _setup()
>   *
>   * Must be called after omap2_clk_init().  Resolves the struct clk n=
ames
>   * to struct clk pointers for each registered omap_hwmod.  Also call=
s
>   * _setup() on each hwmod.  Returns 0.
>   */
> -int omap_hwmod_late_init(u8 skip_setup_idle)
> +int omap_hwmod_late_init(void)
>  {
>       int r;
>
> @@ -1588,10 +1598,7 @@ int omap_hwmod_late_init(u8 skip_setup_idle)
>       WARN(!mpu_oh, "omap_hwmod: could not find MPU initiator hwmod %=
s\n",
>            MPU_INITIATOR_NAME);
>
> -     if (skip_setup_idle)
> -             pr_debug("omap_hwmod: will leave hwmods enabled during
> setup\n");
> -
> -     omap_hwmod_for_each(_setup, &skip_setup_idle);
> +     omap_hwmod_for_each(_setup, NULL);
>
>       return 0;
>  }
> @@ -2117,3 +2124,25 @@ int omap_hwmod_for_each_by_class(const char
> *classname,
>       return ret;
>  }
>
> +
> +/**
> + * omap_hwmod_set_postsetup_state - set the post-_setup() state for =
this
> hwmod
> + * @oh: struct omap_hwmod *
> + * @state: state that _setup() should leave the hwmod in
> + *
> + * XXX document
> + *
> + */
> +int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state)
> +{
> +     if (!oh)
> +             return -EINVAL;
> +
> +     /* XXX insure valid @state passed in */
> +
> +     mutex_lock(&oh->_mutex);
> +     oh->_postsetup_state =3D state;
> +     mutex_unlock(&oh->_mutex);
> +
> +     return 0;
> +}
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/=
plat-
> omap/include/plat/omap_hwmod.h
> index 7eaa8ed..a566efc 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -415,14 +415,24 @@ struct omap_hwmod_omap4_prcm {
>   * @name: name of the hwmod_class
>   * @sysc: device SYSCONFIG/SYSSTATUS register data
>   * @rev: revision of the IP class
> + * @pre_shutdown: fn ptr to be executed immediately prior to device
> shutdown
>   *
>   * Represent the class of a OMAP hardware "modules" (e.g. timer,
>   * smartreflex, gpio, uart...)
> + *
> + * @pre_shutdown is a function that will be run immediately before
> + * hwmod clocks are disabled, etc.  It is intended for use for hwmod=
s
> + * like the MPU watchdog, which cannot be disabled with the standard
> + * omap_hwmod_shutdown().  The function should return 0 upon success=
,
> + * or some negative error upon failure.  Returning an error will cau=
se
> + * omap_hwmod_shutdown() to abort the device shutdown and return an
> + * error.
>   */
>  struct omap_hwmod_class {
>       const char                              *name;
>       struct omap_hwmod_class_sysconfig       *sysc;
>       u32                                     rev;
> +     int                                     (*pre_shutdown)(struct =
omap_hwmod
> *oh);
>  };
>
>  /**
> @@ -452,6 +462,7 @@ struct omap_hwmod_class {
>   * @response_lat: device OCP response latency (in interface clock cy=
cles)
>   * @_int_flags: internal-use hwmod flags
>   * @_state: internal-use hwmod state
> + * @_postsetup_state: internal-use state to leave the hwmod in after
> _setup()
>   * @flags: hwmod flags (documented below)
>   * @omap_chip: OMAP chips this hwmod is present on
>   * @_mutex: mutex serializing operations on this hwmod
> @@ -500,6 +511,7 @@ struct omap_hwmod {
>       u8                              hwmods_cnt;
>       u8                              _int_flags;
>       u8                              _state;
> +     u8                              _postsetup_state;
>       const struct omap_chip_id       omap_chip;
>  };
>
> @@ -509,7 +521,7 @@ int omap_hwmod_unregister(struct omap_hwmod *oh);
>  struct omap_hwmod *omap_hwmod_lookup(const char *name);
>  int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data)=
,
>                       void *data);
> -int omap_hwmod_late_init(u8 skip_setup_idle);
> +int omap_hwmod_late_init(void);
>
>  int omap_hwmod_enable(struct omap_hwmod *oh);
>  int _omap_hwmod_enable(struct omap_hwmod *oh);
> @@ -556,6 +568,8 @@ int omap_hwmod_for_each_by_class(const char *clas=
sname,
>                                          void *user),
>                                void *user);
>
> +int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state);
> +
>  /*
>   * Chip variant-specific hwmod init routines - XXX should be convert=
ed
>   * to use initcalls once the initial boot ordering is straightened o=
ut
> --
> 1.7.1
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
