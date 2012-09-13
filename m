From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv8 00/23]I2C big cleanup
Date: Thu, 13 Sep 2012 12:25:27 +0530
Message-ID: <5051835F.3050102@ti.com>
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com> <874nn2vpv9.fsf@deeprootsystems.com> <50517780.2080002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50517780.2080002-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thursday 13 September 2012 11:34 AM, Shubhrajyoti wrote:
> > At least on 3530/Overo and 3730/Overo, CORE no longer hits retenion (or
> > off) during idle.  
I dont have an Overo, anyways will see if I can get one

However on beagleXm even off count increases

/ # grep "^core_pwrdm" /debug/pm_debug/count
core_pwrdm
(ON),OFF:48,RET:856,INA:0,ON:905,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
/ # cat /sys/devices/platform/omap_i2c.*/power/runtime_status
suspended
suspended
/ #
/ #
/ # cat /sys/devices/platform/omap_i2c.*/power/autosuspend_delay_ms
1000
1000
/ #
/ #
/ # grep "^core_pwrdm" /debug/pm_debug/count
core_pwrdm
(ON),OFF:218,RET:856,INA:0,ON:1075,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
/ #
