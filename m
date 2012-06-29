From: Andy Green <andy.green@linaro.org>
Subject: Re: [PATCH 2/3] OMAP2+ devices add mac address allocation register
 api
Date: Fri, 29 Jun 2012 17:03:20 +0800
Message-ID: <4FED6F58.3090506@linaro.org>
References: <20120629054404.11091.31289.stgit@build.warmcat.com> <20120629055516.11091.82899.stgit@build.warmcat.com> <201206290851.47054.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:35250 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891Ab2F2JDa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jun 2012 05:03:30 -0400
In-Reply-To: <201206290851.47054.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.pitre@linaro.org, s-jan@ti.com, patches@linaro.org, tony@atomide.com, rostedt@goodmis.org

On 06/29/12 16:51, the mail apparently from Arnd Bergmann included:
> On Friday 29 June 2012, Andy Green wrote:
>> +static int omap_panda_netdev_event(struct notifier_block *this,
>> +                                               unsigned long event,=
 void *ptr)
>> +{
>> +       struct net_device *dev =3D ptr;
>> +       struct sockaddr sa;
>> +       int n;
>> +
>> +       if (event !=3D NETDEV_REGISTER)
>> +               return NOTIFY_DONE;
>> +
>> +       n =3D omap_device_path_need_mac(dev->dev.parent);
>> +       if (n < 0)
>> +               return NOTIFY_DONE;
>> +
>> +       sa.sa_family =3D dev->type;
>> +       omap2_die_id_to_ethernet_mac(sa.sa_data, n);
>> +       dev->netdev_ops->ndo_set_mac_address(dev, &sa);
>> +
>> +       return NOTIFY_DONE;
>> +}
>> +
>> +static struct notifier_block omap_panda_netdev_notifier =3D {
>> +       .notifier_call =3D omap_panda_netdev_event,
>> +       .priority =3D 1,
>> +};
>> +
>> +int omap_register_mac_device_fixup_paths(const char * const *paths,=
 int count)
>> +{
>> +       mac_device_fixup_paths =3D paths;
>> +       count_mac_device_fixup_paths =3D count;
>> +
>> +       return register_netdevice_notifier(&omap_panda_netdev_notifi=
er);
>> +}
>
> The omap_panda_netdev_event and omap_panda_netdev_notifier symbols sh=
ould probably
> lose the "panda_" part of their names, because they are now located i=
n a common
> file and are not panda specific any more.

Good point thanks, I'll sort it out after waiting for any more comments=
=2E

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
