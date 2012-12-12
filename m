From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 05/10] ARM: OMAP2+: PM/powerdomain: move
 omap_set_pwrdm_state() to powerdomain code
Date: Wed, 12 Dec 2012 10:31:33 +0100
Message-ID: <CAORVsuXw6wgK+P5=9LtGHnoLtE4epwWe75by8nmmvSRHfDrdMQ@mail.gmail.com>
References: <20121209011755.19716.25244.stgit@dusk.lan>
 <20121209012339.19716.10548.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9037736686913438077=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121209012339.19716.10548.stgit@dusk.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============9037736686913438077==
Content-Type: multipart/alternative; boundary=f46d0447a12dcdd18204d0a4761f

--f46d0447a12dcdd18204d0a4761f
Content-Type: text/plain; charset=ISO-8859-1

Hi Paul,

On Sun, Dec 9, 2012 at 2:23 AM, Paul Walmsley <paul@pwsan.com> wrote:

> Move omap_set_pwrdm_state() from the PM code to the powerdomain code,
> and refactor it to split it up into several functions.  A subsequent patch
> will rename it to conform with the existing powerdomain function names.
>
Glad to see this rather cryptic function getting a rewrite. It had never
been clear what the function is doing so I think it owes some more comments.

More comments below.

>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Jean Pihet <jean.pihet@newoldbits.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/pm.c          |   61 --------------------
>  arch/arm/mach-omap2/pm.h          |    1
>  arch/arm/mach-omap2/powerdomain.c |  112
> +++++++++++++++++++++++++++----------
>  arch/arm/mach-omap2/powerdomain.h |    3 +
>  4 files changed, 85 insertions(+), 92 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index cc8ed0f..2e2a897 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -76,10 +76,6 @@ static void __init omap2_init_processor_devices(void)
>         }
>  }
>
> -/* Types of sleep_switch used in omap_set_pwrdm_state */
> -#define FORCEWAKEUP_SWITCH     0
> -#define LOWPOWERSTATE_SWITCH   1
> -
>  int __init omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused)
>  {
>         if ((clkdm->flags & CLKDM_CAN_ENABLE_AUTO) &&
> @@ -92,63 +88,6 @@ int __init omap_pm_clkdms_setup(struct clockdomain
> *clkdm, void *unused)
>  }
>
>  /*
> - * This sets pwrdm state (other than mpu & core. Currently only ON &
> - * RET are supported.
> - */
> -int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 pwrst)
> -{
> -       u8 curr_pwrst, next_pwrst;
> -       int sleep_switch = -1, ret = 0, hwsup = 0;
> -
> -       if (!pwrdm || IS_ERR(pwrdm))
> -               return -EINVAL;
> -
> -       while (!(pwrdm->pwrsts & (1 << pwrst))) {
> -               if (pwrst == PWRDM_POWER_OFF)
> -                       return ret;
> -               pwrst--;
> -       }
> -
> -       next_pwrst = pwrdm_read_next_pwrst(pwrdm);
> -       if (next_pwrst == pwrst)
> -               return ret;
> -
> -       curr_pwrst = pwrdm_read_pwrst(pwrdm);
> -       if (curr_pwrst < PWRDM_POWER_ON) {
> -               if ((curr_pwrst > pwrst) &&
> -                       (pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE)) {
> -                       sleep_switch = LOWPOWERSTATE_SWITCH;
> -               } else {
> -                       hwsup = clkdm_in_hwsup(pwrdm->pwrdm_clkdms[0]);
> -                       clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
> -                       sleep_switch = FORCEWAKEUP_SWITCH;
> -               }
> -       }
> -
> -       ret = pwrdm_set_next_pwrst(pwrdm, pwrst);
> -       if (ret)
> -               pr_err("%s: unable to set power state of powerdomain:
> %s\n",
> -                      __func__, pwrdm->name);
> -
> -       switch (sleep_switch) {
> -       case FORCEWAKEUP_SWITCH:
> -               if (hwsup)
> -                       clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
> -               else
> -                       clkdm_sleep(pwrdm->pwrdm_clkdms[0]);
> -               break;
> -       case LOWPOWERSTATE_SWITCH:
> -               pwrdm_set_lowpwrstchange(pwrdm);
> -               pwrdm_state_switch(pwrdm);
> -               break;
> -       }
> -
> -       return ret;
> -}
> -
> -
> -
> -/*
>   * This API is to be called during init to set the various voltage
>   * domains to the voltage as per the opp table. Typically we boot up
>   * at the nominal voltage. So this function finds out the rate of
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 686137d..707e9cb 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -33,7 +33,6 @@ static inline int omap4_idle_init(void)
>  extern void *omap3_secure_ram_storage;
>  extern void omap3_pm_off_mode_enable(int);
>  extern void omap_sram_idle(void);
> -extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
>  extern int omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused);
>  extern int (*omap_pm_suspend)(void);
>
> diff --git a/arch/arm/mach-omap2/powerdomain.c
> b/arch/arm/mach-omap2/powerdomain.c
> index 97b3881..05f00660 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -921,35 +921,6 @@ bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm)
>         return (pwrdm && pwrdm->flags & PWRDM_HAS_HDWR_SAR) ? 1 : 0;
>  }
>
> -/**
> - * pwrdm_set_lowpwrstchange - Request a low power state change
> - * @pwrdm: struct powerdomain *
> - *
> - * Allows a powerdomain to transtion to a lower power sleep state
> - * from an existing sleep state without waking up the powerdomain.
> - * Returns -EINVAL if the powerdomain pointer is null or if the
> - * powerdomain does not support LOWPOWERSTATECHANGE, or returns 0
> - * upon success.
> - */
>

