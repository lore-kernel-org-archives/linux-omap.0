From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 00/11] OMAP3 CPUidle patches - ver 2
Date: Wed, 6 Aug 2008 18:42:23 +0530 (IST)
Message-ID: <39938.192.168.10.89.1218028343.squirrel@dbdmail.itg.ti.com>
References: <003d01c8db84$fe61fde0$68bf18ac@ent.ti.com>
    <002f01c8f7c5$0790fea0$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:51702 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752689AbYHFNMa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Aug 2008 09:12:30 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by calf.ext.ti.com (8.13.7/8.13.7) with ESMTP id m76DCOjS016481
	for <linux-omap@vger.kernel.org>; Wed, 6 Aug 2008 08:12:29 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id m76DCLrl021816
	for <linux-omap@vger.kernel.org>; Wed, 6 Aug 2008 08:12:23 -0500 (CDT)
In-Reply-To: <002f01c8f7c5$0790fea0$LocalHost@wipultra1382>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

Re-posting a refreshed version of these patches.

regards
Rajendra

> Hi,
>
> I am sending an updated patch set for CPUidle which includes all
> fixes/comments
> posted on the previous set by Jouni/Richard W/Peter and others.
>
> The Following are the fixes
> 1) Uart clock enable/disable moved out of the context save/restore patch
> 2) GPIO IRQENABLE save/restore fix from Richard
> 3) Fixes from Jouni which do the following
> 	1. Add wkdep between neon and mpu
> 	2. Add wkdep between per and core
> 	3. Deny hwsup mode before writing next pwrst state
> 	4. Make sure that order in idle loop is such that clocks are
> _really_
>    		enabled before accessing registers (serial & gpio).
> 4) Safe state idle fix from Richard
> 5) Uart smart-force fix from Richard
> 6) Toggle IO-PAD enable/disable in idle
>
> As earlier these patches apply on top of Jouni's workaround patch set
> ([PATCH 0/6] 34XX: PM: Workarounds to get omap3 to retention 4th.)
>
> The following is neccessay even with a minimal config to achieve OFF.
> $ echo 1 > /sys/power/sleep_while_idle
> $ echo 1 > /sys/power/clocks_off_while_idle
>
> regards,
> Rajendra
>


