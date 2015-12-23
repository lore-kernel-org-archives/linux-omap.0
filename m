From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/3] wlcore/wl12xx: spi: fix NULL pointer dereference
 (Oops)
Date: Wed, 23 Dec 2015 12:08:07 +0200
Message-ID: <567A7287.3010205@ti.com>
References: <1450859744-9948-1-git-send-email-uri.mashiach@compulab.co.il>
 <1450859744-9948-2-git-send-email-uri.mashiach@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450859744-9948-2-git-send-email-uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 12/23/2015 10:35 AM, Uri Mashiach wrote:
> The power function uses a consumer regulator access to update the WiFi
> enable GPIO value.
> 
> Fix the below Oops when trying to modprobe wlcore_spi.
> The oops occurs because the wl1271_power_{off,on}()
> function doesn't check the power() function pointer.
> 
> [   23.401447] Unable to handle kernel NULL pointer dereference at
> virtual address 00000000
> [   23.409954] pgd = c0004000
> [   23.412922] [00000000] *pgd=00000000
> [   23.416693] Internal error: Oops: 80000007 [#1] SMP ARM
> [   23.422168] Modules linked in: wl12xx wlcore mac80211 cfg80211
> musb_dsps musb_hdrc usbcore usb_common snd_soc_simple_card evdev joydev
> omap_rng wlcore_spi snd_soc_tlv320aic23_i2c rng_core snd_soc_tlv320aic23
> c_can_platform c_can can_dev snd_soc_davinci_mcasp snd_soc_edma
> snd_soc_omap omap_wdt musb_am335x cpufreq_dt thermal_sys hwmon
> [   23.453253] CPU: 0 PID: 36 Comm: kworker/0:2 Not tainted
> 4.2.0-00002-g951efee-dirty #233
> [   23.461720] Hardware name: Generic AM33XX (Flattened Device Tree)
> [   23.468123] Workqueue: events request_firmware_work_func
> [   23.473690] task: de32efc0 ti: de4ee000 task.ti: de4ee000
> [   23.479341] PC is at 0x0
> [   23.482112] LR is at wl12xx_set_power_on+0x28/0x124 [wlcore]

Why can't you just add proper check in wl1271_power_on/wl1271_power_off() instead?

-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