Can this kerneldoc be reused in the new code?

-int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
> -{
> -       int ret = -EINVAL;
> -
> -       if (!pwrdm)
> -               return -EINVAL;
> -
> -       if (!(pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE))
> -               return -EINVAL;
> -
> -       pr_debug("powerdomain: %s: setting LOWPOWERSTATECHANGE bit\n",
> -                pwrdm->name);
> -
> -       if (arch_pwrdm && arch_pwrdm->pwrdm_set_lowpwrstchange)
> -               ret = arch_pwrdm->pwrdm_set_lowpwrstchange(pwrdm);
> -
> -       return ret;
> -}
> -
>  int pwrdm_state_switch(struct powerdomain *pwrdm)
>  {
>         int ret;
> @@ -984,6 +955,89 @@ int pwrdm_post_transition(struct powerdomain *pwrdm)
>         return 0;
>  }
>
> +/* Types of sleep_switch used in omap_set_pwrdm_state */
> +#define ALREADYACTIVE_SWITCH   0
> +#define FORCEWAKEUP_SWITCH     1
> +#define LOWPOWERSTATE_SWITCH   2
>

Could you add some more documentation here?
What is the goal of the function, what does it return etc. ?


> +
> +static u8 _pwrdm_save_clkdm_state_and_activate(struct powerdomain *pwrdm,
> +                                              u8 pwrst, bool *hwsup)

+{
> +       u8 curr_pwrst, sleep_switch;
> +
> +       curr_pwrst = pwrdm_read_pwrst(pwrdm);
> +       if (curr_pwrst < PWRDM_POWER_ON) {
> +               if (curr_pwrst > pwrst &&
> +                   pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE &&
> +                   arch_pwrdm->pwrdm_set_lowpwrstchange) {
> +                       sleep_switch = LOWPOWERSTATE_SWITCH;
> +               } else {
> +                       *hwsup = clkdm_in_hwsup(pwrdm->pwrdm_clkdms[0]);
> +                       clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
> +                       sleep_switch = FORCEWAKEUP_SWITCH;
> +               }
> +       } else {
> +               sleep_switch = ALREADYACTIVE_SWITCH;
> +       }
> +
> +       return sleep_switch;
> +}
> +
>

Same here


> +static void _pwrdm_restore_clkdm_state(struct powerdomain *pwrdm,
> +                                      u8 sleep_switch, bool hwsup)
> +{
> +       switch (sleep_switch) {
> +       case FORCEWAKEUP_SWITCH:
> +               if (hwsup)
> +                       clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
> +               else
> +                       clkdm_sleep(pwrdm->pwrdm_clkdms[0]);
> +               break;
> +       case LOWPOWERSTATE_SWITCH:
> +               if (pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE &&
> +                   arch_pwrdm->pwrdm_set_lowpwrstchange)
> +                       arch_pwrdm->pwrdm_set_lowpwrstchange(pwrdm);
> +               pwrdm_state_switch(pwrdm);
> +               break;
> +       }
> +}
> +
> +/*
> + * This sets pwrdm state (other than mpu & core. Currently only ON &
> + * RET are supported.
> + */
>
Same here.
Is this one correct?

