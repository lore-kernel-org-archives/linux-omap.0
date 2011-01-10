From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v8 0/11] dmtimer adaptation to platform_driver
Date: Mon, 10 Jan 2011 16:45:23 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0373E1D913@dbde02.ent.ti.com>
References: <1294228127-11549-1-git-send-email-tarun.kanti@ti.com>
	<87bp3uu9lx.fsf@ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0373D2F357@dbde02.ent.ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0373D2F5FA@dbde02.ent.ti.com>
 <87pqsaypdu.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58477 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753438Ab1AJLPc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jan 2011 06:15:32 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p0ABFSDK027838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 10 Jan 2011 05:15:31 -0600
In-Reply-To: <87pqsaypdu.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin,
> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Thursday, January 06, 2011 9:51 PM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH v8 0/11] dmtimer adaptation to platform_driver
> 
> Hi Tarun,
> 
> "DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:
> 
> >> >
> >> > Also, testing with PM on 34xx/n900, I noticed that this series
> prevents
> >> > PER and CORE from hitting retention during suspend.  I haven't
> debugged
> >> > why yet.
> >> I have not done power testing. I will try this out right away and
> confirm.
> >>
> > Here is a brief update on pm test.
> >
> > (1) Without dmtimer patch series:
> > [  305.641204] Powerdomain (core_pwrdm) didn't enter target state 1
> > [  305.647491] Could not enter target state in pm_suspend
> 
> What board is this on?
I tried this on OMAP3 SDP.

> 
> Indeed some platforms do not hit CORE retention by default, most often
> because of the boot loader leaving some devices in a state that prevents
> them from idling.
Ok.

> 
> At least on 34xx/n900 (with DSS enabled), core is hitting retention for
> me.  On Beagle, I have to also use my pm-otg-reset branch to ensure that
> the MUSB block is properly reset on boot, othewise MUSB is preventing
> CORE RET.  I suspect this would be the same problem on 3430SDP.
> 
> > (2) With dmtimer patch series:
> > [   25.291503] Powerdomain (core_pwrdm) didn't enter target state 1
> > [   25.297790] Powerdomain (per_pwrdm) didn't enter target state 1
> > [   25.303985] Could not enter target state in pm_suspend
> >
> > I will debug further.
> 
> Thanks, you can see from this that something in the dmtimer series is
> preventing PER from hitting retention.
Yes, I am suspecting dmtimer is not idling correctly and is preventing
PER from hitting retention.
--
Tarun

