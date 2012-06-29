From: Andy Green <andy.green@linaro.org>
Subject: Re: [PATCH 2/3] OMAP2+ devices add mac address allocation register
 api
Date: Fri, 29 Jun 2012 18:07:38 +0800
Message-ID: <4FED7E6A.4090207@linaro.org>
References: <20120629054404.11091.31289.stgit@build.warmcat.com> <20120629055516.11091.82899.stgit@build.warmcat.com> <20120629094055.GB4202@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:36730 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554Ab2F2KHt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jun 2012 06:07:49 -0400
In-Reply-To: <20120629094055.GB4202@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.pitre@linaro.org, s-jan@ti.com, arnd@arndb.de, patches@linaro.org, rostedt@goodmis.org

On 06/29/12 17:40, the mail apparently from Tony Lindgren included:
> * Andy Green <andy.green@linaro.org> [120628 22:59]:
>> From: Andy Green <andy@warmcat.com>
>>
>> This exposes a new API in devices.c that lets a board register
>> a list of device paths representing network devices that have
>> no arrangements for their MAC address to be set by the board.
>>
>> It watches network device registrations via a notifier and
>> gives the devices requiring them a synthetic - but constant for
>> a given board - MAC address immediately.
> ...
>
>> --- a/arch/arm/mach-omap2/devices.c
>> +++ b/arch/arm/mach-omap2/devices.c
>> @@ -39,6 +42,9 @@
>>   #define L3_MODULES_MAX_LEN 12
>>   #define L3_MODULES 3
>>
>> +static const char * const *mac_device_fixup_paths;
>> +int count_mac_device_fixup_paths;
>
> This too should be static it seems to me. Or just make the
> paths array NULL terminated to get rid of the count.
>
>>   static int __init omap3_l3_init(void)
>>   {
>>   	struct omap_hwmod *oh;
>> @@ -627,6 +633,89 @@ static void omap_init_vout(void)
>>   static inline void omap_init_vout(void) {}
>>   #endif
>>
>> +static int omap_device_path_need_mac(struct device *dev)
>> +{
>> +	const char **try =3D (const char **)mac_device_fixup_paths;
>
> This cast you should be able to remove by setting the types right
> to start with?

I guess so, I recall meddling with it and throwing a cast at it.

>> +	const char *path;
>> +	int count =3D count_mac_device_fixup_paths;
>> +	const char *p;
>> +	int len;
>> +	struct device *devn;
>> +
>> +	while (count--) {
>> +
>> +		p =3D *try + strlen(*try);
>> +		devn =3D dev;
>> +
>> +		while (devn) {
>> +
>> +			path =3D dev_name(devn);
>> +			len =3D strlen(path);
>> +
>> +			if ((p - *try) < len) {
>> +				devn =3D NULL;
>> +				continue;
>> +			}
>> +
>> +			p -=3D len;
>> +
>> +			if (strncmp(path, p, len)) {
>> +				devn =3D NULL;
>> +				continue;
>> +			}
>> +
>> +			devn =3D devn->parent;
>> +			if (p =3D=3D *try)
>> +				return count;
>> +
>> +			if (devn !=3D NULL && (p - *try) < 2)
>> +				devn =3D NULL;
>> +
>> +			p--;
>> +			if (devn !=3D NULL && *p !=3D '/')
>> +				devn =3D NULL;
>> +		}
>> +
>> +		try++;
>> +	}
>> +
>> +	return -ENOENT;
>> +}
>
> I don't quite like having this device parsing code here. This should
> probably be a generic helper function somewhere under drivers. I woul=
d
> assume other SoCs could use it too?

OK... is it a job for drivers/misc or is there a better idea?

>> +static int omap_panda_netdev_event(struct notifier_block *this,
>> +						unsigned long event, void *ptr)
>> +{
>> +	struct net_device *dev =3D ptr;
>> +	struct sockaddr sa;
>> +	int n;
>> +
>> +	if (event !=3D NETDEV_REGISTER)
>> +		return NOTIFY_DONE;
>> +
>> +	n =3D omap_device_path_need_mac(dev->dev.parent);
>> +	if (n < 0)
>> +		return NOTIFY_DONE;
>> +
>> +	sa.sa_family =3D dev->type;
>> +	omap2_die_id_to_ethernet_mac(sa.sa_data, n);
>> +	dev->netdev_ops->ndo_set_mac_address(dev, &sa);
>> +
>> +	return NOTIFY_DONE;
>> +}
>> +
>> +static struct notifier_block omap_panda_netdev_notifier =3D {
>> +	.notifier_call =3D omap_panda_netdev_event,
>> +	.priority =3D 1,
>> +};
>
> This is a bit similar to platform data callback functions that we are
> trying to get rid of. And as the question "how do we replace platform
> data callback functions" is still open for things like this, few
> questions come to mind that should be discussed:
>
> 1. How is this a better solution to passing the generated mac address=
 in
>     platform data to the driver?

Well, I initially did this over a year ago as a generic way to pass=20
platform data to devices that are appearing through deferred or async=20
probing, like USB bus and SDIO bus.  It was not understood what the goa=
l=20
was by the people looking after those subsystems.

> 2. Is this really how we want to pass the board generated mac address=
es
>     and other dynamically generated data to the drivers that are devi=
ce
>     tree based?

The issue is that both these busses have an async probe, in the case of=
=20
USB stack the maintainer was not interested last year in adding platfor=
m=20
data.  Maybe it changed but that's my understanding.

> 3. What about mac address in board-generic.c when booting panda with
>     device tree?

I don't mind adapting it for that case.

> Also, what happens if the user has set the mac address and you replug=
s the
> cable or device? Do we now overwrite it? Might be worth checking that=
 this
> follows the standard behaviour..

This is only useful for devices that are soldered on your board, and=20
have deterministic "device paths" as is the case with Panda Ethernet an=
d=20
Wlan module that both benefit from this treatment.  If you mean pulling=
=20
the RJ45 cable, it doesn't change anything about the MAC I can confirm.

-Andy

--=20
Andy Green | TI Landing Team Leader
Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  -=20
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
