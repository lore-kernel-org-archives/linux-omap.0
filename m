From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] PM / wakeirq: report wakeup events in dedicated wake-IRQs
Date: Fri, 11 Nov 2016 12:17:52 -0800
Message-ID: <20161111201751.GH7138@atomide.com>
References: <1478801227-65527-1-git-send-email-briannorris@chromium.org>
 <CAKdAkRRWUWmGUFaD=95Zd=wZfqXcs47YXL335Y4A+VmhtdJFTA@mail.gmail.com>
 <20161110184910.GA135921@google.com>
 <20161110204911.GK27724@atomide.com>
 <20161110213038.GA108490@google.com>
 <20161111164753.GD7138@atomide.com>
 <20161111194041.GA111624@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161111194041.GA111624@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lkml <linux-kernel@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Brian Norris <briannorris@chromium.org> [161111 11:40]:
> 
> BTW, for context, I'm working on using dev_pm_set_dedicated_wake_irq()
> for a Wifi driver which supports out-of-band (e.g., GPIO-based) wakeup.
> I see it's used in the I2C core, but the I2C code never actually calls
> dev_pm_enable_wake_irq(). So while I think I can use this API OK for
> my Wifi driver (calling dev_pm_{en,dis}able_wake_irq() at system
> suspend/resume), I'm not sure this will help the I2C case.

OK it's used for that purpose with the SDIO dat1 interrupt for
omaps. This allows the WLAN to stay on and connected while the
SoC can hit deeper idle states.

The calling of dev_pm_enable_wake_irq() happens automagically from
rpm_suspend() and then it's disabled after rpm_resume().

> The more I look at this API, the more I'm confused, especially about its
> seeming dependence on runtime PM.

Are you talking about suspend/resume only? If so, see if the
following snippet from Grygorii helps. Grygorii, care to send it with
proper description and Signed-off-by if you did not yet do that?

Regards,

Tony

8< ----------------------
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -256,8 +256,12 @@ void dev_pm_arm_wake_irq(struct wake_irq *wirq)
 	if (!wirq)
 		return;
 
-	if (device_may_wakeup(wirq->dev))
+	if (device_may_wakeup(wirq->dev)) {
+		if (wirq->dedicated_irq)
+			enable_irq(wirq->irq);
+
 		enable_irq_wake(wirq->irq);
+	}
 }
 
 /**
@@ -272,6 +276,10 @@ void dev_pm_disarm_wake_irq(struct wake_irq *wirq)
 	if (!wirq)
 		return;
 
-	if (device_may_wakeup(wirq->dev))
+	if (device_may_wakeup(wirq->dev)) {
 		disable_irq_wake(wirq->irq);
+
+		if (wirq->dedicated_irq)
+			disable_irq_nosync(wirq->irq);
+	}
 }
