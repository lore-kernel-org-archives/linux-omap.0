From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 02/12] ARM: OMAP2+: PM: introduce power domains functional
 states
Date: Wed, 12 Dec 2012 11:00:19 +0100
Message-ID: <CAORVsuVX5AHocHSAg7aMbnLy9FaaPDS5doTCY4_G_-3r+AWEgw@mail.gmail.com>
References: <20121209174545.6933.59371.stgit@dusk.lan>
 <20121209175253.6933.87846.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6436230934623190739=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121209175253.6933.87846.stgit@dusk.lan>
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
Cc: Nishanth Menon <nm@ti.com>, Rajendra Nayak <rnayak@ti.com>, Tero Kristo <t-kristo@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Pihet <j-pihet@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============6436230934623190739==
Content-Type: multipart/alternative; boundary=14dae93404f5b5b82b04d0a4ddf6

--14dae93404f5b5b82b04d0a4ddf6
Content-Type: text/plain; charset=ISO-8859-1

Hi Paul,

On Sun, Dec 9, 2012 at 6:53 PM, Paul Walmsley <paul@pwsan.com> wrote:

> From: Jean Pihet <jean.pihet@newoldbits.com>
>
> Introduce the functional states for power domains, which include
> the power states and the logic states.
> This patch provides the API functions to set and read the power
> domains functional state and internal functions to convert between
> the functional (i.e. logical) and the internal (or registers) values.
>
> In the new API only the functions pwrdm_set_next_fpwrst() and
> pwrdm_set_fpwrst() shall be used to change a power domain target
> state, along with the associated PWRDM_FUNC_* macros as the state
> parameters.
>
> Note about the power domains allowed states:
> Power domains have varied capabilities, as defined by the value of
> the pwrsts and pwrsts_logic_ret fields of the powerdomain struct.
> When reading or setting a low power state such as OFF/RET, a specific
> requested state may not be supported on the given power domain.
> In the states conversion functions a power or logic state is first
> looked for in the lower power states in order to maximize the power
> savings, then if not found in the higher power states. An iteration
> function is used, as suggested by Rajendra Nayak <rnayak@ti.com>
> This function is temporary and will be removed later in the series.
>
> This functionality brings consistency in the functional power states
> core code and acts as a guard against hardware implementations
> discrepancies, e.g. some power domains only support the RET logic
> state although reading the logic state registers (previous, current
> and next) always returns OFF. The DSS power domain on OMAP3 is an
> example.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> [paul@pwsan.com: add offset for functional powerstates so it's not
>  possible to confuse them with the old API; use one fn to convert func
>  pwrsts to low-level hardware bits; skip hardware reads when hardware
>  logic retst and logic pwrst bits are missing; fix kerneldoc and
>  commit message; remove unnecessary PWRDM_LOGIC_MEM_PWRST_* macros;
>  combine spinlock patch into this patch; expand the number of operations
>  which take the spinlock]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/powerdomain.c |  525
> +++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/powerdomain.h |   33 ++
>  2 files changed, 553 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomain.c
> b/arch/arm/mach-omap2/powerdomain.c
> index 94b89a25..18f33de 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -1,7 +1,7 @@
>

...

