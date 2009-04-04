From: Kalle Valo <kalle.valo@iki.fi>
Subject: controlling CPU speed on N800/N810
Date: Sat, 04 Apr 2009 10:58:40 +0300
Message-ID: <8763hkvoi7.fsf@litku.valot.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:10520 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbZDDH6p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Apr 2009 03:58:45 -0400
Received: by fk-out-0910.google.com with SMTP id 18so565876fkq.5
        for <linux-omap@vger.kernel.org>; Sat, 04 Apr 2009 00:58:42 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I'm about to do some throughput measurements with stlc45xx (the open
wi-fi driver) on Nokia N800. Now I would like see the current CPU
speed. I also liked to change it, because I believe it will have an
affect on throughput.

I tried cpufreq but it wasn't very helpful:

/sys/devices/system/cpu/cpu0/cpufreq# cat cpuinfo_cur_freq 
<unknown>/sys/devices/system/cpu/cpu0/cpufreq# 

Is it possible to change CPU speed in latest linux-omap kernels?

I'm using N800 and omap-2.6.29 branch from linux-omap tree.

-- 
Kalle Valo
