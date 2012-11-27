From: Andy Green <andy.green@linaro.org>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Wed, 28 Nov 2012 01:55:09 +0800
Message-ID: <50B4FE7D.9030505@linaro.org>
References: <CACVXFVNkp0+WmTyG2+YMjTvzCRi3sQZKmG6sG8diqZZj-hwg6g@mail.gmail.com> <Pine.LNX.4.44L0.1211271119380.1489-100000@iolanthe.rowland.org> <CACVXFVM_hPJcNSWp0qCVpexetDBcKgXZRCzR293KAYtK_fpOOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:50990 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756132Ab2K0RzS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Nov 2012 12:55:18 -0500
In-Reply-To: <CACVXFVM_hPJcNSWp0qCVpexetDBcKgXZRCzR293KAYtK_fpOOg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <balbi@ti.com>, Greg KH <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, keshava_mgowda@ti.com, USB list <linux-usb@vger.kernel.org>, rogerq@ti.com

On 11/28/2012 01:22 AM, the mail apparently from Ming Lei included:
> On Wed, Nov 28, 2012 at 12:30 AM, Alan Stern <stern@rowland.harvard.e=
du> wrote:
>> On Tue, 27 Nov 2012, Ming Lei wrote:
>>
>>> IMO, all matches mean the devices are inside the ehci-omap bus, so
>>> the direct/simple way is to enable/disable the regulators in the pr=
obe() and
>>> remove() of ehci-omap controller driver.
>>
>> When this discussion started, Felipe argued against such an approach=
=2E
>> He pointed out that the same chip could be used in other platforms, =
and
>> then the code added to ehci-omap.c would have to be duplicated in
>> several other places.
>
>  From Andy's implementation, the 'general' code is to enable/disable
> the regulators(patch 3/5), I am wondering if it is general enough, so=
 the
> 'duplicated' code are just several lines of regulator_enable/regulato=
r_disable,
> which should be implemented in many platform drivers.

=46air enough; my main interest was in the device path side when writin=
g=20
the patches.  I stuck enough in one place to confirm the series works o=
n=20
Panda case for power control.  So long as it doesn't get obsessed with=20
just regulators some common implementation that seems to be discussed=20
will be better.

(BTW let me take this opportunity to thank you for your great=20
urbs-in-flight limiting patch on smsc95xx a while back)

> Also from my intuition, power domain should be involved in the proble=
m,
> because these hard-wired and self-powered USB devices should have
> its own power domains, and the ehci-omap driver may enable/disable
> these power domains before adding the bus.

I don't know enough to have an opinion, but the arrangement on Panda is=
=20
literally a linear regulator is being controlled by a gpio, which fits=20
into struct regulator model.  What else would a power domain for that=20
buy us?

>> We should have a more generic solution in a more central location, l=
ike
>> the device core.
>>
>> For example, each struct platform_device could have a list of resour=
ces
>> to be enabled when the device is bound to a driver and disabled when
>> the device is unbound.  Such a list could include regulators, clocks=
,
>> and whatever else people can invent.
>>
>> In this case, when it is created the ehci-omap.0 platform device cou=
ld
>> get an entry pointing to the LAN95xx's regulator.  Then the regulato=
r
>> would automatically be turned on when the platform device is bound t=
o
>> the ehci-omap driver.
>
> The LAN95xx's regulator is still platform dependent(even for same LAN=
95xx
> USB devices on different platforms(omap, tegra, ..)) , so I am wonder=
ing
> why we don't enable it directly in probe() of ehci-omap.0 platform de=
vice?

I didn't get this point, ehci-omap doesn't help if it's non-omap platfo=
rm.

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