Regards,
Jean


> +int omap_set_pwrdm_state(struct powerdomain *pwrdm, u8 pwrst)
> +{
> +       u8 next_pwrst, sleep_switch;
> +       int ret = 0;
> +       bool hwsup = false;
> +
> +       if (!pwrdm || IS_ERR(pwrdm))
> +               return -EINVAL;
> +
> +       while (!(pwrdm->pwrsts & (1 << pwrst))) {
> +               if (pwrst == PWRDM_POWER_OFF)
> +                       return ret;
> +               pwrst--;
> +       }
> +
> +       next_pwrst = pwrdm_read_next_pwrst(pwrdm);
> +       if (next_pwrst == pwrst)
> +               return ret;
> +
> +       sleep_switch = _pwrdm_save_clkdm_state_and_activate(pwrdm, pwrst,
> +                                                           &hwsup);
> +
> +       ret = pwrdm_set_next_pwrst(pwrdm, pwrst);
> +       if (ret)
> +               pr_err("%s: unable to set power state of powerdomain:
> %s\n",
> +                      __func__, pwrdm->name);
> +
> +       _pwrdm_restore_clkdm_state(pwrdm, sleep_switch, hwsup);
> +
> +       return ret;
> +}
> +
>  /**
>   * pwrdm_get_context_loss_count - get powerdomain's context loss count
>   * @pwrdm: struct powerdomain * to wait for
> diff --git a/arch/arm/mach-omap2/powerdomain.h
> b/arch/arm/mach-omap2/powerdomain.h
> index 7c1534b..1edb3b7 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -228,10 +228,11 @@ bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm);
>  int pwrdm_state_switch(struct powerdomain *pwrdm);
>  int pwrdm_pre_transition(struct powerdomain *pwrdm);
>  int pwrdm_post_transition(struct powerdomain *pwrdm);
> -int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
>  int pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
>  bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
>
> +extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u8 state);
> +
>  extern void omap242x_powerdomains_init(void);
>  extern void omap243x_powerdomains_init(void);
>  extern void omap3xxx_powerdomains_init(void);
>
>
>

--f46d0447a12dcdd18204d0a4761f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Paul,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Su=
n, Dec 9, 2012 at 2:23 AM, Paul Walmsley <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:paul@pwsan.com" target=3D"_blank">paul@pwsan.com</a>&gt;</span> wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
Move omap_set_pwrdm_state() from the PM code to the powerdomain code,<br>
and refactor it to split it up into several functions. =A0A subsequent patc=
h<br>
will rename it to conform with the existing powerdomain function names.<br>=
</blockquote><div>Glad to see this rather cryptic function getting a rewrit=
e. It had never been clear what the function is doing so I think it owes so=
me more comments.<br>
<br>More comments below. <br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
Signed-off-by: Paul Walmsley &lt;<a href=3D"mailto:paul@pwsan.com">paul@pws=
an.com</a>&gt;<br>
Cc: Jean Pihet &lt;<a href=3D"mailto:jean.pihet@newoldbits.com">jean.pihet@=
newoldbits.com</a>&gt;<br>
Cc: Kevin Hilman &lt;<a href=3D"mailto:khilman@deeprootsystems.com">khilman=
@deeprootsystems.com</a>&gt;<br>
---<br>
=A0arch/arm/mach-omap2/pm.c =A0 =A0 =A0 =A0 =A0| =A0 61 -------------------=
-<br>
=A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 =A0 =A0| =A0 =A01<br>
=A0arch/arm/mach-omap2/powerdomain.c | =A0112 +++++++++++++++++++++++++++--=
--------<br>
=A0arch/arm/mach-omap2/powerdomain.h | =A0 =A03 +<br>
=A04 files changed, 85 insertions(+), 92 deletions(-)<br>
<br>
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c<br>
index cc8ed0f..2e2a897 100644<br>
--- a/arch/arm/mach-omap2/pm.c<br>
+++ b/arch/arm/mach-omap2/pm.c<br>
@@ -76,10 +76,6 @@ static void __init omap2_init_processor_devices(void)<br=
>
=A0 =A0 =A0 =A0 }<br>
=A0}<br>
<br>
-/* Types of sleep_switch used in omap_set_pwrdm_state */<br>
-#define FORCEWAKEUP_SWITCH =A0 =A0 0<br>
-#define LOWPOWERSTATE_SWITCH =A0 1<br>
-<br>
=A0int __init omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused)=
<br>
=A0{<br>
=A0 =A0 =A0 =A0 if ((clkdm-&gt;flags &amp; CLKDM_CAN_ENABLE_AUTO) &amp;&amp=
;<br>
@@ -92,63 +88,6 @@ int __init omap_pm_clkdms_setup(struct clockdomain *clkd=
m, void *unused)<br>
=A0}<br>
<br>
=A0/*<br>
- * This sets pwrdm state (other than mpu &amp; core. Currently only ON &am=
p;<br>
- * RET are supported.<br>
- */<br>
-int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 pwrst)<br>
-{<br>
- =A0 =A0 =A0 u8 curr_pwrst, next_pwrst;<br>
- =A0 =A0 =A0 int sleep_switch =3D -1, ret =3D 0, hwsup =3D 0;<br>
-<br>
- =A0 =A0 =A0 if (!pwrdm || IS_ERR(pwrdm))<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
-<br>
- =A0 =A0 =A0 while (!(pwrdm-&gt;pwrsts &amp; (1 &lt;&lt; pwrst))) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pwrst =3D=3D PWRDM_POWER_OFF)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrst--;<br>
- =A0 =A0 =A0 }<br>
-<br>
- =A0 =A0 =A0 next_pwrst =3D pwrdm_read_next_pwrst(pwrdm);<br>
- =A0 =A0 =A0 if (next_pwrst =3D=3D pwrst)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
-<br>
- =A0 =A0 =A0 curr_pwrst =3D pwrdm_read_pwrst(pwrdm);<br>
- =A0 =A0 =A0 if (curr_pwrst &lt; PWRDM_POWER_ON) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((curr_pwrst &gt; pwrst) &amp;&amp;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pwrdm-&gt;flags &amp; PWRDM_=
HAS_LOWPOWERSTATECHANGE)) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sleep_switch =3D LOWPOWERSTAT=
E_SWITCH;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hwsup =3D clkdm_in_hwsup(pwrd=
m-&gt;pwrdm_clkdms[0]);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_wakeup(pwrdm-&gt;pwrdm_=
clkdms[0]);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sleep_switch =3D FORCEWAKEUP_=
SWITCH;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
- =A0 =A0 =A0 }<br>
-<br>
- =A0 =A0 =A0 ret =3D pwrdm_set_next_pwrst(pwrdm, pwrst);<br>
- =A0 =A0 =A0 if (ret)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(&quot;%s: unable to set power state of=
 powerdomain: %s\n&quot;,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, pwrdm-&gt;name);<br>
