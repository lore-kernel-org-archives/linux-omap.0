From: "Franky Lin" <frankyl-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Panda ES board hang when using GPIO as interrupt
Date: Mon, 25 Jun 2012 13:52:07 -0700
Message-ID: <4FE8CF77.5080400@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khilman-l0cyMroinI0@public.gmane.org, tarun.kanti-l0cyMroinI0@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Kevin, Tarun,

We are using the expansion connector A on Panda board to mount a SDIO 
WiFi dongle on MMC2 with a level triggered interrupt signal connected to 
GPIO 138. It's been working fine until 3.5 rc1. The board hang randomly 
within 5 mins during a network traffic test. After bisecting we found 
the culprit is "[PATCH 8/8] gpio/omap: fix missing check in 
*_runtime_suspend()" [1].

I noticed Kevin raised some similar cases on other platforms and also 
provided two patches in the patch mail thread. But unfortunately those 
two patches doesn't help in our case. I tested the driver with 3.5-rc3 
mainline kernel and the issue is still there. I can only "fix" the hang 
by either reverting the commit or disabling CONFIG_PM_RUNTIME. Also, the 
hang only happens on Panda ES board. Old Panda with 4430 works good.

Any thoughts and suggestions?

Thanks,
Franky

[1] http://article.gmane.org/gmane.linux.ports.arm.omap/75708/

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
