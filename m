From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 01/11] PM: add a per-device wake-up latency constraints plist
Date: Wed, 20 Jul 2011 10:57:59 +0200
Message-ID: <CAORVsuW0JkAv=Oqk62JTR4Ad63xP8J7mbso_g8cN4N4w-Jai5g@mail.gmail.com>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
	<1309446685-17502-2-git-send-email-j-pihet@ti.com>
	<201107022139.51579.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:47264 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421Ab1GTI6A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jul 2011 04:58:00 -0400
Received: by qyk9 with SMTP id 9so5531qyk.19
        for <linux-omap@vger.kernel.org>; Wed, 20 Jul 2011 01:57:59 -0700 (PDT)
In-Reply-To: <201107022139.51579.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, markgross@thegnar.org, Jean Pihet <j-pihet@ti.com>

Hi Rafael,

2011/7/2 Rafael J. Wysocki <rjw@sisk.pl>:
> Hi,
>
> On Thursday, June 30, 2011, jean.pihet@newoldbits.com wrote:
=2E..

>> @@ -462,6 +463,7 @@ struct dev_pm_info {
>> =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 accounting_timestamp;
>> =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*subsys_data=
; =A0/* Owned by the subsystem. */
>> =A0#endif
>> + =A0 =A0 struct plist_head =A0 =A0 =A0 wakeup_lat_plist_head;
>> =A0};
>
> Please use a better name. =A0I mean, relly, the type implies that thi=
s is a
> plist head, so that doesn't need to appear in the field name too. =A0=
Also,
> the name is confusing, because "wakeup" may mean a couple of differen=
t things
> and it's not entirely clear what "lat" stands for. =A0So, I'd prefer =
something
> like
>
> + =A0 =A0 =A0 struct plist_head =A0 =A0 =A0 latency_constraints;
>
> or perhaps you can invent something even better.
I am OK with your suggestion and I will update the naming.

>
>>
>> =A0extern void update_pm_runtime_accounting(struct device *dev);
>>
>
> Thanks,
> Rafael

Thanks,
Jean

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
