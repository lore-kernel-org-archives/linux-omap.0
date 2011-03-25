From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH/RFC 13/19] OMAP2+: voltage: keep track of powerdomains in
 each voltagedomain
Date: Fri, 25 Mar 2011 10:22:12 +0100
Message-ID: <AANLkTi=JD=QJKBWekHDW08JOxrvntmTfMfTK9Eq_xH9Y@mail.gmail.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
	<1300924833-26745-14-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:54392 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755637Ab1CYJWN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 05:22:13 -0400
Received: by qwk3 with SMTP id 3so491306qwk.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 02:22:12 -0700 (PDT)
In-Reply-To: <1300924833-26745-14-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

On Thu, Mar 24, 2011 at 1:00 AM, Kevin Hilman <khilman@ti.com> wrote:
> When a powerdomain is registered and it has an associated voltage dom=
ain,
> add the powerdomain to the voltagedomain using voltdm_add_pwrdm().
>
> Also add voltagedomain iterator helper functions to iterate over all
> registered voltagedomains and all powerdomains associated with a
> voltagedomain.
>
> Modeled after a similar relationship between clockdomains and powerdo=
mains.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/mach-omap2/powerdomain.c | =A0 =A02 +
> =A0arch/arm/mach-omap2/powerdomain.h | =A0 =A02 +
> =A0arch/arm/mach-omap2/voltage.c =A0 =A0 | =A0 80 +++++++++++++++++++=
++++++++++++++++++
> =A0arch/arm/mach-omap2/voltage.h =A0 =A0 | =A0 15 +++++++
> =A04 files changed, 99 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/=
powerdomain.c
> index 8fccd4b..224272e 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -102,6 +102,8 @@ static int _pwrdm_register(struct powerdomain *pw=
rdm)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0pwrdm->voltdm.ptr =3D voltdm;
> + =A0 =A0 =A0 INIT_LIST_HEAD(&pwrdm->voltdm_node);
> + =A0 =A0 =A0 voltdm_add_pwrdm(voltdm, pwrdm);
>
> =A0 =A0 =A0 =A0list_add(&pwrdm->node, &pwrdm_list);
>
> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/=
powerdomain.h
> index 3a1ec37..6a4f71a 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -92,6 +92,7 @@ struct powerdomain;
> =A0* @pwrsts_mem_on: Possible memory bank pwrstates when pwrdm in ON
> =A0* @pwrdm_clkdms: Clockdomains in this powerdomain
> =A0* @node: list_head linking all powerdomains
> + * @voltdm_node: list_head linking all powerdomains in a voltagedoma=
in
> =A0* @state:
> =A0* @state_counter:
> =A0* @timer:
> @@ -116,6 +117,7 @@ struct powerdomain {
> =A0 =A0 =A0 =A0const u8 prcm_partition;
> =A0 =A0 =A0 =A0struct clockdomain *pwrdm_clkdms[PWRDM_MAX_CLKDMS];
> =A0 =A0 =A0 =A0struct list_head node;
> + =A0 =A0 =A0 struct list_head voltdm_node;
> =A0 =A0 =A0 =A0int state;
> =A0 =A0 =A0 =A0unsigned state_counter[PWRDM_MAX_PWRSTS];
> =A0 =A0 =A0 =A0unsigned ret_logic_off_counter;
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/volt=
age.c
> index bc944ff..b1b5e38 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -36,6 +36,7 @@
> =A0#include "control.h"
>
> =A0#include "voltage.h"
> +#include "powerdomain.h"
>
> =A0#include "vc.h"
> =A0#include "vp.h"
> @@ -1085,11 +1086,90 @@ static struct voltagedomain *_voltdm_lookup(c=
onst char *name)
> =A0 =A0 =A0 =A0return voltdm;
> =A0}
>
> +/**
> + * voltdm_add_pwrdm - add a powerdomain to a voltagedomain
> + * @voltdm: struct voltagedomain * to add the powerdomain to
> + * @pwrdm: struct powerdomain * to associate with a voltagedomain
> + *
> + * Associate the powerdomain @pwrdm with a voltagedomain @voltdm. =A0=
This
> + * enables the use of voltdm_for_each_pwrdm(). =A0Returns -EINVAL if
> + * presented with invalid pointers; -ENOMEM if memory could not be a=
llocated;
> + * or 0 upon success.
> + */
> +int voltdm_add_pwrdm(struct voltagedomain *voltdm, struct powerdomai=
n *pwrdm)
> +{
> + =A0 =A0 =A0 if (!voltdm || !pwrdm)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 pr_debug("voltagedomain: associating powerdomain %s wit=
h voltagedomain "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%s\n", pwrdm->name, voltdm->name);
> +
> + =A0 =A0 =A0 list_add(&pwrdm->voltdm_node, &voltdm->pwrdm_list);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> + * voltdm_for_each_pwrdm - call function for each pwrdm in a voltdm
> + * @voltdm: struct voltagedomain * to iterate over
> + * @fn: callback function *
> + *
> + * Call the supplied function @fn for each powerdomain in the
> + * voltagedomain @voltdm. =A0Returns -EINVAL if presented with inval=
id
> + * pointers; or passes along the last return value of the callback
> + * function, which should be 0 for success or anything else to
> + * indicate failure.
> + */
> +int voltdm_for_each_pwrdm(struct voltagedomain *voltdm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int (*fn)(struct vo=
ltagedomain *voltdm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct powerdomain *pwrdm))
> +{
> + =A0 =A0 =A0 struct powerdomain *pwrdm;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (!fn)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 list_for_each_entry(pwrdm, &voltdm->pwrdm_list, voltdm_=
node)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D (*fn)(voltdm, pwrdm);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +/**
> + * voltdm_for_each - call function on each registered voltagedomain
> + * @fn: callback function *
> + *
> + * Call the supplied function @fn for each registered voltagedomain.
> + * The callback function @fn can return anything but 0 to bail out
> + * early from the iterator. =A0Returns the last return value of the
> + * callback function, which should be 0 for success or anything else
> + * to indicate failure; or -EINVAL if the function pointer is null.
The function description does not match the prototype.

> + */
> +int voltdm_for_each(int (*fn)(struct voltagedomain *voltdm, void *us=
er),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *user)
> +{
> + =A0 =A0 =A0 struct voltagedomain *temp_voltdm;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (!fn)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 list_for_each_entry(temp_voltdm, &voltdm_list, node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D (*fn)(temp_voltdm, user);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> =A0static int _voltdm_register(struct voltagedomain *voltdm)
> =A0{
> =A0 =A0 =A0 =A0if (!voltdm || !voltdm->name)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> + =A0 =A0 =A0 INIT_LIST_HEAD(&voltdm->pwrdm_list);
> =A0 =A0 =A0 =A0list_add(&voltdm->node, &voltdm_list);
>
> =A0 =A0 =A0 =A0pr_debug("voltagedomain: registered %s\n", voltdm->nam=
e);
> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/volt=
age.h
> index 966aa88..df8d234 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -19,6 +19,13 @@
> =A0#include "vc.h"
> =A0#include "vp.h"
>
> +struct powerdomain;
> +
> +/*
> + * Maximum number of powerdomains that can be associated with a volt=
agedomain.
> + */
> +#define VOLTDM_MAX_PWRDMS =A0 =A0 =A0 =A0 =A0 =A0 10
This is not used in the patch. Is it needed?

> +
> =A0/* XXX document */
> =A0#define VOLTSCALE_VPFORCEUPDATE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01
> =A0#define VOLTSCALE_VCBYPASS =A0 =A0 =A0 =A0 =A0 =A0 2
> @@ -55,12 +62,15 @@ struct omap_vfsm_instance_data {
> =A0* @name: Name of the voltage domain which can be used as a unique =
identifier.
> =A0* @scalable: Whether or not this voltage domain is scalable
> =A0* @node: list_head linking all voltage domains
> + * @pwrdm_node: list_head linking all powerdomains in this voltagedo=
main
> =A0* @vdd: to be removed
> + * @pwrdms: powerdomains in this voltagedomain
> =A0*/
> =A0struct voltagedomain {
> =A0 =A0 =A0 =A0char *name;
> =A0 =A0 =A0 =A0bool scalable;
> =A0 =A0 =A0 =A0struct list_head node;
> + =A0 =A0 =A0 struct list_head pwrdm_list;
> =A0 =A0 =A0 =A0struct omap_vdd_info *vdd;
> =A0};
>
> @@ -187,4 +197,9 @@ extern void omap44xx_voltagedomains_init(void);
> =A0struct voltagedomain *voltdm_lookup(const char *name);
> =A0void voltdm_init(struct voltagedomain **voltdm_list);
> =A0int voltdm_add_pwrdm(struct voltagedomain *voltdm, struct powerdom=
ain *pwrdm);
> +int voltdm_for_each(int (*fn)(struct voltagedomain *voltdm, void *us=
er),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *user);
> +int voltdm_for_each_pwrdm(struct voltagedomain *voltdm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int (*fn)(struct vo=
ltagedomain *voltdm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct powerdomain *pwrdm));
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
