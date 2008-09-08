From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 4/4] Sysfs interface for controlling suspend states + set_pwrdm_state fix
Date: Mon, 08 Sep 2008 09:35:56 +0300
Message-ID: <87bpyzta9f.fsf@trdhcp146196.ntc.nokia.com>
References: <1219851962-28972-1-git-send-email-tero.kristo@nokia.com>
	<1219851962-28972-2-git-send-email-tero.kristo@nokia.com>
	<1219851962-28972-3-git-send-email-tero.kristo@nokia.com>
	<1219851962-28972-4-git-send-email-tero.kristo@nokia.com>
	<1219851962-28972-5-git-send-email-tero.kristo@nokia.com>
	<alpine.DEB.1.00.0809050641591.5763@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:31260 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837AbYIHGfG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 02:35:06 -0400
In-Reply-To: <alpine.DEB.1.00.0809050641591.5763@utopia.booyaka.com> (ext Paul
	Walmsley's message of "Fri, 5 Sep 2008 07:30:21 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <tero.kristo@nokia.com>, linux-omap@vger.kernel.org

"ext Paul Walmsley" <paul@pwsan.com> writes:

> Hello Tero,
>
> On Wed, 27 Aug 2008, Tero Kristo wrote:
>
>> Target states for each powerdomain can now be set via sysfs interfac=
e.
>> E.g. "echo 0 > /sys/power/suspend/mpu_pwrdm" will program MPU suspen=
d
>> state to be OFF.
>
> Is this all debugging code, or is there a broader use in mind?
>
> If it is debugging code, the directory should probably go to debugfs,=
 and=20
> all of this code should be wrapped in #ifdef CONFIG_PM_DEBUG.
>
> Either way, let's change the directory structure, so we can add=20
> other files for other powerdomain parameters later.  How about:
>
> /sys/power/domain/mpu_pwrdm/next_power_state
>
> or=20
>
> /debug/powerdomain/mpu_pwrdm/next_power_state
>
> ?

I'm not sure if you though so, but for clarification: these interfaces
are not telling value of next_powerst. They are for defining pwrst of
each powerdomain on next suspend. CPUidle/pm_idle/srf can live their
own life and select dynamic next_pwrsts outside this. In case of
suspend each powerdomain is tried to be driven in to state declared in
/sys/power/suspend/*.

Paul, what do you think? Is this for debugging only? I think it is for
debugging, but so is whole suspend concept. At least from my point of v=
iew.

>
>> Also, set_pwrdm_state() should now work when pwrdm is currently in
>> power save state.
>>=20
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>> ---
>>  arch/arm/mach-omap2/pm34xx.c |   97 +++++++++++++++++++++++++++++++=
++++++++++-
>>  1 files changed, 96 insertions(+), 1 deletions(-)
>>=20
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34=
xx.c
>> index e0d1b1f..4b42031 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -82,6 +82,8 @@ static void per_gpio_clk_disable(void)
>>  		clk_disable(gpio_fcks[i-1]);
>>  }
>> =20
>> +static struct kobject *suspend_dir_kobj;
>> +
>>  /* XXX This is for gpio fclk hack. Will be removed as gpio driver
>>   * handles fcks correctly */
>>  static void gpio_fclk_mask(u32 *fclk)
>> @@ -306,6 +308,7 @@ int set_pwrdm_state(struct powerdomain *pwrdm, u=
32 state)
>>  {
>>  	u32 cur_state;
>>  	int ret =3D 0;
>> +	int sleep_switch =3D 0;
>> =20
>>  	if (pwrdm =3D=3D NULL || IS_ERR(pwrdm))
>>  		return -EINVAL;
>> @@ -315,6 +318,16 @@ int set_pwrdm_state(struct powerdomain *pwrdm, =
u32 state)
>>  	if (cur_state =3D=3D state)
>>  		return ret;
>> =20
>> +	/* Check if we need to wake-up the pwrdm for state switch */
>> +	/* MPU, core and per are never in sleep states when we are here*/
>
> Please make sure your comments follow CodingStyle - in this case, add=
 a=20
> space after "here"
>
>> +	if (pwrdm_read_pwrst(pwrdm) < PWRDM_POWER_ON) {
>> +		if ((cm_read_mod_reg(pwrdm->prcm_offs, 0x48) & 0x3) =3D=3D 0x3) {
>
> Please use preprocessor macros, not these bare numbers.  This sort of=
=20
> thing is just backsliding.
>
>> +			sleep_switch =3D 1;
>> +			cm_rmw_mod_reg_bits(0x3, 0x2, pwrdm->prcm_offs, 0x48);
>
> As above.
>
>> +			pwrdm_wait_transition(pwrdm);
>> +		}
>> +	}
>> +
>>  	pwrdm_for_each_clkdm(pwrdm, _clkdm_deny_idle);
>> =20
>>  	ret =3D pwrdm_set_next_pwrst(pwrdm, state);
>> @@ -326,6 +339,12 @@ int set_pwrdm_state(struct powerdomain *pwrdm, =
u32 state)
>> =20
>>  	pwrdm_for_each_clkdm(pwrdm, _clkdm_allow_idle);
>> =20
>> +	if (sleep_switch) {
>> +		cm_rmw_mod_reg_bits(0x3, 0x3, pwrdm->prcm_offs, 0x48);
>
> As above.
>
>> +		pwrdm_wait_transition(pwrdm);
>> +		pm_dbg_pwrdm_state_switch(pwrdm);
>> +	}
>> +
>>  err:
>>  	return ret;
>>  }
>> @@ -380,7 +399,6 @@ static int omap3_pm_suspend(void)
>>  restore:
>>  	/* Restore next_pwrsts */
>>  	list_for_each_entry(pwrst, &pwrst_list, node) {
>  > -		set_pwrdm_state(pwrst->pwrdm, pwrst->saved_state);
>>  		state =3D pwrdm_read_prev_pwrst(pwrst->pwrdm);
>>  		if (state !=3D pwrst->next_state) {
>>  			printk(KERN_INFO "Powerdomain (%s) didn't enter "
>> @@ -388,6 +406,7 @@ restore:
>>  			       pwrst->pwrdm->name, pwrst->next_state);
>>  			ret =3D -1;
>>  		}
>> +		set_pwrdm_state(pwrst->pwrdm, pwrst->saved_state);
>>  	}
>>  	if (ret)
>>  		printk(KERN_ERR "Could not enter target state in pm_suspend\n");
>> @@ -584,9 +603,67 @@ static void __init prcm_setup_regs(void)
>>  			OCP_MOD, OMAP2_PRM_IRQENABLE_MPU_OFFSET);
>>  }
>> =20
>> +static struct power_state *get_pwrst_node(const char *name)
>> +{
>> +	struct powerdomain *pwrdm;
>> +	struct power_state *pwrst_tmp;
>> +	struct power_state *pwrst =3D NULL;
>> +
>> +	pwrdm =3D pwrdm_lookup(name);
>> +
>> +	if (pwrdm =3D=3D NULL) {
>> +		printk(KERN_ERR "pwrdm not found %s\n", name);
>> +		return NULL;
>> +	}
>> +
>> +	list_for_each_entry(pwrst_tmp, &pwrst_list, node)
>> +		if (pwrst_tmp->pwrdm =3D=3D pwrdm)
>> +			pwrst =3D pwrst_tmp;
>> +
>> +	if (pwrst =3D=3D NULL)
>> +		printk(KERN_ERR "pwrdm not in suspend list %s\n", name);
>> +
>> +	return pwrst;
>> +}
>> +
>> +static ssize_t state_show(struct kobject *kobj, struct kobj_attribu=
te *attr,
>> +			 char *buf)
>> +{
>> +	struct power_state *pwrst;
>> +
>> +	pwrst =3D get_pwrst_node(attr->attr.name);
>> +
>> +	if (pwrst =3D=3D NULL)
>> +		return -EINVAL;
>> +
>> +	return sprintf(buf, "%hu\n", pwrst->next_state);
>> +}
>> +
>> +static ssize_t state_store(struct kobject *kobj, struct kobj_attrib=
ute *attr,
>> +			  const char *buf, size_t n)
>> +{
>> +	struct power_state *pwrst;
>> +	unsigned short value;
>> +
>> +	if (sscanf(buf, "%hu", &value) !=3D 1 || value > PWRDM_POWER_ON) {
>> +		printk(KERN_ERR "state_store: Invalid value\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	pwrst =3D get_pwrst_node(attr->attr.name);
>> +
>> +	if (pwrst =3D=3D NULL)
>> +		return -EINVAL;
>> +
>> +	pwrst->next_state =3D value;
>> +
>> +	return n;
>> +}
>> +
>>  static int __init pwrdms_setup(struct powerdomain *pwrdm)
>>  {
>>  	struct power_state *pwrst;
>> +	struct kobj_attribute *attr;
>> =20
>>  	if (!pwrdm->pwrsts)
>>  		return 0;
>> @@ -601,6 +678,18 @@ static int __init pwrdms_setup(struct powerdoma=
in *pwrdm)
>>  	if (pwrdm_has_hdwr_sar(pwrdm))
>>  		pwrdm_enable_hdwr_sar(pwrdm);
>> =20
>> +	attr =3D kmalloc(sizeof(struct kobj_attribute), GFP_KERNEL);
>> +	if (!attr)
>> +		return -ENOMEM;
>> +
>> +	attr->attr.name =3D pwrdm->name;
>> +	attr->attr.mode =3D 0644;
>> +	attr->show =3D state_show;
>> +	attr->store =3D state_store;
>> +
>> +	if (sysfs_create_file(suspend_dir_kobj, &(attr->attr)))
>> +		return -ENOMEM;
>> +
>>  	return set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
>>  }
>> =20
>> @@ -625,6 +714,12 @@ int __init omap3_pm_init(void)
>>  		goto err1;
>>  	}
>> =20
>> +	suspend_dir_kobj =3D kobject_create_and_add("suspend_config", powe=
r_kobj);
>> +	if (!suspend_dir_kobj) {
>> +		ret =3D -ENOMEM;
>> +		goto err2;
>> +	}
>> +
>>  	ret =3D pwrdm_for_each(pwrdms_setup);
>>  	if (ret) {
>>  		printk(KERN_ERR "Failed to setup powerdomains\n");
>> --=20
>> 1.5.4.3
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>=20
>
>
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