+/**
> + * _match_pwrst: determine the closest supported power state
> + * @pwrsts: list of allowed states, defined as a bitmask
> + * @pwrst: initial state to be used as a starting point
> + * @min: minimum (i.e. lowest consumption) allowed state
> + * @max: maximum (i.e. highest consumption) allowed state
> + *
> + * Search down then up for a valid state from a list of allowed
> + * states.  Used by states conversion functions (_pwrdm_fpwrst_to_*)
> + * to look for allowed power and logic states for a powerdomain.
> + * Returns the matching allowed state.  XXX Deprecated.  The software
> + * should not try to program unsupported powerstates.
>

Why is this new code already deprecated? Does this require a rewrite?

+ */
> +static int _match_pwrst(u32 pwrsts, int pwrst, int min, int max)
> +{
> +       int found = 1, new_pwrst = pwrst;
> +
> +       /*
> +        * If the power domain does not allow any state programmation
> +        * return the max state which is always allowed
> +        */
> +       if (!pwrsts)
> +               return max;
> +
> +       /*
> +        * Search lower: if the requested state is not supported
> +        * try the lower states, stopping at the minimum allowed
> +        * state
> +        */
> +       while (!(pwrsts & (1 << new_pwrst))) {
> +               if (new_pwrst <= min) {
> +                       found = 0;
> +                       break;
> +               }
> +               new_pwrst--;
> +       }
> +
> +       /*
> +        * Search higher: if no lower state found fallback to the higher
> +        * states, stopping at the maximum allowed state
> +        */
> +       if (!found) {
> +               new_pwrst = pwrst;
> +               while (!(pwrsts & (1 << new_pwrst))) {
> +                       if (new_pwrst >= max) {
> +                               new_pwrst = max;
> +                               break;
> +                       }
> +                       new_pwrst++;
> +               }
> +       }
> +
> +       return new_pwrst;
> +}
> +
> +/**
> + * _pwrdm_fpwrst_to_pwrst - Convert functional (i.e. logical) to
> + * internal (i.e. registers) values for the power domains states.
> + * @pwrdm: struct powerdomain * to convert the values for
> + * @fpwrst: functional power state
> + * @pwrdm_pwrst: ptr to u8 to return the power state in
> + * @logic_retst: ptr to u8 to return the logic retention state in
> + *
> + * Returns the internal power state value for the power domain, or
> + * -EINVAL in case of invalid parameters passed in.
> + */
> +static int _pwrdm_fpwrst_to_pwrst(struct powerdomain *pwrdm, u8 fpwrst,
> +                                 u8 *pwrdm_pwrst, u8 *logic_retst)
> +{
> +       if (!pwrdm || !pwrdm_pwrst || !logic_retst)
> +               return -EINVAL;
> +
> +       switch (fpwrst) {
> +       case PWRDM_FUNC_PWRST_ON:
> +               *pwrdm_pwrst = PWRDM_POWER_ON;
> +               *logic_retst = PWRDM_POWER_RET;
> +               break;
> +       case PWRDM_FUNC_PWRST_INACTIVE:
> +               *pwrdm_pwrst = PWRDM_POWER_INACTIVE;
> +               *logic_retst = PWRDM_POWER_RET;
> +               break;
> +       case PWRDM_FUNC_PWRST_CSWR:
> +               *pwrdm_pwrst = PWRDM_POWER_RET;
> +               *logic_retst = PWRDM_POWER_RET;
> +               break;
> +       case PWRDM_FUNC_PWRST_OSWR:
> +               *pwrdm_pwrst = PWRDM_POWER_RET;
> +               *logic_retst = PWRDM_POWER_OFF;
> +               break;
> +       case PWRDM_FUNC_PWRST_OFF:
> +               *pwrdm_pwrst = PWRDM_POWER_OFF;
> +               /*
> +                * logic_retst is set to PWRDM_POWER_RET in this case
> +                * since the actual value does not matter, and because
> +                * some powerdomains don't support a logic_retst of
> +                * OFF.  XXX Maybe there's some way to indicate a
> +                * 'don't care' value here?
> +                */
> +               *logic_retst = PWRDM_POWER_RET;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       /* XXX deprecated */
>

Same here


> +       *pwrdm_pwrst = _match_pwrst(pwrdm->pwrsts, *pwrdm_pwrst,
> +                                   PWRDM_POWER_OFF, PWRDM_POWER_ON);
> +
> +       *logic_retst = _match_pwrst(pwrdm->pwrsts_logic_ret, *logic_retst,
> +                                   PWRDM_POWER_OFF, PWRDM_POWER_RET);
> +
> +       pr_debug("powerdomain %s: convert fpwrst %0x to pwrst %0x\n",
> +                pwrdm->name, fpwrst, *pwrdm_pwrst);
> +
> +       return 0;
> +}
>


Thanks & regards,
Jean

--14dae93404f5b5b82b04d0a4ddf6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Paul,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Su=
n, Dec 9, 2012 at 6:53 PM, Paul Walmsley <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:paul@pwsan.com" target=3D"_blank">paul@pwsan.com</a>&gt;</span> wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">
From: Jean Pihet &lt;<a href=3D"mailto:jean.pihet@newoldbits.com">jean.pihe=
t@newoldbits.com</a>&gt;<br>
<br>
Introduce the functional states for power domains, which include<br>
the power states and the logic states.<br>
This patch provides the API functions to set and read the power<br>
domains functional state and internal functions to convert between<br>
the functional (i.e. logical) and the internal (or registers) values.<br>
<br>
In the new API only the functions pwrdm_set_next_fpwrst() and<br>
pwrdm_set_fpwrst() shall be used to change a power domain target<br>
state, along with the associated PWRDM_FUNC_* macros as the state<br>
parameters.<br>
<br>
Note about the power domains allowed states:<br>
Power domains have varied capabilities, as defined by the value of<br>
the pwrsts and pwrsts_logic_ret fields of the powerdomain struct.<br>
When reading or setting a low power state such as OFF/RET, a specific<br>
requested state may not be supported on the given power domain.<br>
In the states conversion functions a power or logic state is first<br>
looked for in the lower power states in order to maximize the power<br>
savings, then if not found in the higher power states. An iteration<br>
function is used, as suggested by Rajendra Nayak &lt;<a href=3D"mailto:rnay=
ak@ti.com">rnayak@ti.com</a>&gt;<br>
This function is temporary and will be removed later in the series.<br>
<br>
This functionality brings consistency in the functional power states<br>
core code and acts as a guard against hardware implementations<br>
discrepancies, e.g. some power domains only support the RET logic<br>
state although reading the logic state registers (previous, current<br>
and next) always returns OFF. The DSS power domain on OMAP3 is an<br>
example.<br>
<br>
Signed-off-by: Jean Pihet &lt;<a href=3D"mailto:j-pihet@ti.com">j-pihet@ti.=
com</a>&gt;<br>
Cc: Tero Kristo &lt;<a href=3D"mailto:t-kristo@ti.com">t-kristo@ti.com</a>&=
gt;<br>
Cc: Rajendra Nayak &lt;<a href=3D"mailto:rnayak@ti.com">rnayak@ti.com</a>&g=
t;<br>
Cc: Nishanth Menon &lt;<a href=3D"mailto:nm@ti.com">nm@ti.com</a>&gt;<br>
[<a href=3D"mailto:paul@pwsan.com">paul@pwsan.com</a>: add offset for funct=
ional powerstates so it&#39;s not<br>
=A0possible to confuse them with the old API; use one fn to convert func<br=
>
=A0pwrsts to low-level hardware bits; skip hardware reads when hardware<br>
=A0logic retst and logic pwrst bits are missing; fix kerneldoc and<br>
=A0commit message; remove unnecessary PWRDM_LOGIC_MEM_PWRST_* macros;<br>
=A0combine spinlock patch into this patch; expand the number of operations<=
br>
=A0which take the spinlock]<br>
Signed-off-by: Paul Walmsley &lt;<a href=3D"mailto:paul@pwsan.com">paul@pws=
an.com</a>&gt;<br>
---<br>
=A0arch/arm/mach-omap2/powerdomain.c | =A0525 +++++++++++++++++++++++++++++=
++++++++<br>
=A0arch/arm/mach-omap2/powerdomain.h | =A0 33 ++<br>
=A02 files changed, 553 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerd=
omain.c<br>
index 94b89a25..18f33de 100644<br>
--- a/arch/arm/mach-omap2/powerdomain.c<br>
+++ b/arch/arm/mach-omap2/powerdomain.c<br>
@@ -1,7 +1,7 @@<br>
</blockquote><div>=A0<br>...<br><br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">+/=
**<br>
+ * _match_pwrst: determine the closest supported power state<br>
+ * @pwrsts: list of allowed states, defined as a bitmask<br>
+ * @pwrst: initial state to be used as a starting point<br>
+ * @min: minimum (i.e. lowest consumption) allowed state<br>
+ * @max: maximum (i.e. highest consumption) allowed state<br>
+ *<br>
+ * Search down then up for a valid state from a list of allowed<br>
+ * states. =A0Used by states conversion functions (_pwrdm_fpwrst_to_*)<br>
+ * to look for allowed power and logic states for a powerdomain.<br>
+ * Returns the matching allowed state. =A0XXX Deprecated. =A0The software<=
br>
+ * should not try to program unsupported powerstates.<br></blockquote><div=
><br>Why is this new code already deprecated? Does this require a rewrite?<=
br><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">

+ */<br>
+static int _match_pwrst(u32 pwrsts, int pwrst, int min, int max)<br>
+{<br>
+ =A0 =A0 =A0 int found =3D 1, new_pwrst =3D pwrst;<br>
+<br>
+ =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0* If the power domain does not allow any state programmati=
on<br>
+ =A0 =A0 =A0 =A0* return the max state which is always allowed<br>
+ =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 if (!pwrsts)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return max;<br>
+<br>
+ =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0* Search lower: if the requested state is not supported<br=
>
+ =A0 =A0 =A0 =A0* try the lower states, stopping at the minimum allowed<br=
>
+ =A0 =A0 =A0 =A0* state<br>
+ =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 while (!(pwrsts &amp; (1 &lt;&lt; new_pwrst))) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (new_pwrst &lt;=3D min) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 found =3D 0;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_pwrst--;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0* Search higher: if no lower state found fallback to the h=
igher<br>
+ =A0 =A0 =A0 =A0* states, stopping at the maximum allowed state<br>
+ =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 if (!found) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_pwrst =3D pwrst;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!(pwrsts &amp; (1 &lt;&lt; new_pwrst))=
) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (new_pwrst &gt;=3D max) {<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_pwrst =3D=
 max;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_pwrst++;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 return new_pwrst;<br>
+}<br>
+<br>
+/**<br>
+ * _pwrdm_fpwrst_to_pwrst - Convert functional (i.e. logical) to<br>
+ * internal (i.e. registers) values for the power domains states.<br>
+ * @pwrdm: struct powerdomain * to convert the values for<br>
+ * @fpwrst: functional power state<br>
+ * @pwrdm_pwrst: ptr to u8 to return the power state in<br>
+ * @logic_retst: ptr to u8 to return the logic retention state in<br>
+ *<br>
+ * Returns the internal power state value for the power domain, or<br>
+ * -EINVAL in case of invalid parameters passed in.<br>
+ */<br>
+static int _pwrdm_fpwrst_to_pwrst(struct powerdomain *pwrdm, u8 fpwrst,<br=
>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 *pwrdm=
_pwrst, u8 *logic_retst)<br>
+{<br>
+ =A0 =A0 =A0 if (!pwrdm || !pwrdm_pwrst || !logic_retst)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
+<br>
+ =A0 =A0 =A0 switch (fpwrst) {<br>
+ =A0 =A0 =A0 case PWRDM_FUNC_PWRST_ON:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 *pwrdm_pwrst =3D PWRDM_POWER_ON;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 *logic_retst =3D PWRDM_POWER_RET;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 case PWRDM_FUNC_PWRST_INACTIVE:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 *pwrdm_pwrst =3D PWRDM_POWER_INACTIVE;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 *logic_retst =3D PWRDM_POWER_RET;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 case PWRDM_FUNC_PWRST_CSWR:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 *pwrdm_pwrst =3D PWRDM_POWER_RET;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 *logic_retst =3D PWRDM_POWER_RET;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 case PWRDM_FUNC_PWRST_OSWR:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 *pwrdm_pwrst =3D PWRDM_POWER_RET;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 *logic_retst =3D PWRDM_POWER_OFF;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 case PWRDM_FUNC_PWRST_OFF:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 *pwrdm_pwrst =3D PWRDM_POWER_OFF;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* logic_retst is set to PWRDM_POWER_RET in=
 this case<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* since the actual value does not matter, =
and because<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* some powerdomains don&#39;t support a lo=
gic_retst of<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* OFF. =A0XXX Maybe there&#39;s some way t=
o indicate a<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* &#39;don&#39;t care&#39; value here?<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 *logic_retst =3D PWRDM_POWER_RET;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 default:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 /* XXX deprecated */<br></blockquote><div><br>Same here<br>=
=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
+ =A0 =A0 =A0 *pwrdm_pwrst =3D _match_pwrst(pwrdm-&gt;pwrsts, *pwrdm_pwrst,=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PWRDM=
_POWER_OFF, PWRDM_POWER_ON);<br>
+<br>
+ =A0 =A0 =A0 *logic_retst =3D _match_pwrst(pwrdm-&gt;pwrsts_logic_ret, *lo=
gic_retst,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PWRDM=
_POWER_OFF, PWRDM_POWER_RET);<br>
+<br>
+ =A0 =A0 =A0 pr_debug(&quot;powerdomain %s: convert fpwrst %0x to pwrst %0=
x\n&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrdm-&gt;name, fpwrst, *pwrdm_pwrst);<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br></blockquote><div><br>=A0</div><div>Thanks &amp; regards,<br>Jean<br>=
<br></div></div></div>

--14dae93404f5b5b82b04d0a4ddf6--


--===============6436230934623190739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6436230934623190739==--
