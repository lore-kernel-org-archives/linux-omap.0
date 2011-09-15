From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 0/8] PM QoS: implement the OMAP low level constraints
 management code
Date: Thu, 15 Sep 2011 10:57:49 +0200
Message-ID: <CAORVsuXfXbPqrGY3KXJ_azn4c6NfSNB1+1LET6w+Omd8i-jXyA@mail.gmail.com>
References: <1314969204-21704-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f45.google.com ([209.85.212.45]:50608 "EHLO
	mail-vw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194Ab1IOI5u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Sep 2011 04:57:50 -0400
Received: by vws17 with SMTP id 17so4297215vws.4
        for <linux-omap@vger.kernel.org>; Thu, 15 Sep 2011 01:57:49 -0700 (PDT)
In-Reply-To: <1314969204-21704-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.co>
Cc: Jean Pihet <j-pihet@ti.com>

Paul, Rafael, Kevin,

Ping on this patch set.
IIUC the intention is to have this series merged in 3.2, is that correc=
t?

Regards,
Jean

On Fri, Sep 2, 2011 at 3:13 PM, Jean Pihet <jean.pihet@newoldbits.com> =
wrote:
> . create a PM layer plugin for per-device constraints, compiled under
> =A0CONFIG_OMAP_PM_CONSTRAINTS=3Dy
> . implement the devices wake-up latency constraints using the global
> =A0device PM QoS notification handler which applies the constraints t=
o the
> =A0underlying layer
> . implement the low level code which controls the power domains next =
power
> =A0states, through the hwmod and pwrdm layers
> . add cpuidle and power domains wake-up latency figures for OMAP3, cf=
=2E [1]
> =A0for the details on where the numbers are coming from
> . cpuidle is a CPU centric framework so it decides the MPU next power=
 state
> =A0based on the MPU exit_latency and target_residency figures. The re=
st of
> =A0the power domains get their next power state programmed from the d=
evices
> =A0PM QoS framework, via the devices wake-up latency constraints.
> . convert the OMAP I2C driver to the PM QoS API for MPU latency const=
raints
>
> ToDo:
> 1. validate the constraints framework on OMAP4 HW (done on OMAP3)
> 2. re-visit the OMAP power domains states initialization procedure. C=
urrently
> =A0 the power states that have been changed from the constraints API =
which were
> =A0 applied before the initialization of the power domains are lost
>
>
> Based on the pm-qos branch of the linux-pm git tree (3.1.0-rc3), cf. =
[2].
>
> Tested on OMAP3 Beagleboard (ES2.x) with constraints on MPU, CORE, PE=
R in
> RETention and OFF modes.
>
> [1] http://www.omappedia.org/wiki/Power_Management_Device_Latencies_M=
easurement
> [2] git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
>
>
> Jean Pihet (8):
> =A0OMAP: convert I2C driver to PM QoS for latency constraints
> =A0OMAP: PM: create a PM layer plugin for per-device constraints
> =A0OMAP2+: powerdomain: control power domains next state
> =A0OMAP3: powerdomain data: add wake-up latency figures
> =A0OMAP2+: omap_hwmod: manage the wake-up latency constraints
> =A0OMAP: PM CONSTRAINTS: implement the devices wake-up latency
> =A0 =A0constraints
> =A0OMAP2+: cpuidle only influences the MPU state
> =A0OMAP3: update cpuidle latency and threshold figures
>
> =A0arch/arm/mach-omap2/cpuidle34xx.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 56 =
++---
> =A0arch/arm/mach-omap2/omap_hwmod.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 26 =
++-
> =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 17 ++-
> =A0arch/arm/mach-omap2/powerdomain.c =A0 =A0 =A0 =A0 =A0 =A0| =A0190 =
++++++++++++++
> =A0arch/arm/mach-omap2/powerdomain.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 33 =
+++-
> =A0arch/arm/mach-omap2/powerdomains3xxx_data.c =A0| =A0 78 ++++++
> =A0arch/arm/plat-omap/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A07 +
> =A0arch/arm/plat-omap/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A01 +
> =A0arch/arm/plat-omap/i2c.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 20 --
> =A0arch/arm/plat-omap/include/plat/omap-pm.h =A0 =A0| =A0128 --------=
--
> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h | =A0 =A02 +
> =A0arch/arm/plat-omap/omap-pm-constraints.c =A0 =A0 | =A0350 ++++++++=
++++++++++++++++++
> =A0arch/arm/plat-omap/omap-pm-noop.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 89 =
-------
> =A0drivers/i2c/busses/i2c-omap.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 31 ++-
> =A014 files changed, 737 insertions(+), 291 deletions(-)
> =A0create mode 100644 arch/arm/plat-omap/omap-pm-constraints.c
>
> --
> 1.7.4.1
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
