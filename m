From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
Date: Fri, 27 Aug 2010 15:04:00 +0200
Message-ID: <AANLkTi=cktg9PM-AmyCEjQRJf0NA9CAmnzcjYpq_NSzJ@mail.gmail.com>
References: <1282946913-26659-1-git-send-email-vishwanath.sripathy@linaro.org>
	<4C7792AD.80804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52187 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212Ab0H0NEB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 09:04:01 -0400
Received: by qwh6 with SMTP id 6so2702543qwh.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Aug 2010 06:04:00 -0700 (PDT)
In-Reply-To: <4C7792AD.80804@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "vishwanath.sripathy@linaro.org" <vishwanath.sripathy@linaro.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, Jean Pihet <jean.pihet@swing.be>, Nicole Chalhoub <n-chalhoub@ti.com>, Vincent Bour <v-bour@ti.com>

Benoit,

On Fri, Aug 27, 2010 at 12:25 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
>> This patch has instrumentation code for measuring latencies for
>> various CPUIdle C states for OMAP. Idea here is to capture the
>> timestamp at various phases of CPU Idle and then compute the sw
>> latency for various c states. For OMAP, 32k clock is chosen as
>> reference clock this as is an always on clock. wkup domain memory
>> (scratchpad memory) is used for storing timestamps. One can see the
>> worstcase latencies in below sysfs entries (after enabling
>> CONFIG_CPU_IDLE_PROF
>> in .config). This information can be used to correctly configure cpu idle
>> latencies for various C states after adding HW latencies for each of
>> these sw latencies.
>> /sys/devices/system/cpu/cpu0/cpuidle/state<n>/actual_latency
>> /sys/devices/system/cpu/cpu0/cpuidle/state<n>/sleep_latency
>> /sys/devices/system/cpu/cpu0/cpuidle/state<n>/wkup_latency
>
> FYI, Jean is currently working on using standard Linux probes in order to
> instrument CPUIdle / CPUfreq. I'm not sure it is doable, but it might better
> to use standard method to do that instead of purely OMAP3 specific stuff.
> This code will not scale easily on OMAP4.
The proposed code looks OK to me since it is exporting the cpuidle
latency figures through the generic cpuidle driver (in
drivers/cpuidle/sysfs.c, via
/sys/devices/system/cpu/cpu0/cpuidle/state<n>/).
Once that code gets approved I can (and will) add some trace points in
it, so that all PM related events can be traced vs time.


>
> Do you have a dump of the latency you measured do far?

Jean
