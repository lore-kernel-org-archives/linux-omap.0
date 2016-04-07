From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH] PM / wakeirq: fix wakeirq setting after wakup
 re-configuration from sysfs
Date: Thu, 7 Apr 2016 10:56:01 -0700
Message-ID: <20160407175600.GN16484@atomide.com>
References: <1459943153-2553-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459943153-2553-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, nsekhar@ti.com, nm@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [160406 04:47]:
> Now wakeirq stops working for device if wakeup option for
> this device will be reconfigured through sysfs, like:
> 
> echo disabled > /sys/devices/platform/extcon_usb1/power/wakeup
> echo enabled > /sys/devices/platform/extcon_usb1/power/wakeup
> 
> Once above set of commands is executed the device's wakeup_source
> opject will be recreated and dev->power.wakeup->wakeirq field will
> contain NULL. As result, device_wakeup_arm_wake_irqs() will not arm
> wakeirq for the affected device.
> 
> Hece, lets try to fix it in the following way:
>   check for dev->wakeirq field when device_wakeup_attach() is called
>   and if !NULL re-attach wakeirq to the device

Yeah I think that's all there is to it, thanks for fixing it:

Acked-by: Tony Lindgren <tony@atomide.com>
