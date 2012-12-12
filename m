From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 02/12] ARM: OMAP2+: PM: introduce power domains functional states
Date: Wed, 12 Dec 2012 11:33:19 +0100
Message-ID: <CAORVsuXnbNLm3i=W2yb682qC1QH673nM3nPpNM_9OMds8SdzQA@mail.gmail.com>
References: <20121209174545.6933.59371.stgit@dusk.lan>
	<20121209175253.6933.87846.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:47174 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528Ab2LLKdU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Dec 2012 05:33:20 -0500
Received: by mail-ie0-f170.google.com with SMTP id k10so1858967iea.1
        for <linux-omap@vger.kernel.org>; Wed, 12 Dec 2012 02:33:19 -0800 (PST)
In-Reply-To: <20121209175253.6933.87846.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Rajendra Nayak <rnayak@ti.com>, Jean Pihet <j-pihet@ti.com>

Hi Paul,

-resending in plain text only, sorry about that-

On Sun, Dec 9, 2012 at 6:53 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
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
>  arch/arm/mach-omap2/powerdomain.c |  525 +++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/powerdomain.h |   33 ++
>  2 files changed, 553 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 94b89a25..18f33de 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -1,7 +1,7 @@


...

> +/**
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


Why is this new code already deprecated? Does this require a rewrite?

> + */
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


Same here

>
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



Thanks & regards,
Jean
