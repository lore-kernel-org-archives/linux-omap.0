From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 1/4] PM: Dynamic GPIO clock handling
Date: Fri, 05 Sep 2008 16:47:28 +0300
Message-ID: <87od32vh5b.fsf@trdhcp146196.ntc.nokia.com>
References: <1219851962-28972-1-git-send-email-tero.kristo@nokia.com>
	<1219851962-28972-2-git-send-email-tero.kristo@nokia.com>
	<alpine.DEB.1.00.0809050631590.5763@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:26193 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909AbYIENrW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 09:47:22 -0400
In-Reply-To: <alpine.DEB.1.00.0809050631590.5763@utopia.booyaka.com> (ext Paul
	Walmsley's message of "Fri, 5 Sep 2008 07:29:55 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <tero.kristo@nokia.com>, linux-omap@vger.kernel.org

"ext Paul Walmsley" <paul@pwsan.com> writes:

> Hello Tero, Jouni,
>
> so is this basically a workaround patch?

Yes in new format. Please do not use word workaround;)

>
> a few comments:
>
> On Wed, 27 Aug 2008, Tero Kristo wrote:
>
>> From: ext Jouni Hogander <jouni.hogander@nokia.com>
>>=20
>> In omap3 gpios 2-6 are in per domain. Functional clocks for these
>> should be disabled.
>>=20
>> GPIO modules in PER domain are not able to act as a wake up source i=
f
>> PER domain is in retention. PER domain sleep transition before MPU i=
s
>> prevented by leaving icks active. PER domain still enters retention
>> together with MPU. When this happens IOPAD wake up mechanism is used
>> for gpios.
>>=20
>> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
>> ---
>>  arch/arm/mach-omap2/pm.c     |   20 ++++++++------
>>  arch/arm/mach-omap2/pm.h     |    2 +-
>>  arch/arm/mach-omap2/pm34xx.c |   56 +++++++++++++++++++++++++++++++=
++++++++++-
>>  3 files changed, 67 insertions(+), 11 deletions(-)
>>=20
>> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
>> index 4652136..1de5f14 100644
>> --- a/arch/arm/mach-omap2/pm.c
>> +++ b/arch/arm/mach-omap2/pm.c
>> @@ -32,7 +32,7 @@
>>  #include "pm.h"
>> =20
>>  unsigned short enable_dyn_sleep;
>> -unsigned short clocks_off_while_idle;
>> +unsigned short gpio_clocks_off_while_idle;
>>  atomic_t sleep_block =3D ATOMIC_INIT(0);
>> =20
>>  static ssize_t idle_show(struct kobject *, struct kobj_attribute *,=
 char *);
>> @@ -42,16 +42,16 @@ static ssize_t idle_store(struct kobject *k, str=
uct kobj_attribute *,
>>  static struct kobj_attribute sleep_while_idle_attr =3D
>>  	__ATTR(sleep_while_idle, 0644, idle_show, idle_store);
>> =20
>> -static struct kobj_attribute clocks_off_while_idle_attr =3D
>> -	__ATTR(clocks_off_while_idle, 0644, idle_show, idle_store);
>> +static struct kobj_attribute gpio_clocks_off_while_idle_attr =3D
>> +	__ATTR(gpio_clocks_off_while_idle, 0644, idle_show, idle_store);
>> =20
>>  static ssize_t idle_show(struct kobject *kobj, struct kobj_attribut=
e *attr,
>>  			 char *buf)
>>  {
>>  	if (attr =3D=3D &sleep_while_idle_attr)
>>  		return sprintf(buf, "%hu\n", enable_dyn_sleep);
>> -	else if (attr =3D=3D &clocks_off_while_idle_attr)
>> -		return sprintf(buf, "%hu\n", clocks_off_while_idle);
>> +	else if (attr =3D=3D &gpio_clocks_off_while_idle_attr)
>> +		return sprintf(buf, "%hu\n", gpio_clocks_off_while_idle);
>>  	else
>>  		return -EINVAL;
>>  }
>> @@ -69,8 +69,8 @@ static ssize_t idle_store(struct kobject *kobj, st=
ruct kobj_attribute *attr,
>> =20
>>  	if (attr =3D=3D &sleep_while_idle_attr)
>>  		enable_dyn_sleep =3D value;
>> -	else if (attr =3D=3D &clocks_off_while_idle_attr)
>> -		clocks_off_while_idle =3D value;
>> +	else if (attr =3D=3D &gpio_clocks_off_while_idle_attr)
>> +		gpio_clocks_off_while_idle =3D value;
>>  	else
>>  		return -EINVAL;
>> =20
>> @@ -106,10 +106,12 @@ static int __init omap_pm_init(void)
>>  	/* disabled till drivers are fixed */
>>  	enable_dyn_sleep =3D 0;
>>  	error =3D sysfs_create_file(power_kobj, &sleep_while_idle_attr.att=
r);
>> -	if (error)
>> +	if (error) {
>>  		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
>> +		return error;
>> +	}
>>  	error =3D sysfs_create_file(power_kobj,
>> -				  &clocks_off_while_idle_attr.attr);
>> +				  &gpio_clocks_off_while_idle_attr.attr);
>>  	if (error)
>>  		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
>> =20
>> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
>> index 68c9278..d446ea4 100644
>> --- a/arch/arm/mach-omap2/pm.h
>> +++ b/arch/arm/mach-omap2/pm.h
>> @@ -17,7 +17,7 @@ extern int omap2_pm_init(void);
>>  extern int omap3_pm_init(void);
>> =20
>>  extern unsigned short enable_dyn_sleep;
>> -extern unsigned short clocks_off_while_idle;
>> +extern unsigned short gpio_clocks_off_while_idle;
>>  extern atomic_t sleep_block;
>> =20
>>  extern void omap2_block_sleep(void);
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34=
xx.c
>> index a16eb33..0baf359 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -53,6 +53,43 @@ static void (*saved_idle)(void);
>> =20
>>  static struct powerdomain *mpu_pwrdm;
>> =20
>> +/* Dynamic GPIO clock handling for sleep routines.
>> + * omap_sram_idle() will call these functions and they will dynamic=
ally
>> + * enable / disable GPIO clocks to allow sleep transitions. */
>
> Please use CodingStyle format for multiple-line comments, e.g.,

Yes, needs to be fixed...

>
> /*
>  * Dynamic GPIO clock handling ...
>  * etc. etc. etc.
>  */
>
> This also applies to several other comments later in the file.

ok

>
>> +#define NUM_OF_PERGPIOS 5
>> +static struct clk *gpio_fcks[NUM_OF_PERGPIOS];
>> +
>> +/* Enable GPIO clocks from sleep routines if allowed */
>> +static void per_gpio_clk_enable(void)
>> +{
>> +	int i;
>> +
>> +	if (gpio_clocks_off_while_idle =3D=3D 0)
>> +		return;
>> +	for (i =3D 1; i < NUM_OF_PERGPIOS + 1; i++)
>> +		clk_enable(gpio_fcks[i-1]);
>
> Why not just:
>
>     for (i =3D 0; i < NUM_OF_PERGPIOS; i++)
>              clk_enable(gpio_fcks[i]);
>
> ?

Yes, these all needs to be fixed.=20

Thank you for you comments.

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
