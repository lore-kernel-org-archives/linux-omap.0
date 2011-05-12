From: John Stultz <john.stultz@linaro.org>
Subject: RE: [PATCH] rtc-twl: Switch to using threaded irq
Date: Thu, 12 May 2011 16:24:24 -0700
Message-ID: <1305242664.2680.28.camel@work-vm>
References: <1300291634-17884-1-git-send-email-ilkka.koskinen@nokia.com>
	 ,<BANLkTinp8M4nndDC5Sfm=PzCiL-vGEqELg@mail.gmail.com>
	 <4F5287B0C366D047BF44025F9ED7BB43E9D7@008-AM1MPN1-001.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:51126 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757801Ab1ELXYg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 May 2011 19:24:36 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p4CNC4Ns031922
	for <linux-omap@vger.kernel.org>; Thu, 12 May 2011 17:12:04 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p4CNPhYa076820
	for <linux-omap@vger.kernel.org>; Thu, 12 May 2011 17:25:43 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p4CHO1dx006603
	for <linux-omap@vger.kernel.org>; Thu, 12 May 2011 11:24:02 -0600
In-Reply-To: <4F5287B0C366D047BF44025F9ED7BB43E9D7@008-AM1MPN1-001.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ilkka.koskinen@nokia.com
Cc: tony@atomide.com, a.zummo@towertech.it, rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, balajitk@ti.com, ilkkakos@kolumbus.fi

On Thu, 2011-05-05 at 07:51 +0000, ilkka.koskinen@nokia.com wrote:
> Hi,
> 
> Tony and John: What would be the appropriate path for this patch?

I'd probably push it through omap maintainer path, as its hardware
specific and can be better tested there.

thanks
-john


> On Apr 13, 2011 Krishnamoorthy, Balaji T  wrote:
> >On Wed, Mar 16, 2011 at 9:37 PM, Ilkka Koskinen
> <ilkka.koskinen@nokia.com> wrote:
> >>
> >> The driver is accessing to i2c bus in interrupt handler.
> >> Therefore, it should use threaded irq.
> 
> >Acked-by: Balaji T K <balajitk@ti.com>
> 
> >>
> >> Signed-off-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
> >> ---
> >>  drivers/rtc/rtc-twl.c |    2 +-
> >>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
> >> index ed1b868..2715b96 100644
> >> --- a/drivers/rtc/rtc-twl.c
> >> +++ b/drivers/rtc/rtc-twl.c
> >> @@ -475,7 +475,7 @@ static int __devinit twl_rtc_probe(struct platform_device *pdev)
> >>        if (ret < 0)
> >>                goto out1;
> >>
> >> -       ret = request_irq(irq, twl_rtc_interrupt,
> >> +       ret = request_threaded_irq(irq, NULL, twl_rtc_interrupt,
> >>                                IRQF_TRIGGER_RISING,
> >>                                dev_name(&rtc->dev), rtc);
> >>        if (ret < 0) {
> >> --
> >> 1.7.0.4
> >>


