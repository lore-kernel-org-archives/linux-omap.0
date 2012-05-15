From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: PATCH: add small infrastructure and definitions to export debugfs
 files for OMAP powerdomain attributes
Date: Tue, 15 May 2012 14:56:00 +0300
Message-ID: <CAP245DV2u5DM+dk-kYNK5jtP8f1AHCHce0MBBOwFUFDKc6sX8A@mail.gmail.com>
References: <CAHjCt2-LrQOKwX2XpepGgLewS5mnFzZxJAKnr+smOgtmRLmsnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64642 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757851Ab2EOL4B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 May 2012 07:56:01 -0400
Received: by pbbrp8 with SMTP id rp8so7434340pbb.19
        for <linux-omap@vger.kernel.org>; Tue, 15 May 2012 04:56:01 -0700 (PDT)
In-Reply-To: <CAHjCt2-LrQOKwX2XpepGgLewS5mnFzZxJAKnr+smOgtmRLmsnw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: eric van tassell <evttxl@gmail.com>, Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-omap@vger.kernel.org

Eric,

This looks interesting, but I'll add the linux-omap list to CC so
someone can verify if there isn't already a patch to export this.

On Tue, May 15, 2012 at 2:57 AM, eric van tassell <evttxl@gmail.com> wr=
ote:
> - These changes make OMAP power state register fields available as
> attributes per field in debugfs decoded as text with the hex value
> - pwrdm_read_reg_field() might replace a lot of the explicit function=
s
> for reading register fields and clean up the existing OMAP code a bit=
=2E
> - the changes are usable via debugfs standalone or with the patch
> coming for powerdebug
> - I've only implemented the support for the MPU PD
> - to support additional the other powerdomains all that's needed is t=
o
> add the register_def_t's and field_def_t's

Have you looked at other ARM platforms to see if they have similar
information that could be exported using in the same way? It would be
useful to export this information through a single interface to
powerdebug like in the case of regulators and clocks.

