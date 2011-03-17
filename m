From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/2] arm: mach-omap2: devices: fix omap3_l3_init() return value
Date: Thu, 17 Mar 2011 15:36:27 +0530
Message-ID: <34f6d3df1c7449f43374ecf3e3a74f77@mail.gmail.com>
References: <1300295763-497-1-git-send-email-aaro.koskinen@nokia.com>
 <324bffcaf53be55bd6f392af3f86fa10@mail.gmail.com> <4D81C41F.8090702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:41531 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752535Ab1CQKGb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 06:06:31 -0400
Received: by gxk27 with SMTP id 27so1097217gxk.29
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 03:06:29 -0700 (PDT)
In-Reply-To: <4D81C41F.8090702@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

> -----Original Message-----
> From: Cousson, Benoit [mailto:b-cousson@ti.com]
> Sent: Thursday, March 17, 2011 1:50 PM
> To: Shilimkar, Santosh
> Cc: Aaro Koskinen; linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; tony@atomide.com
> Subject: Re: [PATCH 1/2] arm: mach-omap2: devices: fix
> omap3_l3_init() return value
>
> Hi Santosh,
>
> On 3/17/2011 6:52 AM, Shilimkar, Santosh wrote:
> >> -----Original Message-----
> >> From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-
> >> arm-kernel-bounces@lists.infradead.org] On Behalf Of Aaro
> Koskinen
> >> Sent: Wednesday, March 16, 2011 10:46 PM
> >> To: linux-omap@vger.kernel.org; linux-arm-
> >> kernel@lists.infradead.org; tony@atomide.com
> >> Cc: Aaro Koskinen
> >> Subject: [PATCH 1/2] arm: mach-omap2: devices: fix
> omap3_l3_init()
> >> return value
> >>
> >> Fix the return value for the successful case.
> >>
> >> Signed-off-by: Aaro Koskinen<aaro.koskinen@nokia.com>
> >> ---
> >>   arch/arm/mach-omap2/devices.c |    2 +-
> >>   1 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-
> >> omap2/devices.c
> >> index 0d2d6a9..d478f53 100644
> >> --- a/arch/arm/mach-omap2/devices.c
> >> +++ b/arch/arm/mach-omap2/devices.c
> >> @@ -65,7 +65,7 @@ static int __init omap3_l3_init(void)
> >>
> >>   	WARN(IS_ERR(od), "could not build omap_device for %s\n",
> >> oh_name);
> >>
> >> -	return PTR_ERR(od);
> >> +	return IS_ERR(od) ? PTR_ERR(od) : 0;
> >>   }
> >>   postcore_initcall(omap3_l3_init);
>
> Maybe we should initialize that before, because in theory the
> timer12 secure violation should have been captured easily with
> this code?
>
The firewall exceptions handling is removed from L3 handler because
PPA has the trap implemented. We faced issues when the trap was
enabled in both places.

Regards
Santosh
