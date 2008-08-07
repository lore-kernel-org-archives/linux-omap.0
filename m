From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: Re: [PATCH 00/11] OMAP3 CPUidle patches - ver 2
Date: Thu, 07 Aug 2008 12:54:46 +0300
Message-ID: <1218102886.31074.59.camel@kj-ubuntu>
References: <003d01c8db84$fe61fde0$68bf18ac@ent.ti.com>
	 <002f01c8f7c5$0790fea0$LocalHost@wipultra1382>
	 <39938.192.168.10.89.1218028343.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-fb01.nokia.com ([192.100.122.235]:26328 "EHLO
	mgw-fb01.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114AbYHGNRK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Aug 2008 09:17:10 -0400
Received: from mgw-mx09.nokia.com ([192.100.105.134])
	by mgw-fb01.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m77ACf6O020004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-omap@vger.kernel.org>; Thu, 7 Aug 2008 13:12:43 +0300
In-Reply-To: <39938.192.168.10.89.1218028343.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

On ke, 2008-08-06 at 18:42 +0530, ext Rajendra Nayak wrote:
> Hi,
> 
> Re-posting a refreshed version of these patches.

I'm getting this error when trying to apply these patches with 'git-am'
command:

  $ git-am ~/.evolution/mail/local/stage
  Applying Basic cpuidle driver
  fatal: patch fragment without header at line 13: @@ -0,0 +1,245 @@
  Patch failed at 0001.

with manual "patch -p 1 < .dotest/0001" they apply nicely, but it is
very time-consuming to do it manually for each patch.

Do you use normal git-format-patch and git-send-email to format and post
the patches?

Br,
Kalle

> 
> regards
> Rajendra
> 
> > Hi,
> >
> > I am sending an updated patch set for CPUidle which includes all
> > fixes/comments
> > posted on the previous set by Jouni/Richard W/Peter and others.
> >
> > The Following are the fixes
> > 1) Uart clock enable/disable moved out of the context save/restore patch
> > 2) GPIO IRQENABLE save/restore fix from Richard
> > 3) Fixes from Jouni which do the following
> > 	1. Add wkdep between neon and mpu
> > 	2. Add wkdep between per and core
> > 	3. Deny hwsup mode before writing next pwrst state
> > 	4. Make sure that order in idle loop is such that clocks are
> > _really_
> >    		enabled before accessing registers (serial & gpio).
> > 4) Safe state idle fix from Richard
> > 5) Uart smart-force fix from Richard
> > 6) Toggle IO-PAD enable/disable in idle
> >
> > As earlier these patches apply on top of Jouni's workaround patch set
> > ([PATCH 0/6] 34XX: PM: Workarounds to get omap3 to retention 4th.)
> >
> > The following is neccessay even with a minimal config to achieve OFF.
> > $ echo 1 > /sys/power/sleep_while_idle
> > $ echo 1 > /sys/power/clocks_off_while_idle
> >
> > regards,
> > Rajendra
> >
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
