From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: hwmod and insertable modules
Date: Fri, 22 Oct 2010 15:31:37 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593023458C2BE@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593023458C204@dbde02.ent.ti.com>
 <0680EC522D0CC943BC586913CF3768C003FF2DAF8D@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593023458C250@dbde02.ent.ti.com>
 <4CC15CC3.7060406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42712 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753381Ab0JVKBl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Oct 2010 06:01:41 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o9MA1cvx002314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 22 Oct 2010 05:01:40 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o9MA1bkr001898
	for <linux-omap@vger.kernel.org>; Fri, 22 Oct 2010 15:31:37 +0530 (IST)
In-Reply-To: <4CC15CC3.7060406@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Menon, Nishanth 
> Sent: Friday, October 22, 2010 3:14 PM
> To: Premi, Sanjeev
> Cc: Nayak, Rajendra; linux-omap@vger.kernel.org
> Subject: Re: hwmod and insertable modules
> 
> Premi, Sanjeev had written, on 10/22/2010 04:41 AM, the following:
> 
> >>> During module_init I used omap_device_build() to create the 
> >> omap_device.
> >>> But when trying to implement the module_exit, I couldn't find the
> >>> corresponding 'destructor'.
> >> omap_device_build essentially does  a platform_device 
> register today
> >> and hence its not something to be done from a insmod'able 'driver'.
> > 
> > [sp] How does this work for - say dspbridge - where the DSP 
> as device
> > may not be 'registered' until it is really expected to be used?
> > 
> arch/arm/mach-omap2/dspbridge.c? ;)

Which repo? On the dspbridge branch on linux-omap, there is not such
file... and dsp.c doesn't seem to be using hwmod; and module_exit
does call platform_device_unregister().
I didn't find any function in omap_device.c that calls/leads to
platform_device_unregister().

This is exactly where I decided to post my query before putting more
effort in the function snippet I posted earlier.

> 
> -- 
> Regards,
> Nishanth Menon
> 