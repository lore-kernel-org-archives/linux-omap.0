From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH] rtc-twl: Switch to using threaded irq
Date: Wed, 10 Aug 2011 15:44:11 -0700
Message-ID: <1313016251.15198.87.camel@work-vm>
References: <1300291634-17884-1-git-send-email-ilkka.koskinen@nokia.com>
	 <BANLkTinp8M4nndDC5Sfm=PzCiL-vGEqELg@mail.gmail.com>
	 <4F5287B0C366D047BF44025F9ED7BB43E9D7@008-AM1MPN1-001.mgdnok.nokia.com>
	 <1305242664.2680.28.camel@work-vm> <4DD41BE5.4050600@kolumbus.fi>
	 <20110531085139.GA7290@earth.universe>
	 <20110627164506.GA10827@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:36321 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab1HJWoS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Aug 2011 18:44:18 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p7AMOhYV002172
	for <linux-omap@vger.kernel.org>; Wed, 10 Aug 2011 16:24:43 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id p7AMiFr8115238
	for <linux-omap@vger.kernel.org>; Wed, 10 Aug 2011 16:44:15 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p7AGhkXe020693
	for <linux-omap@vger.kernel.org>; Wed, 10 Aug 2011 10:43:47 -0600
In-Reply-To: <20110627164506.GA10827@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, a.zummo@towertech.it, rtc-linux@googlegroups.com, balajitk@ti.com, Ilkka Koskinen <ilkkakos@kolumbus.fi>

On Mon, 2011-06-27 at 18:45 +0200, Sebastian Reichel wrote:
> On Tue, May 31, 2011 at 10:51:39AM +0200, Sebastian Reichel wrote:
> > > The driver is accessing to i2c bus in interrupt handler.
> > > Therefore, it should use threaded irq.
> > I think the patch should also remove the local_irq_enable() call in
> > twl_rtc_interrupt, since it's no longer needed with threaded irq. At
> > least on the Pandaboard the RTC is still working with the appended
> > patch.
> 
> ping.
> 
> Currently the kernel prints a stacktrace for each rtc-twl interrupt,
> because its interrupt handler enables interrupts.

I've queued both changes. Thanks for the reminder.

thanks
-john