-<br>
- =A0 =A0 =A0 switch (sleep_switch) {<br>
- =A0 =A0 =A0 case FORCEWAKEUP_SWITCH:<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hwsup)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_allow_idle(pwrdm-&gt;pw=
rdm_clkdms[0]);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 else<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_sleep(pwrdm-&gt;pwrdm_c=
lkdms[0]);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
- =A0 =A0 =A0 case LOWPOWERSTATE_SWITCH:<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_set_lowpwrstchange(pwrdm);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_state_switch(pwrdm);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
- =A0 =A0 =A0 }<br>
-<br>
- =A0 =A0 =A0 return ret;<br>
-}<br>
-<br>
-<br>
-<br>
-/*<br>
=A0 * This API is to be called during init to set the various voltage<br>
=A0 * domains to the voltage as per the opp table. Typically we boot up<br>
=A0 * at the nominal voltage. So this function finds out the rate of<br>
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h<br>
index 686137d..707e9cb 100644<br>
--- a/arch/arm/mach-omap2/pm.h<br>
+++ b/arch/arm/mach-omap2/pm.h<br>
@@ -33,7 +33,6 @@ static inline int omap4_idle_init(void)<br>
=A0extern void *omap3_secure_ram_storage;<br>
=A0extern void omap3_pm_off_mode_enable(int);<br>
=A0extern void omap_sram_idle(void);<br>
-extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);<br>
=A0extern int omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused)=
;<br>
=A0extern int (*omap_pm_suspend)(void);<br>
<br>
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerd=
omain.c<br>
index 97b3881..05f00660 100644<br>
--- a/arch/arm/mach-omap2/powerdomain.c<br>
+++ b/arch/arm/mach-omap2/powerdomain.c<br>
@@ -921,35 +921,6 @@ bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm)<br>
=A0 =A0 =A0 =A0 return (pwrdm &amp;&amp; pwrdm-&gt;flags &amp; PWRDM_HAS_HD=
WR_SAR) ? 1 : 0;<br>
=A0}<br>
<br>
-/**<br>
- * pwrdm_set_lowpwrstchange - Request a low power state change<br>
- * @pwrdm: struct powerdomain *<br>
- *<br>
- * Allows a powerdomain to transtion to a lower power sleep state<br>
- * from an existing sleep state without waking up the powerdomain.<br>
- * Returns -EINVAL if the powerdomain pointer is null or if the<br>
- * powerdomain does not support LOWPOWERSTATECHANGE, or returns 0<br>
- * upon success.<br>
- */<br></blockquote><div><br>Can this kerneldoc be reused in the new code?=
<br><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
-int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)<br>
-{<br>
- =A0 =A0 =A0 int ret =3D -EINVAL;<br>
-<br>
- =A0 =A0 =A0 if (!pwrdm)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
-<br>
- =A0 =A0 =A0 if (!(pwrdm-&gt;flags &amp; PWRDM_HAS_LOWPOWERSTATECHANGE))<b=
r>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
-<br>
- =A0 =A0 =A0 pr_debug(&quot;powerdomain: %s: setting LOWPOWERSTATECHANGE b=
it\n&quot;,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrdm-&gt;name);<br>
-<br>
- =A0 =A0 =A0 if (arch_pwrdm &amp;&amp; arch_pwrdm-&gt;pwrdm_set_lowpwrstch=
ange)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D arch_pwrdm-&gt;pwrdm_set_lowpwrstchan=
ge(pwrdm);<br>
-<br>
- =A0 =A0 =A0 return ret;<br>
-}<br>
-<br>
=A0int pwrdm_state_switch(struct powerdomain *pwrdm)<br>
=A0{<br>
=A0 =A0 =A0 =A0 int ret;<br>
@@ -984,6 +955,89 @@ int pwrdm_post_transition(struct powerdomain *pwrdm)<b=
r>
=A0 =A0 =A0 =A0 return 0;<br>
=A0}<br>
<br>
+/* Types of sleep_switch used in omap_set_pwrdm_state */<br>
+#define ALREADYACTIVE_SWITCH =A0 0<br>
+#define FORCEWAKEUP_SWITCH =A0 =A0 1<br>
+#define LOWPOWERSTATE_SWITCH =A0 2=A0<br></blockquote><div><br>Could you a=
dd some more documentation here?<br>What is the goal of the function, what =
does it return etc. ?<br>=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+<br>
+static u8 _pwrdm_save_clkdm_state_and_activate(struct powerdomain *pwrdm,<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0u8 pwrst, bool *hwsup)=A0</blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
+{<br>
+ =A0 =A0 =A0 u8 curr_pwrst, sleep_switch;<br>
+<br>
+ =A0 =A0 =A0 curr_pwrst =3D pwrdm_read_pwrst(pwrdm);<br>
+ =A0 =A0 =A0 if (curr_pwrst &lt; PWRDM_POWER_ON) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (curr_pwrst &gt; pwrst &amp;&amp;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm-&gt;flags &amp; PWRDM_HAS_LOWPO=
WERSTATECHANGE &amp;&amp;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 arch_pwrdm-&gt;pwrdm_set_lowpwrstchan=
ge) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sleep_switch =3D LOWPOWERSTAT=
E_SWITCH;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *hwsup =3D clkdm_in_hwsup(pwr=
dm-&gt;pwrdm_clkdms[0]);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_wakeup(pwrdm-&gt;pwrdm_=
clkdms[0]);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sleep_switch =3D FORCEWAKEUP_=
SWITCH;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 } else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 sleep_switch =3D ALREADYACTIVE_SWITCH;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 return sleep_switch;<br>
+}<br>
+<br></blockquote><div><br>Same here<br>=A0<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
+static void _pwrdm_restore_clkdm_state(struct powerdomain *pwrdm,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0u8 sleep_switch, bool hwsup)<br>
+{<br>
+ =A0 =A0 =A0 switch (sleep_switch) {<br>
+ =A0 =A0 =A0 case FORCEWAKEUP_SWITCH:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hwsup)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_allow_idle(pwrdm-&gt;pw=
rdm_clkdms[0]);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 else<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_sleep(pwrdm-&gt;pwrdm_c=
lkdms[0]);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 case LOWPOWERSTATE_SWITCH:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pwrdm-&gt;flags &amp; PWRDM_HAS_LOWPOWERS=
TATECHANGE &amp;&amp;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 arch_pwrdm-&gt;pwrdm_set_lowpwrstchan=
ge)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 arch_pwrdm-&gt;pwrdm_set_lowp=
wrstchange(pwrdm);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_state_switch(pwrdm);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 }<br>
+}<br>
+<br>
+/*<br>
+ * This sets pwrdm state (other than mpu &amp; core. Currently only ON &am=
p;<br>
+ * RET are supported.<br>
+ */<br></blockquote><div>Same here.<br>Is this one correct?<br><br>Regards=
,<br>Jean<br>=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>

