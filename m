From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH 1/4] PM: Dynamic GPIO clock handling
Date: Fri, 12 Sep 2008 13:04:12 +0300
Message-ID: <B71CE868F2BC2847B3F23C5A8EE394307E20AD@vaebe110.NOE.Nokia.com>
References: <1219851962-28972-1-git-send-email-tero.kristo@nokia.com><1219851962-28972-2-git-send-email-tero.kristo@nokia.com><alpine.DEB.1.00.0809050631590.5763@utopia.booyaka.com> <87od32vh5b.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:36495 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbYILKEk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 06:04:40 -0400
Content-class: urn:content-classes:message
In-Reply-To: <87od32vh5b.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jouni.hogander@nokia.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org

These comments should now be fixed in the new version I just sent out.

-Tero=20

>-----Original Message-----
>From: H=F6gander Jouni [mailto:jouni.hogander@nokia.com]=20
>Sent: 05 September, 2008 16:47
>To: ext Paul Walmsley
>Cc: Kristo Tero (Nokia-D/Tampere); linux-omap@vger.kernel.org
>Subject: Re: [PATCH 1/4] PM: Dynamic GPIO clock handling
>
>"ext Paul Walmsley" <paul@pwsan.com> writes:
>
>> Hello Tero, Jouni,
>>
>> so is this basically a workaround patch?
>
>Yes in new format. Please do not use word workaround;)
>
>>
>> a few comments:
>>
>> On Wed, 27 Aug 2008, Tero Kristo wrote:
>>
>>> From: ext Jouni Hogander <jouni.hogander@nokia.com>
>>>=20
>>> In omap3 gpios 2-6 are in per domain. Functional clocks for these=20
>>> should be disabled.
>>>=20
>>> GPIO modules in PER domain are not able to act as a wake up=20
>source if=20
>>> PER domain is in retention. PER domain sleep transition=20
>before MPU is=20
>>> prevented by leaving icks active. PER domain still enters retention=
=20
>>> together with MPU. When this happens IOPAD wake up=20
>mechanism is used=20
>>> for gpios.
>>>=20
>>> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
>>> ---
>>>  arch/arm/mach-omap2/pm.c     |   20 ++++++++------
>>>  arch/arm/mach-omap2/pm.h     |    2 +-
>>>  arch/arm/mach-omap2/pm34xx.c |   56=20
>+++++++++++++++++++++++++++++++++++++++++-
>>>  3 files changed, 67 insertions(+), 11 deletions(-)
>>>=20
>>> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c=20
>>> index 4652136..1de5f14 100644
>>> --- a/arch/arm/mach-omap2/pm.c
>>> +++ b/arch/arm/mach-omap2/pm.c
>>> @@ -32,7 +32,7 @@
>>>  #include "pm.h"
>>> =20
>>>  unsigned short enable_dyn_sleep;
>>> -unsigned short clocks_off_while_idle;
>>> +unsigned short gpio_clocks_off_while_idle;
>>>  atomic_t sleep_block =3D ATOMIC_INIT(0);
>>> =20
>>>  static ssize_t idle_show(struct kobject *, struct=20
>kobj_attribute *,=20
>>> char *); @@ -42,16 +42,16 @@ static ssize_t=20
>idle_store(struct kobject=20
>>> *k, struct kobj_attribute *,  static struct kobj_attribute=20
>sleep_while_idle_attr =3D
>>>  	__ATTR(sleep_while_idle, 0644, idle_show, idle_store);
>>> =20
>>> -static struct kobj_attribute clocks_off_while_idle_attr =3D
>>> -	__ATTR(clocks_off_while_idle, 0644, idle_show, idle_store);
>>> +static struct kobj_attribute gpio_clocks_off_while_idle_attr =3D
>>> +	__ATTR(gpio_clocks_off_while_idle, 0644, idle_show, idle_store);
>>> =20
>>>  static ssize_t idle_show(struct kobject *kobj, struct=20
>kobj_attribute *attr,
>>>  			 char *buf)
>>>  {
>>>  	if (attr =3D=3D &sleep_while_idle_attr)
>>>  		return sprintf(buf, "%hu\n", enable_dyn_sleep);
>>> -	else if (attr =3D=3D &clocks_off_while_idle_attr)
>>> -		return sprintf(buf, "%hu\n", clocks_off_while_idle);
>>> +	else if (attr =3D=3D &gpio_clocks_off_while_idle_attr)
>>> +		return sprintf(buf, "%hu\n",=20
>gpio_clocks_off_while_idle);
>>>  	else
>>>  		return -EINVAL;
>>>  }
>>> @@ -69,8 +69,8 @@ static ssize_t idle_store(struct kobject *kobj,=20
>>> struct kobj_attribute *attr,
>>> =20
>>>  	if (attr =3D=3D &sleep_while_idle_attr)
>>>  		enable_dyn_sleep =3D value;
>>> -	else if (attr =3D=3D &clocks_off_while_idle_attr)
>>> -		clocks_off_while_idle =3D value;
>>> +	else if (attr =3D=3D &gpio_clocks_off_while_idle_attr)
>>> +		gpio_clocks_off_while_idle =3D value;
>>>  	else
>>>  		return -EINVAL;
>>> =20
>>> @@ -106,10 +106,12 @@ static int __init omap_pm_init(void)
>>>  	/* disabled till drivers are fixed */
>>>  	enable_dyn_sleep =3D 0;
>>>  	error =3D sysfs_create_file(power_kobj,=20
>&sleep_while_idle_attr.attr);
>>> -	if (error)
>>> +	if (error) {
>>>  		printk(KERN_ERR "sysfs_create_file failed:=20
>%d\n", error);
>>> +		return error;
>>> +	}
>>>  	error =3D sysfs_create_file(power_kobj,
>>> -				  &clocks_off_while_idle_attr.attr);
>>> +				 =20
>&gpio_clocks_off_while_idle_attr.attr);
>>>  	if (error)
>>>  		printk(KERN_ERR "sysfs_create_file failed:=20
>%d\n", error);
>>> =20
>>> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h=20
>>> index 68c9278..d446ea4 100644
>>> --- a/arch/arm/mach-omap2/pm.h
>>> +++ b/arch/arm/mach-omap2/pm.h
>>> @@ -17,7 +17,7 @@ extern int omap2_pm_init(void);  extern int=20
>>> omap3_pm_init(void);
>>> =20
>>>  extern unsigned short enable_dyn_sleep; -extern unsigned short=20
>>> clocks_off_while_idle;
>>> +extern unsigned short gpio_clocks_off_while_idle;
>>>  extern atomic_t sleep_block;
>>> =20
>>>  extern void omap2_block_sleep(void); diff --git=20
>>> a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c index=
=20
>>> a16eb33..0baf359 100644
>>> --- a/arch/arm/mach-omap2/pm34xx.c
>>> +++ b/arch/arm/mach-omap2/pm34xx.c
>>> @@ -53,6 +53,43 @@ static void (*saved_idle)(void);
>>> =20
>>>  static struct powerdomain *mpu_pwrdm;
>>> =20
>>> +/* Dynamic GPIO clock handling for sleep routines.
>>> + * omap_sram_idle() will call these functions and they will=20
>>> +dynamically
>>> + * enable / disable GPIO clocks to allow sleep transitions. */
>>
>> Please use CodingStyle format for multiple-line comments, e.g.,
>
>Yes, needs to be fixed...
>
>>
>> /*
>>  * Dynamic GPIO clock handling ...
>>  * etc. etc. etc.
>>  */
>>
>> This also applies to several other comments later in the file.
>
>ok
>
>>
>>> +#define NUM_OF_PERGPIOS 5
>>> +static struct clk *gpio_fcks[NUM_OF_PERGPIOS];
>>> +
>>> +/* Enable GPIO clocks from sleep routines if allowed */=20
>static void=20
>>> +per_gpio_clk_enable(void) {
>>> +	int i;
>>> +
>>> +	if (gpio_clocks_off_while_idle =3D=3D 0)
>>> +		return;
>>> +	for (i =3D 1; i < NUM_OF_PERGPIOS + 1; i++)
>>> +		clk_enable(gpio_fcks[i-1]);
>>
>> Why not just:
>>
>>     for (i =3D 0; i < NUM_OF_PERGPIOS; i++)
>>              clk_enable(gpio_fcks[i]);
>>
>> ?
>
>Yes, these all needs to be fixed.=20
>
>Thank you for you comments.
>
>--
>Jouni H=F6gander
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
