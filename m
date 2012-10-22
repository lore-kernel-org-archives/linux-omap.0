From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 2/3] RTC: omap-rtc: enable pm_runtime
Date: Mon, 22 Oct 2012 05:59:52 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EB47021@DBDE01.ent.ti.com>
References: <1350575631-15523-1-git-send-email-zonque@gmail.com>
 <1350575631-15523-2-git-send-email-zonque@gmail.com>
 <50802A87.9010409@ti.com> <50802C20.9040408@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EB43BD9@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93EA00B18@DBDE01.ent.ti.com>
 <50845249.2000007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41034 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754108Ab2JVGAX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Oct 2012 02:00:23 -0400
In-Reply-To: <50845249.2000007@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>, "Mohammed, Afzal" <afzal@ti.com>
Cc: "a.zummo@towertech.it" <a.zummo@towertech.it>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, "koen@dominion.thruhere.net" <koen@dominion.thruhere.net>, "david-b@pacbell.net" <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Oct 22, 2012 at 01:21:37, Daniel Mack wrote:
> On 19.10.2012 12:58, Mohammed, Afzal wrote:
> > Hi Daniel,
> > 
> > On Thu, Oct 18, 2012 at 22:03:13, Hiremath, Vaibhav wrote:
> >> On Thu, Oct 18, 2012 at 21:49:44, Daniel Mack wrote:
> >>> On 18.10.2012 18:12, Vaibhav Hiremath wrote:
> > 
> >>>> It would be really helpful if you could test these patches and ack them.
> > 
> >>> Ok, will do tomorrow. What's missing there is support for writing to the
> >>> OMAP_RTC_OSC_REG (path 3/3 in my series). Would like me to rebase the
> >>> functionality? I need thatkind of setup for my board ...
> > 
> >> This is bit tricky and required more discussion before merging it, 
> >> let me reopen the old discussion which I had started some time back -
> >>
> >>
> >> RTC OSC clock is required to configure clocksource systemtimer for the 
> >> kernel, and it is important when you get into PM related features.
> >>
> >> Please refer the below commit for more reference,
> >>
> >> http://marc.info/?l=u-boot&m=135057734713796&w=2
> > 
> > Newer version (v4) of omap rtc patches for am335x has been
> > posted, "rtc: omap dt support (for am33xx)".
> > In case you can test, please do it over the new series.
> > 
> > You would need also need DT patch that adds DT node to
> > test (it has been separated from the series as it is
> > felt that it should not be part of same series),
> > "arm/dts: am33xx rtc node"
> 
> Agreed. I tested your patches and they do basically the same thing than
> mine. You can take my
> 
>   Tested-by: Daniel Mack <zonque@gmail.com>
> 

Thanks Daniel for testing these patches.

> on all patches in this series except for 2/5 which I didn't test as I
> don't have any Davinci platform.
> 
> > If you are using mainline uboot, you would need the fix as
> > mentioned by Vaibhav H (as in the link he provided above),
> > expecting it to reach uboot mainline soon.
> > 
> > If the above is being attempted to achieve in Kernel it
> > would cause 2-3 seconds delay in boot time (else it had
> > to be made a module), please refer link provided by
> > Vaibhav H for more details.
> > 
> > else you can do in current mainline uboot,
> > 
> > mw.l 0x44e3e06c 0x83e70b13
> > mw.l 0x44e3e070 0x95a4f1e0
> > mw.b 0x44e3e054 0x48
> >
> > and then boot kernel.
> 
> I'm surprised that survives the kernel boot, but I'll give it a try. In
> case you want to add that logic to the kernel as well, please copy me in
> the discussion :)
> 
> 

Certainly...

Some background information for your reference,
We had some discussion in the past on this, and we decided to make this as a 
fallback mechanism considering following scenarios - 

 - System built with 32k crystal OSC, connected to RTC module

 - System without 32k crystal OSC, as RTC is not used.

 - Boot-Loader dependency for RTC clock enable (required for system-timer)

So the fallback mechanism would be something similar -

http://arago-project.org/git/projects/?p=linux-am33x.git;a=commit;h=58abec6ac010f4f8818caa4a52d16c4802e14acc


Thanks,
Vaibhav

> Thanks,
> Daniel
> 
> 

