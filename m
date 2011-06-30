From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [linux-pm] [RFC/PATCH 0/9] PM QoS: add a per-device wake-up
 latency constraint class
Date: Thu, 30 Jun 2011 17:07:34 +0200
Message-ID: <BANLkTi=9f0yQHSB3sVdwHsRSOgUZYQnuBQ@mail.gmail.com>
References: <1308926286-30445-1-git-send-email-j-pihet@ti.com>
	<20110627134019.GA14826@gvim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:54338 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190Ab1F3PHg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jun 2011 11:07:36 -0400
Received: by qwk3 with SMTP id 3so1151818qwk.19
        for <linux-omap@vger.kernel.org>; Thu, 30 Jun 2011 08:07:36 -0700 (PDT)
In-Reply-To: <20110627134019.GA14826@gvim.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: markgross@thegnar.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

Hi Mark,

On Mon, Jun 27, 2011 at 3:40 PM, mark gross <markgross@thegnar.org> wro=
te:
> On Fri, Jun 24, 2011 at 04:37:57PM +0200, jean.pihet@newoldbits.com w=
rote:
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> This patch set is in an RFC state, for review and comments.
>>
>> In order to implement the new class in PM QoS the following changes
>> have been made:
>>
>> 1. Add a new PM QoS class for device wake-up constraints
>> (PM_QOS_DEV_WAKEUP_LATENCY). =A0Due to the per-device nature of the =
new
>> class the constraints lists are stored inside the device dev_pm_info
>> struct instead of the internal per-class constraints lists. =A0The n=
ew
>> class is only available from kernel drivers and so is not exported t=
o
>> user space.
>
> I have not looked at the patch yet but, this reads like "add a
> constraint class per LDM device in the current os" =A0I assume it wou=
ld
> add and destroy them with driver load / unloads. =A0I wonder how that
> would work in practice. =A0Probubly need an notifier or a silent fail=
ure
> for constraint dependents =A0with stale refs to the device.
I have added a notification from the device PM framework to PM QoS, in
order to support the dynamic insertion and removal of the devices.
This code is in RFC state (currently untested with dynamic device
insertion and removal), for comments and review.

>
> Historically, I had initially implemented pm_qos to support dynamic
> creation of constraint classes. =A0But, the feedback I got on that wa=
s
> that "we can't trust driver writers" so lets not enable that.
The drivers only need to care about allocating a constraint request
and calling the PM QoS API. Cf. PATCH 02/11 for examples of the calls.

> Perhaps
> keeping such constraints not exposed to user mode gets around the
> objection we had back then.

>
>>
>> 2. Make the pm_qos_add_request API more generic by using a struct
>> pm_qos_parameters parameter. This allows easy extension in the futur=
e.
>>
>> 3. Upon a change of the strongest constraint in the
>> PM_QOS_DEV_WAKEUP_LATENCY class a notification chain mechanism is us=
ed
>
> strongest constraint? =A0Do you mean the aggregated constraint?
Yes. The 'strongest' constraint is the one that needs to be notified
to the low level code.

>
>> to take action on the system. This is the proposed way to have PM Qo=
S
>> and the platform dependant code to interact with each other, cf. 4
>> below. =A0The notification mechanism now passes the constraint reque=
st
>> struct ptr in order for the notifier callback to have access to the
>> full set of constraint data, e.g. the struct device ptr.
>>
>> 4. cpuidle interaction with the OMAP3 cpuidle handler
>> Since cpuidle is a CPU centric framework it decides the MPU next pow=
er
>> state based on the MPU exit_latency and target_residency figures.
>>
>> The rest of the power domains get their next power state programmed
>> from the PM_QOS_DEV_WAKEUP_LATENCY class of the PM QoS framework, vi=
a
>> the device wake-up latency constraints.
>>
>> Note: the exit_latency and target_residency figures of the MPU inclu=
de
>> the MPU itself and the peripherals needed for the MPU to execute
>> instructions (e.g. main memory, caches, IRQ controller, MMU etc).
>> Some of those peripherals can belong to other power domains than the
>> MPU subsystem and so the corresponding latencies must be included in
>> this figure.
>>
>> 5. Update the pm_qos_add_request callers to the generic API
>>
>> 6. Minor clean-ups and rename of struct fields
>>
>> Questions:
>> 1. How to retrieve the device ptr from a given device driver in orde=
r
>> to add a constraint on it?
> put the pm_qos constraint class data into the LDM so all devices
> implicitly have a constraint class associated with each is my first
> thought. =A0Of course you still have the problem of one driver gettin=
g the
> handle to the constraint class of some other driver. =A0hmmm that is =
a
> messy problem.
Indeed. OMAP code has calls such as 'omap2_get_mpuss_device' which
return the MPU dev.