+int omap_set_pwrdm_state(struct powerdomain *pwrdm, u8 pwrst)<br>
+{<br>
+ =A0 =A0 =A0 u8 next_pwrst, sleep_switch;<br>
+ =A0 =A0 =A0 int ret =3D 0;<br>
+ =A0 =A0 =A0 bool hwsup =3D false;<br>
+<br>
+ =A0 =A0 =A0 if (!pwrdm || IS_ERR(pwrdm))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
+<br>
+ =A0 =A0 =A0 while (!(pwrdm-&gt;pwrsts &amp; (1 &lt;&lt; pwrst))) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pwrst =3D=3D PWRDM_POWER_OFF)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrst--;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 next_pwrst =3D pwrdm_read_next_pwrst(pwrdm);<br>
+ =A0 =A0 =A0 if (next_pwrst =3D=3D pwrst)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
+<br>
+ =A0 =A0 =A0 sleep_switch =3D _pwrdm_save_clkdm_state_and_activate(pwrdm, =
pwrst,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp;hwsup);<br>
+<br>
+ =A0 =A0 =A0 ret =3D pwrdm_set_next_pwrst(pwrdm, pwrst);<br>
+ =A0 =A0 =A0 if (ret)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(&quot;%s: unable to set power state of=
 powerdomain: %s\n&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, pwrdm-&gt;name);<br>