> =A0here's a screenshot:
> ./powerdebug -P -d
> failed to initialize sensors
>
> Power Domain Information:
> *******************
>
> mpu_pwrdm
> =A0 =A0 =A0 =A0context
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lostcontext_dff 0:false
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lostmem_l1 =A0 =A0 =A00:false
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lostmem_l2 =A0 =A0 =A00:false
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lostmem_ram =A0 =A0 0:false
> =A0 =A0 =A0 =A0rstst
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0emulation_rst =A0 0:false
> =A0 =A0 =A0 =A0pwrstctl
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0powerstate =A0 =A0 =A03:on-active
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0logicretstate =A0 1:whole
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lowpowerstatechange =A0 =A0 0:false
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l1_retstate =A0 =A0 1:retention
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l2_retstate =A0 =A0 1:retention
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ram_retstate =A0 =A01:retention
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l1_onstate =A0 =A0 =A03:on-active
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l2_onstate =A0 =A0 =A03:on-active
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ram_onstate =A0 =A0 3:on-active
> =A0 =A0 =A0 =A0pwrst
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0powerstatest =A0 =A03:on-active
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0logicstatest =A0 =A01:on
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l1_statest =A0 =A0 =A03:on-active
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l2_statest =A0 =A0 =A03:on-active
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ram_statest =A0 =A0 3:on-active
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0intransition =A0 =A00:false
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lastpowerstateentered =A0 3:on-active
>
> and the patch against Linaro 12.04 kernel is:
>
>
> From 4b762379805848eebd3454d6bb344a50012069d4 Mon Sep 17 00:00:00 200=
1
> From: Eric van Tassell <evt@evtM17x.(none)>
> Date: Sat, 5 May 2012 15:05:48 -0500
> Subject: [PATCH] + basic infrastructure for creating powerdomain attr=
ibute
> =A0files in debugfs + definitions to create the attributes for
> =A0mpu power domain
>
> ---
> =A0arch/arm/mach-omap2/pm-debug.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
4 ++
> =A0arch/arm/mach-omap2/pm44xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A03 +-
> =A0arch/arm/mach-omap2/powerdomain.c =A0 =A0 =A0 =A0 =A0 | =A0 89 +++=
++++++++++++++++++++++++
> =A0arch/arm/mach-omap2/powerdomain.h =A0 =A0 =A0 =A0 =A0 | =A0 46 +++=
++++++++++-
> =A0arch/arm/mach-omap2/powerdomain44xx.c =A0 =A0 =A0 | =A0 23 +++++++
> =A0arch/arm/mach-omap2/powerdomains44xx_data.c | =A0 85 +++++++++++++=
++++++++++++
> =A0arch/arm/mach-omap2/prm44xx.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
1 +
> =A08 files changed, 254 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-=
debug.c
> index 4411163..2e365e3 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -224,6 +224,10 @@ static int __init pwrdms_setup(struct powerdomai=
n
> *pwrdm, void *dir)
> =A0 =A0 =A0 =A0(void) debugfs_create_file("suspend", S_IRUGO|S_IWUSR,=
 d,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(void *)pwrdm, &pwrdm_=
suspend_fops);
>
> +#ifdef CONFIG_PM_DEBUG
> + =A0 =A0 =A0 if (d)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_create_register_dirs(pwrdm, d);
> +#endif // CONFIG_PM_DEBUG
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44x=
x.c
> index 4ab9b9d..f5c189e 100644
> --- a/arch/arm/mach-omap2/pm44xx.c
> +++ b/arch/arm/mach-omap2/pm44xx.c
> @@ -155,7 +155,7 @@ static int __init clkdms_setup(struct clockdomain
> *clkdm, void *unused)
> =A0}
>
>
> -static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unus=
ed)
> +static int __init pwrdms_setup(struct powerdomain *pwrdm, void *arg)
> =A0{
> =A0 =A0 =A0 =A0struct power_state *pwrst;
>
> @@ -365,6 +365,7 @@ static int __init omap4_pm_init(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP44XX_IRQ_PRCM);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err2;
> =A0 =A0 =A0 =A0}
> +
> =A0 =A0 =A0 =A0ret =3D pwrdm_for_each(pwrdms_setup, NULL);
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("Failed to setup powerdomains\n=
");
> diff --git a/arch/arm/mach-omap2/powerdomain.c
> b/arch/arm/mach-omap2/powerdomain.c
> index 8a18d1b..b392760 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -37,6 +37,11 @@
>
> =A0#define PWRDM_TRACE_STATES_FLAG =A0 =A0 =A0 =A0(1<<31)
>
> +#ifdef CONFIG_PM_DEBUG
> +#include "prm-regbits-44xx.h"
> +#include <linux/debugfs.h>
> +#endif // CONFIG_PM_DEBUG
> +
> =A0enum {
> =A0 =A0 =A0 =A0PWRDM_STATE_NOW =3D 0,
> =A0 =A0 =A0 =A0PWRDM_STATE_PREV,
> @@ -201,6 +206,90 @@ static int _pwrdm_post_transition_cb(struct
> powerdomain *pwrdm, void *unused)
>
> =A0/* Public functions */
>
> +#ifdef CONFIG_PM_DEBUG
> +////////////////////////////////////////////////////////////////////=
/////////
> +int pwrdm_read_reg_field(field_def_t *f)
> +{
> + =A0 =A0 =A0 int ret =3D -EINVAL;
> +
> +
> + =A0 =A0 =A0 if (!f )
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (!(f->reg))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (!f->reg->pwrdm)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (arch_pwrdm && arch_pwrdm->pwrdm_read_reg_field)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D arch_pwrdm->pwrdm_read_reg_fiel=
d(f);
> + =A0 =A0 =A0 return ret;
> +}
> +
> +#define BUFMAX 4096
> +static char scratch[BUFMAX];
> +
> +
> +static ssize_t pwrdm_dbg_read(struct file *file, char __user *buf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size_t coun=
t, loff_t *ppos)
> +{
> + =A0 =A0 =A0 field_def_t *f =3D (field_def_t *)file->private_data;
> + =A0 =A0 =A0 int n;
> + =A0 =A0 =A0 int val;
> +
> + =A0 =A0 =A0 val =3D pwrdm_read_reg_field(f);
> + =A0 =A0 =A0 memset(scratch, 0, BUFMAX);
> + =A0 =A0 =A0 n =3D sprintf(scratch, "%d:%s", val, f->decoder(val));
> + =A0 =A0 =A0 return simple_read_from_buffer(buf, count, ppos, scratc=
h, n + 1);
> +}
> +
> +static int pwrdm_dbg_open(struct inode *inode, struct file *file)
> +{
> + =A0 =A0 =A0 file->private_data =3D inode->i_private;
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static const struct file_operations pwrdm_dbg_ops =3D {
> + =A0 =A0 =A0 .read =3D pwrdm_dbg_read,
> + =A0 =A0 =A0 .open =3D pwrdm_dbg_open,
> +};
> +////////////////////////////////////////////////////////////////////=
/////////debug
> +
> +static void pwrdm_create_1register_dir(register_def_t *r, struct
> dentry *pd_dentry)
> +{
> + =A0 =A0 =A0 struct dentry *reg_dentry;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 reg_dentry =3D debugfs_create_dir(r->name, pd_dentry);
> + =A0 =A0 =A0 for (i =3D 0; i < r->num_fields; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 field_def_t *f =3D &(r->fields[i]);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 f->reg =3D r; // link field to register
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 debugfs_create_file(f->name,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 S_IRUGO,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 reg_dentry,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (void *)&(r->fields[i]),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 &pwrdm_dbg_ops);
> + =A0 =A0 =A0 }
> +}
> +
> +void pwrdm_create_register_dirs(struct powerdomain *p, struct dentry
> *pd_dentry)
> +{
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 if ((p =3D=3D (struct powerdomain *)NULL) || (pd_dentry=
 =3D=3D (struct dentry *)NULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < p->num_reg_defs; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 p->register_defs[i]->pwrdm =3D p;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_create_1register_dir(p->register_=
defs[i], pd_dentry);
> + =A0 =A0 =A0 }
> +}
> +
> +#endif // CONFIG_PM_DEBUG
> +
> =A0/**
> =A0* pwrdm_register_platform_funcs - register powerdomain implementat=
ion fns
> =A0* @po: func pointers for arch specific implementations
> diff --git a/arch/arm/mach-omap2/powerdomain.h
> b/arch/arm/mach-omap2/powerdomain.h
> index 0d72a8a..5eaf08c 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -76,6 +76,47 @@
>
> =A0struct clockdomain;
> =A0struct powerdomain;
> +#ifdef CONFIG_PM_DEBUG
> +/* general PD decoder definitions */
> +
> +/* field definitions for PD_MPU */
> +
> +typedef struct {
> + =A0 =A0char *name;
> + =A0 =A0u32 shift;
> + =A0 =A0u32 mask;
> + =A0 =A0char * (*decoder)(u8); // note: decoder may be NULL
> + =A0 =A0struct _register_def_t_ *reg;
> +} field_def_t;
> +
> +typedef struct _register_def_t_ {
> + =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ix;
> + =A0 =A0char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*name;
> + =A0 =A0field_def_t =A0 =A0 =A0 =A0 *fields;
> + =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0num_fields;
> + =A0 =A0struct powerdomain *pwrdm;
> +} register_def_t;
> +
> +#define NUM_ELTS(whole, part) (sizeof(whole)/sizeof(part))
> +#define NUM_FIELDS(whole) (sizeof(whole)/sizeof(field_def_t))
> +
> +#define DECODER(name) \
> + =A0 =A0 char *decode_##name(u8 ix) { \
> + =A0 =A0 =A0 if (ix > sizeof(name)/sizeof(char *)) =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 return "*invalid*"; =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0\
> + =A0 =A0 =A0 else =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 return name[ix]; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 \
> +}
> +
> +#define FIELD_ATTR(name_str, base_name, funcp) \
> + =A0{ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 .name =3D name_str, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 .shift =3D base_name ## _SHIFT , =A0 =A0 =A0 =A0 =A0 =A0=
 \
> + =A0 =A0 =A0 .mask =3D base_name ## _MASK , =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 \
> + =A0 =A0 =A0 =A0.decoder =3D funcp =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0\
> + =A0 =A0}
> +
> +#endif //CONFIG_PM_DEBUG
>
> =A0/**
> =A0* struct powerdomain - OMAP powerdomain
> @@ -124,6 +165,8 @@ struct powerdomain {
> =A0#ifdef CONFIG_PM_DEBUG
> =A0 =A0 =A0 =A0s64 timer;
> =A0 =A0 =A0 =A0s64 state_timer[PWRDM_MAX_PWRSTS];
> + =A0 =A0 =A0 register_def_t **register_defs;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0num_reg_defs;
> =A0#endif
> =A0};
>
> @@ -149,6 +192,7 @@ struct powerdomain {
> =A0* @pwrdm_wait_transition: Wait for a pd state transition to comple=
te
> =A0*/
> =A0struct pwrdm_ops {
> + =A0 =A0 =A0 int =A0 =A0 (*pwrdm_read_reg_field)(field_def_t *f);
> =A0 =A0 =A0 =A0int =A0 =A0 (*pwrdm_set_next_pwrst)(struct powerdomain=
 *pwrdm, u8 pwrst);
> =A0 =A0 =A0 =A0int =A0 =A0 (*pwrdm_read_next_pwrst)(struct powerdomai=
n *pwrdm);
> =A0 =A0 =A0 =A0int =A0 =A0 (*pwrdm_read_pwrst)(struct powerdomain *pw=
rdm);
> @@ -173,6 +217,7 @@ int pwrdm_register_platform_funcs(struct pwrdm_op=
s
> *custom_funcs);
> =A0int pwrdm_register_pwrdms(struct powerdomain **pwrdm_list);
> =A0int pwrdm_complete_init(void);
>
> +void pwrdm_create_register_dirs(struct powerdomain *p, struct dentry
> *pd_dentry);
> =A0struct powerdomain *pwrdm_lookup(const char *name);
>
> =A0int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user=
),
> @@ -237,5 +282,4 @@ extern u32 omap2_pwrdm_get_mem_bank_stst_mask(u8 =
bank);
> =A0extern struct powerdomain wkup_omap2_pwrdm;
> =A0extern struct powerdomain gfx_omap2_pwrdm;
>
> -
> =A0#endif
> diff --git a/arch/arm/mach-omap2/powerdomain44xx.c
> b/arch/arm/mach-omap2/powerdomain44xx.c
> index a7880af..3d6d026 100644
> --- a/arch/arm/mach-omap2/powerdomain44xx.c
> +++ b/arch/arm/mach-omap2/powerdomain44xx.c
> @@ -44,6 +44,28 @@ static int omap4_pwrdm_read_next_pwrst(struct
> powerdomain *pwrdm)
> =A0 =A0 =A0 =A0return v;
> =A0}
>
> +static int omap4_pwrdm_read_reg_field(field_def_t *f)
> +{
> + =A0 =A0 =A0 u32 v;
> + =A0 =A0 =A0 struct powerdomain *pwrdm;
> + =A0 =A0 =A0 register_def_t *reg;
> +
> + =A0 =A0 =A0 if ((reg =3D f->reg) =3D=3D (register_def_t *)NULL)
> + =A0 =A0 =A0 =A0 return(0xdeadbeee);
> +
> + =A0 =A0 =A0 if ((pwrdm =3D reg->pwrdm) =3D=3D (struct powerdomain *=
)NULL)
> + =A0 =A0 =A0 =A0 return(0xdeadbeef);
> +
> + =A0 =A0 =A0 v =3D omap4_prminst_read_inst_reg(pwrdm->prcm_partition=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 pwrdm->prcm_offs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 reg->ix);
> + =A0 =A0 =A0 v &=3D f->mask;
> + =A0 =A0 =A0 v >>=3D f->shift;
> + =A0 =A0 =A0 return v;
> +
> +
> +}
> +
> =A0static int omap4_pwrdm_read_pwrst(struct powerdomain *pwrdm)
> =A0{
> =A0 =A0 =A0 =A0u32 v;
> @@ -210,6 +232,7 @@ static int omap4_pwrdm_wait_transition(struct
> powerdomain *pwrdm)
> =A0struct pwrdm_ops omap4_pwrdm_operations =3D {
> =A0 =A0 =A0 =A0.pwrdm_set_next_pwrst =A0 =3D omap4_pwrdm_set_next_pwr=
st,
> =A0 =A0 =A0 =A0.pwrdm_read_next_pwrst =A0=3D omap4_pwrdm_read_next_pw=
rst,
> + =A0 =A0 =A0 .pwrdm_read_reg_field =A0 =3D omap4_pwrdm_read_reg_fiel=
d,
> =A0 =A0 =A0 =A0.pwrdm_read_pwrst =A0 =A0 =A0 =3D omap4_pwrdm_read_pwr=
st,
> =A0 =A0 =A0 =A0.pwrdm_read_prev_pwrst =A0=3D omap4_pwrdm_read_prev_pw=
rst,
> =A0 =A0 =A0 =A0.pwrdm_set_lowpwrstchange =A0 =A0 =A0 =3D omap4_pwrdm_=
set_lowpwrstchange,
> diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c
> b/arch/arm/mach-omap2/powerdomains44xx_data.c
> index fbd4c5f..45d4a03 100644
> --- a/arch/arm/mach-omap2/powerdomains44xx_data.c
> +++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
> @@ -30,6 +30,83 @@
> =A0#include "prm44xx.h"
> =A0#include "prcm_mpu44xx.h"
>
> +#if CONFIG_PM_DEBUG
> +
> +char *pwrst_vals[] =A0 =A0 =A0 =3D {"off", "retention", "on-inactive=
", "on-active"};
> +char *boolean_vals[] =A0 =A0 =3D {"false", "true"};
> +char *statest_vals[] =A0 =A0 =3D {"off", "retention", "on-inactive",=
 "on-active"};
> +char *logicst_vals[] =A0 =A0 =3D {"off", =A0"on"};
> +char *logic_retst_vals[] =3D {"retention regigsters", "whole logic"}=
;
> +
> +DECODER(pwrst_vals);
> +DECODER(boolean_vals);
> +DECODER(statest_vals);
> +DECODER(logicst_vals);
> +DECODER(logic_retst_vals);
> +
> +field_def_t pwrst_fields[] =3D {
> + =A0 =A0FIELD_ATTR("lastpowerstateentered",
> OMAP4430_LASTPOWERSTATEENTERED, decode_pwrst_vals),
> + =A0 =A0FIELD_ATTR("intransition", OMAP4430_INTRANSITION, =A0decode_=
boolean_vals),
> + =A0 =A0FIELD_ATTR("ram_statest", OMAP4430_MPU_RAM_STATEST, =A0 =A0 =
=A0 =A0decode_statest_vals),
> + =A0 =A0FIELD_ATTR("l2_statest", OMAP4430_MPU_L2_STATEST, decode_sta=
test_vals),
> + =A0 =A0FIELD_ATTR("l1_statest", OMAP4430_MPU_L1_STATEST, decode_sta=
test_vals),
> + =A0 =A0FIELD_ATTR("logicstatest", OMAP4430_LOGICSTATEST, decode_log=
icst_vals),
> + =A0 =A0FIELD_ATTR("powerstatest", OMAP_POWERSTATEST, decode_pwrst_v=
als),
> +};
> +
> +field_def_t pwrstctl_fields[] =3D {
> + =A0 =A0FIELD_ATTR("ram_onstate", =A0 =A0 OMAP4430_MPU_RAM_ONSTATE,
> decode_statest_vals),
> + =A0 =A0FIELD_ATTR("l2_onstate", =A0 =A0 OMAP4430_MPU_L2_ONSTATE,
> decode_statest_vals),
> + =A0 =A0FIELD_ATTR("l1_onstate", =A0 =A0 OMAP4430_MPU_L1_ONSTATE,
> decode_statest_vals),
> + =A0 =A0FIELD_ATTR("ram_retstate", =A0 =A0 OMAP4430_MPU_RAM_RETSTATE=
,
> decode_statest_vals),
> + =A0 =A0FIELD_ATTR("l2_retstate", =A0 =A0 OMAP4430_MPU_L2_RETSTATE,
> decode_statest_vals),
> + =A0 =A0FIELD_ATTR("l1_retstate", =A0 =A0 OMAP4430_MPU_L1_RETSTATE,
> decode_statest_vals),
> + =A0 =A0FIELD_ATTR("lowpowerstatechange",
> OMAP4430_LOWPOWERSTATECHANGE, =A0 =A0 decode_boolean_vals),
> + =A0 =A0FIELD_ATTR("logicretstate", =A0 =A0 OMAP4430_LOGICRETSTATE,
> decode_logic_retst_vals),
> + =A0 =A0FIELD_ATTR("powerstate", =A0 =A0 OMAP_POWERSTATE, =A0 =A0 de=
code_pwrst_vals),
> +};
> +
> +field_def_t rstst_fields[] =3D {
> +
> + =A0 =A0FIELD_ATTR("emulation_rst", =A0 =A0 OMAP4430_EMULATION_RST,
> decode_boolean_vals),
> +};
> +
> +field_def_t ctx_fields[] =3D {
> + =A0 =A0FIELD_ATTR("lostmem_ram", =A0 =A0 OMAP4430_LOSTMEM_MPU_RAM,
> decode_boolean_vals),
> + =A0 =A0FIELD_ATTR("lostmem_l2", =A0 =A0 OMAP4430_LOSTMEM_MPU_L2,
> decode_boolean_vals),
> + =A0 =A0FIELD_ATTR("lostmem_l1", =A0 =A0 OMAP4430_LOSTMEM_MPU_L1,
> decode_boolean_vals),
> + =A0 =A0FIELD_ATTR("lostcontext_dff", =A0 =A0 OMAP4430_LOSTCONTEXT_D=
=46F,
> decode_boolean_vals),
> +};
> +
> +
> +register_def_t omap4_mpu_pwrst =A0 =A0=3D {OMAP4_PM_PWSTST,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0"pwrst",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0pwrst_fields,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0NUM_FIELDS(pwrst_fields)};
> +register_def_t omap4_mpu_pwrstctl =3D {OMAP4_PM_PWSTCTRL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0"pwrstctl",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0pwrstctl_fields,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0NUM_FIELDS(pwrstctl_fields)};
> +register_def_t omap4_mpu_rstst =A0 =A0=3D {OMAP4_RM_RSTST,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0"rstst",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0rstst_fields,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0NUM_FIELDS(rstst_fields)};
> +register_def_t omap4_mpu_ctx =A0 =A0 =A0=3D {OMAP4_RM_MPU_CONTEXT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0"context",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0ctx_fields,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0NUM_FIELDS(ctx_fields)};
> +
> +register_def_t *omap4_mpu_regs[] =3D {
> + =A0 =A0&omap4_mpu_pwrst,
> + =A0 =A0&omap4_mpu_pwrstctl,
> + =A0 =A0&omap4_mpu_rstst,
> + =A0 =A0&omap4_mpu_ctx
> +};
> +
> +
> +#endif // CONFIG_PM_DEBUG
> +
> +
> =A0/* core_44xx_pwrdm: CORE power domain */
> =A0static struct powerdomain core_44xx_pwrdm =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =A0 =3D "core_pwrdm",
> @@ -218,6 +295,10 @@ static struct powerdomain mpu_443x_pwrdm =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[1] =3D PWRSTS_ON, =A0 =A0 =A0 =A0/* m=
pu_l2 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[2] =3D PWRSTS_ON, =A0 =A0 =A0 =A0/* m=
pu_ram */
> =A0 =A0 =A0 =A0},
> +#ifdef CONFIG_PM_DEBUG
> + =A0 =A0 =A0 .register_defs =3D omap4_mpu_regs,
> + =A0 =A0 =A0 .num_reg_defs =3D NUM_ELTS(omap4_mpu_regs,register_def_=
t *),
> +#endif
> =A0};
>
> =A0static struct powerdomain mpu_446x_pwrdm =3D {
> @@ -236,6 +317,10 @@ static struct powerdomain mpu_446x_pwrdm =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[0] =3D PWRSTS_ON, =A0 =A0 =A0 =A0/* m=
pu_l2 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[1] =3D PWRSTS_ON, =A0 =A0 =A0 =A0/* m=
pu_ram */
> =A0 =A0 =A0 =A0},
> +#ifdef CONFIG_PM_DEBUG
> + =A0 =A0 =A0 .register_defs =3D omap4_mpu_regs,
> + =A0 =A0 =A0 .num_reg_defs =3D NUM_ELTS(omap4_mpu_regs,register_def_=
t *),
> +#endif
> =A0};
>
> =A0/* ivahd_44xx_pwrdm: IVA-HD power domain */
> diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm4=
4xx.h
> index 3d66ccd..926257f 100644
> --- a/arch/arm/mach-omap2/prm44xx.h
> +++ b/arch/arm/mach-omap2/prm44xx.h
> @@ -66,6 +66,7 @@
> =A0#define OMAP4_RM_RSTST =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 0x0008
> =A0#define OMAP4_PM_PWSTCTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A00x0000
> =A0#define OMAP4_PM_PWSTST =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0004
> +#define OMAP4_RM_MPU_CONTEXT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A00x0024
>
>
> =A0/* PRM */
> --
> 1.7.9.5
>
>
>
>
> --
> - evt
> (Eric van Tassell)
> twitter: evt_texelsoft
> linked-in: linkedin.com/in/evttxl
>
> _______________________________________________
> linaro-kernel mailing list
> linaro-kernel@lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-kernel
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
