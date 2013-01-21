From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: Question regarding broadcast timer/cpuidle and /proc/interrupts
Date: Mon, 21 Jan 2013 15:39:42 +0100
Message-ID: <50FD532E.2000306@linaro.org>
References: <50FD4E0C.1010305@linaro.org> <50FD52D3.8010601@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:58311 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388Ab3AUOjr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jan 2013 09:39:47 -0500
Received: by mail-la0-f45.google.com with SMTP id er20so724649lab.4
        for <linux-omap@vger.kernel.org>; Mon, 21 Jan 2013 06:39:45 -0800 (PST)
In-Reply-To: <50FD52D3.8010601@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Lists Linaro-dev <linaro-dev@lists.linaro.org>

On 01/21/2013 03:38 PM, Santosh Shilimkar wrote:
> On Monday 21 January 2013 07:47 PM, Daniel Lezcano wrote:
>>
>> Hi All,
>>
>> I have a question regarding the behavior of cpuidle on pandaboard.
>>
>> 1. cpuidle is enabled
>>
>> 2. The deep idle states seem to be reach
>>
>> for i in $(find /sys/devices/system/cpu -name "usage"); do echo "$i =
:
>> $(cat $i)"; done
>> /sys/devices/system/cpu/cpu0/cpuidle/state0/usage : 7049
>> /sys/devices/system/cpu/cpu0/cpuidle/state1/usage : 17
>> /sys/devices/system/cpu/cpu0/cpuidle/state2/usage : 1341
>> /sys/devices/system/cpu/cpu1/cpuidle/state0/usage : 6318
>> /sys/devices/system/cpu/cpu1/cpuidle/state1/usage : 17
>> /sys/devices/system/cpu/cpu1/cpuidle/state2/usage : 1341
>>
>> 3. Regarding the cpuidle driver code : the "state1" and "state2" are
>> coupled states where the broadcast timer is used instead of the loca=
l
>> timer. I assume this is because they go down when we reach these idl=
e
>> states.
>>
> Thats correct. Local timer are not wakeup capable and hence we switch
> to a wakeup capable broadcast timer.
>=20
>> 4. The content of /proc/interrupts shows no broadcast timer used at =
all.
>>
>> ...
>> IPI1:          0          0  Timer broadcast interrupts
>> ...
>>
>> Shouldn't be the broadcast timer used sometimes ? or did I miss
>> something ?
>>
> There might be an issue with status updating. Just look for gptimer1
> interrupts. if they are incrementing then, broadcast is being used
> but just the status update isn't happening some how.

Is it the interrupt 69 ?

 29:        293        395       GIC  twd
 41:          0          0       GIC  l3-dbg-irq
 42:          0          0       GIC  l3-app-irq
 44:          0          0       GIC  DMA
 69:         61          0       GIC  gp_timer
 88:          0          0       GIC  i2c.9
 89:          0          0       GIC  i2c.10
 93:          0          0       GIC  i2c.11
 94:          0          0       GIC  i2c.12
106:         93          0       GIC  OMAP UART2
169:          0          0      PRCM  hwmod_io
IPI0:         0          0  Timer broadcast interrupts
IPI1:      1424       1260  Rescheduling interrupts
IPI2:         0          0  Function call interrupts
IPI3:        81         90  Single function call interrupts
IPI4:         0          0  CPU stop interrupts
Err:          0

>=20
> regards
> santosh
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
