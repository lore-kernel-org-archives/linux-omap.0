From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 15/16] OMAP3: Dynamic enable/disable of OFF support
Date: Tue, 30 Sep 2008 12:49:23 +0300
Message-ID: <87prmmrmjg.fsf@trdhcp146196.ntc.nokia.com>
References: <024801c92201$506cf780$LocalHost@wipultra1382>
	<87iqsec708.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:56507 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbYI3JrS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 05:47:18 -0400
In-Reply-To: <87iqsec708.fsf@deeprootsystems.com> (ext Kevin Hilman's message
	of "Tue, 30 Sep 2008 12:33:59 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org

"ext Kevin Hilman" <khilman@deeprootsystems.com> writes:

> "Rajendra Nayak" <rnayak@ti.com> writes:
>
>> I just managed to see that this patch seems to break suspend
>> functionality.  If after bootup I enable OFF mode the subsequent
>> suspend tries to put a few power domains to OFF which are currently
>> in RET, and since there is no code in place today to handle RET to
>> OFF transitions, they don't transition to OFF and remain in RET.
>
> See commit a974addcfa23181667fe32e5032820917bf4a2b2 from Tero Kristo.
> This patch was meant to address these kinds of transitions, but it
> seems it's not working exactly right.  I'm debugging now.
>
>> Supporting run time enable/disable of OFF functionality is kind of
>> becoming complicated.  Do we really see a need to have a run-time
>> option to enable/disable OFF mode or can we have a compile time
>> option for this?
>
> Run-time option is required.

Whole cpuidle + srf concept is about changing between OFF/RET/ON
dynamically. So if implementing it through one sysfs entry is
discarded because it's complicated, how do you think you could
implement it in cpuidle and srf?

>
> Kevin
>
>>> -----Original Message-----
>>> From: linux-omap-owner@vger.kernel.org=20
>>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Rajendra Nay=
ak
>>> Sent: Friday, September 26, 2008 5:50 PM
>>> To: linux-omap@vger.kernel.org
>>> Cc: 'Kevin Hilman'
>>> Subject: [PATCH 15/16] OMAP3: Dynamic enable/disable of OFF support
>>>=20
>>> This patch adds a runtime sysfs knob (/sys/power/enable_off_mode)
>>> to enable/disbale CORE OFF support for OMAP3.=20
>>>=20
>>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>>> ---
>>>  arch/arm/mach-omap2/pm.c     |   21 +++++++++++++++++----
>>>  arch/arm/mach-omap2/pm.h     |    2 ++
>>>  arch/arm/mach-omap2/pm34xx.c |   26 ++++++++++++++++++++++++++
>>>  3 files changed, 45 insertions(+), 4 deletions(-)
>>>=20
>>> Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c=09
>>> 2008-09-26 16:39:30.000000000 +0530
>>> +++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c=09
>>> 2008-09-26 16:39:34.000000000 +0530
>>> @@ -395,6 +395,32 @@ static int omap3_can_sleep(void)
>>>  	return 1;
>>>  }
>>> =20
>>> +int set_next_pwrst(struct powerdomain *pwrdm)
>>> +{
>>> +	struct power_state *pwrst;
>>> +	int ret =3D 0;
>>> +	u32 state;
>>> +
>>> +	if (!pwrdm->pwrsts)
>>> +		return 0;
>>> +
>>> +	if (enable_off_mode)
>>> +		state =3D PWRDM_POWER_OFF;
>>> +	else
>>> +		state =3D PWRDM_POWER_RET;
>>> +
>>> +	ret =3D pwrdm_set_next_pwrst(pwrdm, state);
>>> +	if (ret) {
>>> +		printk(KERN_ERR "Unable to set state of=20
>>> powerdomain: %s\n",
>>> +		       pwrdm->name);
>>> +		goto err;
>>> +	}
>>> +	list_for_each_entry(pwrst, &pwrst_list, node)
>>> +		pwrst->next_state =3D state;
>>> +err:
>>> +	return ret;
>>> +}
>>> +
>>>  /* This sets pwrdm state (other than mpu & core. Currently only ON=
 &
>>>   * RET are supported. Function is assuming that clkdm doesn't have
>>>   * hw_sup mode enabled. */
>>> Index: linux-omap-2.6/arch/arm/mach-omap2/pm.c
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- linux-omap-2.6.orig/arch/arm/mach-omap2/pm.c=09
>>> 2008-09-26 16:39:30.000000000 +0530
>>> +++ linux-omap-2.6/arch/arm/mach-omap2/pm.c	2008-09-26=20
>>> 16:39:34.000000000 +0530
>>> @@ -35,6 +35,7 @@
>>> =20
>>>  unsigned short enable_dyn_sleep;
>>>  unsigned short clocks_off_while_idle;
>>> +unsigned short enable_off_mode;
>>>  atomic_t sleep_block =3D ATOMIC_INIT(0);
>>> =20
>>>  static ssize_t idle_show(struct kobject *, struct=20
>>> kobj_attribute *, char *);
>>> @@ -47,6 +48,9 @@ static struct kobj_attribute sleep_while
>>>  static struct kobj_attribute clocks_off_while_idle_attr =3D
>>>  	__ATTR(clocks_off_while_idle, 0644, idle_show, idle_store);
>>> =20
>>> +static struct kobj_attribute enable_off_mode_attr =3D
>>> +	__ATTR(enable_off_mode, 0644, idle_show, idle_store);
>>> +
>>>  static ssize_t idle_show(struct kobject *kobj, struct=20
>>> kobj_attribute *attr,
>>>  			 char *buf)
>>>  {
>>> @@ -54,6 +58,8 @@ static ssize_t idle_show(struct kobject=20
>>>  		return sprintf(buf, "%hu\n", enable_dyn_sleep);
>>>  	else if (attr =3D=3D &clocks_off_while_idle_attr)
>>>  		return sprintf(buf, "%hu\n", clocks_off_while_idle);
>>> +	else if (attr =3D=3D &enable_off_mode_attr)
>>> +		return sprintf(buf, "%hu\n", enable_off_mode);
>>>  	else
>>>  		return -EINVAL;
>>>  }
>>> @@ -69,13 +75,16 @@ static ssize_t idle_store(struct kobject
>>>  		return -EINVAL;
>>>  	}
>>> =20
>>> -	if (attr =3D=3D &sleep_while_idle_attr)
>>> +	if (attr =3D=3D &sleep_while_idle_attr) {
>>>  		enable_dyn_sleep =3D value;
>>> -	else if (attr =3D=3D &clocks_off_while_idle_attr)
>>> +	} else if (attr =3D=3D &clocks_off_while_idle_attr) {
>>>  		clocks_off_while_idle =3D value;
>>> -	else
>>> +	} else if (attr =3D=3D &enable_off_mode_attr) {
>>> +		enable_off_mode =3D value;
>>> +		pwrdm_for_each(set_next_pwrst);
>>> +	} else {
>>>  		return -EINVAL;
>>> -
>>> +	}
>>>  	return n;
>>>  }
>>> =20
>>> @@ -114,6 +123,10 @@ static int __init omap_pm_init(void)
>>>  				  &clocks_off_while_idle_attr.attr);
>>>  	if (error)
>>>  		printk(KERN_ERR "sysfs_create_file failed:=20
>>> %d\n", error);
>>> +	error =3D sysfs_create_file(power_kobj,
>>> +				  &enable_off_mode_attr.attr);
>>> +	if (error)
>>> +		printk(KERN_ERR "sysfs_create_file failed:=20
>>> %d\n", error);
>>> =20
>>>  	return error;
>>>  }
>>> Index: linux-omap-2.6/arch/arm/mach-omap2/pm.h
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- linux-omap-2.6.orig/arch/arm/mach-omap2/pm.h=09
>>> 2008-09-26 16:39:30.000000000 +0530
>>> +++ linux-omap-2.6/arch/arm/mach-omap2/pm.h	2008-09-26=20
>>> 16:39:34.000000000 +0530
>>> @@ -18,10 +18,12 @@ extern int omap3_pm_init(void);
>>> =20
>>>  extern unsigned short enable_dyn_sleep;
>>>  extern unsigned short clocks_off_while_idle;
>>> +extern unsigned short enable_off_mode;
>>>  extern atomic_t sleep_block;
>>> =20
>>>  extern void omap2_block_sleep(void);
>>>  extern void omap2_allow_sleep(void);
>>> +extern int set_next_pwrst(struct powerdomain *pwrdm);
>>> =20
>>>  #define OMAP343X_TABLE_ADDRESS_OFFSET 0x31
>>>  #define OMAP343X_TABLE_VALUE_OFFSET   0x30
>>>=20
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe=20
>>> linux-omap" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>=20
>>>=20
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