+<br>
+ =A0 =A0 =A0 _pwrdm_restore_clkdm_state(pwrdm, sleep_switch, hwsup);<br>
+<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+<br>
=A0/**<br>
=A0 * pwrdm_get_context_loss_count - get powerdomain&#39;s context loss cou=
nt<br>
=A0 * @pwrdm: struct powerdomain * to wait for<br>
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerd=
omain.h<br>
index 7c1534b..1edb3b7 100644<br>
--- a/arch/arm/mach-omap2/powerdomain.h<br>
+++ b/arch/arm/mach-omap2/powerdomain.h<br>
@@ -228,10 +228,11 @@ bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm);<b=
r>
=A0int pwrdm_state_switch(struct powerdomain *pwrdm);<br>
=A0int pwrdm_pre_transition(struct powerdomain *pwrdm);<br>
=A0int pwrdm_post_transition(struct powerdomain *pwrdm);<br>
-int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);<br>
=A0int pwrdm_get_context_loss_count(struct powerdomain *pwrdm);<br>
=A0bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);<br>
<br>
+extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u8 state);<br>
+<br>
=A0extern void omap242x_powerdomains_init(void);<br>
=A0extern void omap243x_powerdomains_init(void);<br>
=A0extern void omap3xxx_powerdomains_init(void);<br>
<br>
<br>
</blockquote></div><br></div>

--f46d0447a12dcdd18204d0a4761f--


--===============9037736686913438077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============9037736686913438077==--