>
> Might not be a popular idea...
>
> I'll look at the patch details and have more thoughts on this soon.
OK, thank you for the reply.

The patch set has been updated to v2, submission coming soon.

Regards,
Jean

>
> --mark
>> 2. The device struct has been extended with the power domain
>> information. Can this be used to apply the constraints on power
>> domains, as proposed by [1]?
>>
>> On-going developments, patches in preparation:
>> 1. write Documentation for the new PM QoS class
>> 2. validate the constraints framework on OMAP3&4
>> 3. refine the power domains wake-up latency and the cpuidle figures
>>
>> [1] http://marc.info/?l=3Dlinux-omap&m=3D130451613408148&w=3D2
>>
>> Based on the master branch of the linux-omap git tree (3.0.0-rc3). C=
ompile tested only using OMAP and x86 generic defconfigs.
>>
>>
>> Jean Pihet (8):
>> =A0 PM: add a per-device wake-up latency constraints plist
>> =A0 PM: extend PM QoS with per-device wake-up constraints
>> =A0 OMAP PM: create a PM layer plugin for per-device constraints
>> =A0 OMAP2+: powerdomain: control power domains next state
>> =A0 OMAP3: powerdomain data: add wake-up latency figures
>> =A0 OMAP2+: omap_hwmod: manage the wake-up latency constraints
>> =A0 OMAP: PM CONSTRAINTS: implement the devices wake-up latency
>> =A0 =A0 constraints
>> =A0 OMAP2+: cpuidle only influences the MPU state
>>
>> Vishwanath BS (1):
>> =A0 OMAP4: powerdomain data: add wake-up latency figures
>>
>> =A0arch/arm/mach-omap2/cpuidle34xx.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 42=
 +---
>> =A0arch/arm/mach-omap2/omap_hwmod.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 26=
 ++-
>> =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 17 ++-
>> =A0arch/arm/mach-omap2/powerdomain.c =A0 =A0 =A0 =A0 =A0 =A0| =A0187=
 ++++++++++++++
>> =A0arch/arm/mach-omap2/powerdomain.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 33=
 +++-
>> =A0arch/arm/mach-omap2/powerdomains3xxx_data.c =A0| =A0 77 ++++++
>> =A0arch/arm/mach-omap2/powerdomains44xx_data.c =A0| =A0 85 +++++++
>> =A0arch/arm/plat-omap/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A07 +
>> =A0arch/arm/plat-omap/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A01 +
>> =A0arch/arm/plat-omap/i2c.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 20 --
>> =A0arch/arm/plat-omap/include/plat/omap-pm.h =A0 =A0| =A0128 -------=
---
>> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h | =A0 =A02 +
>> =A0arch/arm/plat-omap/omap-pm-constraints.c =A0 =A0 | =A0344 +++++++=
+++++++++++++++++++
>> =A0arch/arm/plat-omap/omap-pm-noop.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 89=
 -------
>> =A0drivers/base/power/main.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A01 +
>> =A0drivers/i2c/busses/i2c-omap.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 35 ++-
>> =A0drivers/media/video/via-camera.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
5 +-
>> =A0drivers/net/e1000e/netdev.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A09 +-
>> =A0drivers/net/wireless/ipw2x00/ipw2100.c =A0 =A0 =A0 | =A0 =A06 +-
>> =A0include/linux/pm.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A02 +
>> =A0include/linux/pm_qos_params.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 40 ++--
>> =A0kernel/pm_qos_params.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0142 ++++++-----
>> =A0sound/core/pcm_native.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A08 +-
>> =A023 files changed, 939 insertions(+), 367 deletions(-)
>> =A0create mode 100644 arch/arm/plat-omap/omap-pm-constraints.c
>>
>> --
>> 1.7.4.1
>>
>> _______________________________________________
>> linux-pm mailing list
>> linux-pm@lists.linux-foundation.org
>> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
