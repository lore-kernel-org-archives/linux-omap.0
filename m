From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v12 4/9] OMAP2+: dmtimer: convert to platform devices
Date: Thu, 10 Mar 2011 20:59:19 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037A4DD855@dbde02.ent.ti.com>
References: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
 <1299627948-20040-5-git-send-email-tarun.kanti@ti.com>
 <20110309214215.GQ26463@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57457 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752979Ab1CJP3Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 10:29:24 -0500
In-Reply-To: <20110309214215.GQ26463@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Thursday, March 10, 2011 3:12 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Gopinath, Thara
> Subject: Re: [PATCH v12 4/9] OMAP2+: dmtimer: convert to platform devices
> 
> * Tarun Kanti DebBarma <tarun.kanti@ti.com> [110308 15:41]:
> > Add routines to converts dmtimers to platform devices. The device data
> > is obtained from hwmod database of respective platform and is registered
> > to device model after successful binding to driver. It also provides
> > provision to access timers during early boot when pm_runtime framework
> > is not completely up and running.
> > +	 common.o gpio.o dma.o wd_timer.o dmtimer.o
> 
> > new file mode 100755
> > index 0000000..60c410b
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/dmtimer.c
> 
> Uhh please check the mode changes for this series..
> 
> > new file mode 100755
> > index 0000000..4cfd580
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/dmtimer.h
> 
> Here too and maybe other places also.
Sorry for the mistake. I will correct and repost. Thanks.
--
Tarun

> 
> Tony
