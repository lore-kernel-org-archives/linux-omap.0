From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: Question regarding broadcast timer/cpuidle and /proc/interrupts
Date: Mon, 21 Jan 2013 20:08:11 +0530
Message-ID: <50FD52D3.8010601@ti.com>
References: <50FD4E0C.1010305@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38585 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab3AUOhJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jan 2013 09:37:09 -0500
In-Reply-To: <50FD4E0C.1010305@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-omap@vger.kernel.org, Lists Linaro-dev <linaro-dev@lists.linaro.org>

On Monday 21 January 2013 07:47 PM, Daniel Lezcano wrote:
>
> Hi All,
>
> I have a question regarding the behavior of cpuidle on pandaboard.
>
> 1. cpuidle is enabled
>
> 2. The deep idle states seem to be reach
>
> for i in $(find /sys/devices/system/cpu -name "usage"); do echo "$i :
> $(cat $i)"; done
> /sys/devices/system/cpu/cpu0/cpuidle/state0/usage : 7049
> /sys/devices/system/cpu/cpu0/cpuidle/state1/usage : 17
> /sys/devices/system/cpu/cpu0/cpuidle/state2/usage : 1341
> /sys/devices/system/cpu/cpu1/cpuidle/state0/usage : 6318
> /sys/devices/system/cpu/cpu1/cpuidle/state1/usage : 17
> /sys/devices/system/cpu/cpu1/cpuidle/state2/usage : 1341
>
> 3. Regarding the cpuidle driver code : the "state1" and "state2" are
> coupled states where the broadcast timer is used instead of the local
> timer. I assume this is because they go down when we reach these idle
> states.
>
Thats correct. Local timer are not wakeup capable and hence we switch
to a wakeup capable broadcast timer.

> 4. The content of /proc/interrupts shows no broadcast timer used at all.
>
> ...
> IPI1:          0          0  Timer broadcast interrupts
> ...
>
> Shouldn't be the broadcast timer used sometimes ? or did I miss something ?
>
There might be an issue with status updating. Just look for gptimer1
interrupts. if they are incrementing then, broadcast is being used
but just the status update isn't happening some how.

regards
santosh

