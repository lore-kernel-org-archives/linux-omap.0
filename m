From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 00/11] OMAP3 CPUidle patches - ver 2
Date: Fri, 18 Jul 2008 18:48:33 +0530
Message-ID: <001201c8e8d8$c80f8760$68bf18ac@ent.ti.com>
References: <003d01c8db84$fe61fde0$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:49487 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752871AbYGRNSm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jul 2008 09:18:42 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by calf.ext.ti.com (8.13.7/8.13.7) with ESMTP id m6IDIZki003645
	for <linux-omap@vger.kernel.org>; Fri, 18 Jul 2008 08:18:41 -0500
Received: from a0393137pc (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id m6IDIXo9006819
	for <linux-omap@vger.kernel.org>; Fri, 18 Jul 2008 18:48:34 +0530 (IST)
In-Reply-To: <003d01c8db84$fe61fde0$68bf18ac@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I am sending an updated patch set for CPUidle which includes all fixes/comments 
posted on the previous set by Jouni/Richard W/Peter and others.

The Following are the fixes
1) Uart clock enable/disable moved out of the context save/restore patch
2) GPIO IRQENABLE save/restore fix from Richard
3) Fixes from Jouni which do the following
	1. Add wkdep between neon and mpu
	2. Add wkdep between per and core
	3. Deny hwsup mode before writing next pwrst state
	4. Make sure that order in idle loop is such that clocks are _really_
   		enabled before accessing registers (serial & gpio).
4) Safe state idle fix from Richard
5) Uart smart-force fix from Richard
6) Toggle IO-PAD enable/disable in idle

As earlier these patches apply on top of Jouni's workaround patch set 
([PATCH 0/6] 34XX: PM: Workarounds to get omap3 to retention 4th.) 

The following is neccessay even with a minimal config to achieve OFF.
$ echo 1 > /sys/power/sleep_while_idle
$ echo 1 > /sys/power/clocks_off_while_idle

regards,
Rajendra

