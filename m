From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH/RFC 12/19] OMAP2+: powerdomain: add voltage domain lookup
 during register
Date: Fri, 25 Mar 2011 10:18:06 +0100
Message-ID: <AANLkTin4=SzfUawC5dk3dmNNPoFK93vT4D6+rP1+1X=T@mail.gmail.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
	<1300924833-26745-13-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:36045 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753564Ab1CYJSH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 05:18:07 -0400
Received: by qyk7 with SMTP id 7so5890457qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 02:18:06 -0700 (PDT)
In-Reply-To: <1300924833-26745-13-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

On Thu, Mar 24, 2011 at 1:00 AM, Kevin Hilman <khilman@ti.com> wrote:
> When a powerdomain is registered, lookup the voltage domain by name
> and keep a pointer to the containing voltagedomain in the powerdomain
> structure.
>
> Modeled after similar method between powerdomain and clockdomain laye=
rs.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/mach-omap2/powerdomain.c | =A0 21 +++++++++++++++++++++
> =A0arch/arm/mach-omap2/powerdomain.h | =A0 =A01 +
> =A0arch/arm/mach-omap2/voltage.h =A0 =A0 | =A0 =A01 +
> =A03 files changed, 23 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/=
powerdomain.c
> index 49c6513..8fccd4b 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -77,6 +77,7 @@ static struct powerdomain *_pwrdm_lookup(const char=
 *name)
> =A0static int _pwrdm_register(struct powerdomain *pwrdm)
> =A0{
> =A0 =A0 =A0 =A0int i;
> + =A0 =A0 =A0 struct voltagedomain *voltdm;
>
> =A0 =A0 =A0 =A0if (!pwrdm || !pwrdm->name)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> @@ -94,6 +95,14 @@ static int _pwrdm_register(struct powerdomain *pwr=
dm)
> =A0 =A0 =A0 =A0if (_pwrdm_lookup(pwrdm->name))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EEXIST;
>
> + =A0 =A0 =A0 voltdm =3D voltdm_lookup(pwrdm->voltdm.name);
> + =A0 =A0 =A0 if (!voltdm) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("powerdomain: %s: voltagedomain =
%s does not exist\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrdm->name, pwrdm->volt=
dm.name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
Per patch 10/19 some power domains do not have an associated voltage
domain struct filled in. This will result in failure of the power
domain registration. I think this is not expected.

> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 pwrdm->voltdm.ptr =3D voltdm;
> +
> =A0 =A0 =A0 =A0list_add(&pwrdm->node, &pwrdm_list);
>
> =A0 =A0 =A0 =A0/* Initialize the powerdomain's state counter */
> @@ -383,6 +392,18 @@ int pwrdm_for_each_clkdm(struct powerdomain *pwr=
dm,
> =A0}
>
> =A0/**
> + * pwrdm_get_voltdm - return a ptr to the voltdm that this pwrdm res=
ides in
> + * @pwrdm: struct powerdomain *
> + *
> + * Return a pointer to the struct voltageomain that the specified po=
werdomain
> + * @pwrdm exists in.
> + */
> +struct voltagedomain *pwrdm_get_voltdm(struct powerdomain *pwrdm)
> +{
> + =A0 =A0 =A0 return pwrdm->voltdm.ptr;
> +}
> +
> +/**
> =A0* pwrdm_get_mem_bank_count - get number of memory banks in this po=
werdomain
> =A0* @pwrdm: struct powerdomain *
> =A0*
> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/=
powerdomain.h
> index cc03a0d..3a1ec37 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -183,6 +183,7 @@ int pwrdm_del_clkdm(struct powerdomain *pwrdm, st=
ruct clockdomain *clkdm);
> =A0int pwrdm_for_each_clkdm(struct powerdomain *pwrdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int (*fn)(struct powe=
rdomain *pwrdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s=
truct clockdomain *clkdm));
> +struct voltagedomain *pwrdm_get_voltdm(struct powerdomain *pwrdm);
>
> =A0int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm);
>
> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/volt=
age.h
> index cacd76e..966aa88 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -186,4 +186,5 @@ extern void omap44xx_voltagedomains_init(void);
>
> =A0struct voltagedomain *voltdm_lookup(const char *name);
> =A0void voltdm_init(struct voltagedomain **voltdm_list);
> +int voltdm_add_pwrdm(struct voltagedomain *voltdm, struct powerdomai=
n *pwrdm);
> =A0#endif
> --
> 1.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
