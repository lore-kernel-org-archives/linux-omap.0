From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Question regarding broadcast timer/cpuidle and /proc/interrupts
Date: Mon, 21 Jan 2013 15:17:48 +0100
Message-ID: <50FD4E0C.1010305@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:47685 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866Ab3AUOR5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jan 2013 09:17:57 -0500
Received: by mail-la0-f43.google.com with SMTP id ed20so1660215lab.2
        for <linux-omap@vger.kernel.org>; Mon, 21 Jan 2013 06:17:56 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Lists Linaro-dev <linaro-dev@lists.linaro.org>


Hi All,

I have a question regarding the behavior of cpuidle on pandaboard.

1. cpuidle is enabled

2. The deep idle states seem to be reach

for i in $(find /sys/devices/system/cpu -name "usage"); do echo "$i :
$(cat $i)"; done
/sys/devices/system/cpu/cpu0/cpuidle/state0/usage : 7049
/sys/devices/system/cpu/cpu0/cpuidle/state1/usage : 17
/sys/devices/system/cpu/cpu0/cpuidle/state2/usage : 1341
/sys/devices/system/cpu/cpu1/cpuidle/state0/usage : 6318
/sys/devices/system/cpu/cpu1/cpuidle/state1/usage : 17
/sys/devices/system/cpu/cpu1/cpuidle/state2/usage : 1341

3. Regarding the cpuidle driver code : the "state1" and "state2" are
coupled states where the broadcast timer is used instead of the local
timer. I assume this is because they go down when we reach these idle
states.

4. The content of /proc/interrupts shows no broadcast timer used at all=
=2E

=2E..
IPI1:          0          0  Timer broadcast interrupts
=2E..

Shouldn't be the broadcast timer used sometimes ? or did I miss somethi=
ng ?

Thanks.

  -- Daniel


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
