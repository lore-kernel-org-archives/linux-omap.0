From: Barry Song <21cnbao@gmail.com>
Subject: Is Pandaboard cpuhotplug working stably?
Date: Wed, 21 Dec 2011 17:23:48 +0800
Message-ID: <CAGsJ_4ydbMaS0DD6+j1m9tdCTCzw3TGELcY=KotupvvMMK1YOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57304 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495Ab1LUJYK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Dec 2011 04:24:10 -0500
Received: by eaad14 with SMTP id d14so1008368eaa.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Dec 2011 01:24:09 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, peiyu.li@csr.com, yongsheng.liu@csr.com, linux-arm-kernel@lists.infradead.org, linaro-dev <linaro-dev@lists.linaro.org>

Hi guys,
i tried cpuhotplug on pandaboard for both
Pandroid_Froyo_L27.8.2_release_pkg and Linaro 11.11. It has failed to
work stably.
On Pandroid_Froyo_L27.8.2_release_pkg, unplugging cpu1 works well:
# echo 0 > /sys/devices/system/cpu/cpu1/online
CPU1: shutdown

if i enable the cpu1 again by "echo 1 >
/sys/devices/system/cpu/cpu1/online", the system will restore to 3
random status: hang, normal, panic.

Using  Linaro 11.11 release, "echo 0 >
/sys/devices/system/cpu/cpu1/online" will make system hang and the
whole system will not be able to reset by pressing reset key, the only
way to reset system is pulling out AV power.

i am sorry i can't get more time to debug and find more clues. just
want to ask people whether this is a version the cpuhotplug works
normal on?

Thanks
barry
