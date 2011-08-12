From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v4 00/15] PM QoS: add a per-device latency constraints class
Date: Fri, 12 Aug 2011 13:56:39 +0200
Message-ID: <CAORVsuVT8RFrE9YWzErp3dy7qeZuJ59upKd8bjDthx_622UM9g@mail.gmail.com>
References: <1313075212-8366-1-git-send-email-j-pihet@ti.com>
	<201108121002.25207.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:62509 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331Ab1HLL4k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Aug 2011 07:56:40 -0400
Received: by qyk38 with SMTP id 38so274921qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 12 Aug 2011 04:56:39 -0700 (PDT)
In-Reply-To: <201108121002.25207.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

Hi Rafael,

2011/8/12 Rafael J. Wysocki <rjw@sisk.pl>:
> On Thursday, August 11, 2011, jean.pihet@newoldbits.com wrote:
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> This patch set is in an RFC state, for review and comments.
>>
=2E..
>>
>>
>> Questions:
>> 1. the user space API is still under discussions on linux-omap and l=
inux-pm MLs,
>> =A0 =A0cf. [1]. The idea is to add a user-space API for the devices =
constratins
>> =A0 =A0PM QoS, using a sysfs entry per device
>>
>> [1] http://marc.info/?l=3Dlinux-omap&m=3D131232344503327&w=3D2
>>
>> ToDo:
>> 1. write Documentation for the new PM QoS class, once the RFC is agr=
eed on
>> 2. validate the constraints framework on OMAP4 HW (done on OMAP3)
>> 3. Need testing on platforms other than OMAP
>> 4. refine the power domains wake-up latency and the cpuidle figures
>> 5. re-visit the OMAP power domains states initialization procedure. =
Currently
>>    the power states that have been changed from the constraints API =
which were
>>    applied before the initialization of the power domains are lost
>>
>>
>> Based on the master branch of the linux-omap git tree (3.0.0-rc7). C=
ompile
>> tested using OMAP and x86 generic defconfigs.
>>
>> Lightly tested on OMAP3 Beagleboard (ES2.x).
>> Need testing on platforms other than OMAP, because of the impact on =
the
>> device insertion/removal in device_pm_add/remove
>
> The patchset looks really good to me, I don't think I have any major
> complaints about this version.
Ok good to hear it! I tried to address all comments and concerns in
this release.

>
> The only thing I'd like to ask at the moment is whether or not the
> compilation of drivers/base/power/qos.c should depend on
> CONFIG_PM_RUNTIME. =A0Do you think it will be used by system suspend =
code on any
> platforms?
I would say it should only depend on CONFIG_PM because the dev PM QoS
API can be used from any kernel code, being runtime PM code or not.
I leave the decision to the PM framework experts.

>
> Also, I'd like to take the final patchset for 3.2,
Ok good!

> but I don't feel
> confident enough about the OMAP patches.
The OMAP patches have been reviewed a few times already and the
comments have been taken into account. Also i has been tested
correctly on OMAP3.

>=A0If you want me to take them too,
> please make sure they are ACKed by the OMAP maintainers.
=46or sure I need the Acks. I guess I now need to annoy OMAP folks abou=
t it ;p
In the case the Acks are not gathered on time the generic patches
could be merged in, then the OMAP generic code. Do you think it is a
viable option?

The only concern I have is about the on-going OMAP PM initialization
clean-up task, cf. ToDo list:
  >> 5. re-visit the OMAP power domains states initialization
procedure. Currently
  >>    the power states that have been changed from the constraints
API which were
  >>    applied before the initialization of the power domains are lost

On the other hand some testing is needed on platforms other than OMAP,
because of the impact on the device insertion/removal in
device_pm_add/remove functions. I tested the SD card insertion/removal
on OMAP3.

>
> Thanks,
> Rafael
>

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
