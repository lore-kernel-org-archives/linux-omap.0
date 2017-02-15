From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / wakeirq: report a wakeup_event on dedicated wekup irq
Date: Thu, 16 Feb 2017 00:45:56 +0100
Message-ID: <2289787.GWFQX3VCmA@aspire.rjw.lan>
References: <20170213204322.27588-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170213204322.27588-1-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Brian Norris <briannorris@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

On Monday, February 13, 2017 12:43:22 PM Tony Lindgren wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> There are two reasons for reporting wakeup event when dedicated wakeup
> IRQ is triggered:
> 
> - wakeup events accounting, so proper statistical data will be
>   displayed in sysfs and debugfs;
> 
> - there are small window when System is entering suspend during which
>   dedicated wakeup IRQ can be lost:
> 
> dpm_suspend_noirq()
>   |- device_wakeup_arm_wake_irqs()
>       |- dev_pm_arm_wake_irq(X)
>          |- IRQ is enabled and marked as wakeup source
> [1]...
>   |- suspend_device_irqs()
>      |- suspend_device_irq(X)
> 	|- irqd_set(X, IRQD_WAKEUP_ARMED);
> 	   |- wakup IRQ armed
> 
> The wakeup IRQ can be lost if it's triggered at point [1]
> and not armed yet.
> 
> Hence, fix above cases by adding simple pm_wakeup_event() call in
> handle_threaded_wake_irq().
> 
> Fixes: 4990d4fe327b ("PM / Wakeirq: Add automated device wake IRQ
> handling")
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Tested-by: Keerthy <j-keerthy@ti.com>
> [tony@atomide.com: added missing return to avoid warnings]
> Tested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Applied (along with the other two wakeirq fixes).

Thanks,
Rafael
