From: Nishanth Menon <nm@ti.com>
Subject: OMAP4: suspend-resume broken when CPU_IDLE is disabled
Date: Thu, 11 Sep 2014 14:37:17 -0500
Message-ID: <5411F9ED.3000205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35600 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752346AbaIKThX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Sep 2014 15:37:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Paul Walmsley <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, tero kristo <t-kristo@ti.com>

Hi,


This one is a little weird.. Thought I'd share before digging in case
someone knew about this..

test scenario: use internal wakeup source like gptimer[1].

git checkout (tag)

make distclean
make omap2plus_defconfig
sed -i -e "s/CONFIG_CPU_IDLE=y/# CONFIG_CPU_IDLE is not set/g" .config
make oldconfig
make zImage dtbs

3.17-rc4: (hangs on resume) (omap2plus CPUIDLE)
pandaboard-es:   http://paste.ubuntu.org.cn/1509229
pandaboard-vanilla:  http://paste.ubuntu.org.cn/1509230

Purely with omap2plus_defconfig: (omap2plus no modification - works)
pandaboard-es:  http://paste.ubuntu.org.cn/1509613
pandaboard-vanilla: http://paste.ubuntu.org.cn/1509614

v3.16:
pandaboard-es:  http://paste.ubuntu.org.cn/1509291
pandaboard-vanilla: http://paste.ubuntu.org.cn/1509292
TOTAL = 2 boards, Booted Boards = 0, No Boot boards = 2


v3.16-rc1: (first time CONFIG_CPU_IDLE was enabled by default in
omapplus_defconfig):
v3.15:
same behavior.

Have'nt stepped all the way to previous tags.

I believe I see (I have to reconfirm) connecting once with JTAG while
in suspend and letting the CPUs run lets the further runs work fine..

Did anyone see similar behavior or able to reproduce the behavior (and
not just me)?

[1] wget -O a.patch
'https://github.com/nmenon/linux-2.6-playground/commit/92e5e7407aa707ad6be8ae3b5bf21cfc741daab6.patch'
; git am a.patch

-- 
Regards,
Nishanth Menon
