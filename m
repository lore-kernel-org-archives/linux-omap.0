From: Rob Lee <rob.lee@linaro.org>
Subject: Re: [PATCH v7 1/9] cpuidle: Add common time keeping and irq enabling
Date: Thu, 1 Mar 2012 14:42:32 -0600
Message-ID: <CAMXH7KHn-bLckyXKv3mWM6GY8DQ7yJY9kLteM-xRCFWFTH1Gew@mail.gmail.com>
References: <1330562578-3410-1-git-send-email-rob.lee@linaro.org>
	<1330562578-3410-2-git-send-email-rob.lee@linaro.org>
	<4F4EF7FC.9040403@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46872 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754985Ab2CAUmf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Mar 2012 15:42:35 -0500
Received: by iagz16 with SMTP id z16so1296127iag.19
        for <linux-omap@vger.kernel.org>; Thu, 01 Mar 2012 12:42:34 -0800 (PST)
In-Reply-To: <4F4EF7FC.9040403@linux.vnet.ibm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Cc: rjw@sisk.pl, len.brown@intel.com, khilman@ti.com, robherring2@gmail.com, Baohua.Song@csr.com, amit.kucheria@linaro.org, nicolas.ferre@atmel.com, linux@maxim.org.za, kgene.kim@samsung.com, amit.kachhap@linaro.org, magnus.damm@gmail.com, nsekhar@ti.com, daniel.lezcano@linaro.org, mturquette@linaro.org, vincent.guittot@linaro.org, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, broonie@opensource.wolfsonmicro.com, nicolas.pitre@linaro.org, linux@arm.linux.org.uk, jean.pihet@newoldbits.com, venki@google.com, ccross@google.com, g.trinabh@gmail.com, kernel@wantstofly.org, lethal@linux-sh.org, jon-hunter@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org

Hello Deepthi,

On Wed, Feb 29, 2012 at 10:15 PM, Deepthi Dharwar
<deepthi@linux.vnet.ibm.com> wrote:
> Hi Rob,
>
> On 03/01/2012 06:12 AM, Robert Lee wrote:
>
>> Make necessary changes to implement time keeping and irq enabling
>> in the core cpuidle code. =A0This will allow the removal of these
>> functionalities from various platform cpuidle implementations whose
>> timekeeping and irq enabling follows the form in this common code.
>
>
> The generic cpuidle changes look good, but is there a reason as
> to why these changes are enabled only for ARM and not other
> archs ?
>

Besides ARM, this patchset also enables some of this new consolidation
functionality on arch/SH and for archs that use the
CONFIG_ARCH_HAS_CPU_RELAX (maybe x86 uses this?).

=46or the powerpc P-series, it could probably could be modified to use
the consolidated timekeeping but I didn't feel comfortable making that
change myself for a couple of reasons.  First, the common wrapper also
includes the local_irq_enable() call, but the p-series cpuidle code
doesn't include this call, as instead, it relies on the
local_irq_enable() call in the cpu_idle() function in
arch/powerpc/kernel/idle.c.  Is it OK to remove this
local_irq_enable() once the wrapper is used?  Second, is there any
special coordination needed with the timekeeping functions and the
mfspr() calls?

Looking at the intel and acpi cpuidle implementations, their current
organization does seem to be able to use the common time keeping / irq
enabling wrapper.  Upon first glance, it appears that there are
special timer/timekeeping requirements for x86 that aren't required by
other platforms.  But that may not be correct.

If you look back at v4 of this patch series, you'll see an attempt at
a common timekeeping that could be used by x86 and acpi , but it
causes other compromises that to me aren't worth the extra gain from a
100% common timekeeping / irq enable solution.  I requested
feedback/opinions on this issue after v4 but didn't hear anything
about changes made to the intel or acpi implementations.  So I
continued on with the common wrapper direction from v3 when making v5.

Ultimately, even if the consolidated code only can be used by most and
not all arch or platform cpuidle implementations, it still reduces
some platform cpuidle fragmentation and duplicated code and hopefully
improves the maintainability of the core cpuidle.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
