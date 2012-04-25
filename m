From: Ashwin Bihari <abihari@gmail.com>
Subject: Re: DM3730 BSP issue with msleep()
Date: Wed, 25 Apr 2012 09:44:50 -0400
Message-ID: <CANLagX9sYmAzKfY2tPdOyNm0ZyVWdy=90uc0XavMRFPJtuRTaA@mail.gmail.com>
References: <CANLagX-mf7wsG+AR3mMb2TX=ZmJFkwi66Q2G9D-VqnbBAbFUdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:42125 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757396Ab2DYNov convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Apr 2012 09:44:51 -0400
Received: by obbta14 with SMTP id ta14so105855obb.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Apr 2012 06:44:50 -0700 (PDT)
In-Reply-To: <CANLagX-mf7wsG+AR3mMb2TX=ZmJFkwi66Q2G9D-VqnbBAbFUdQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

On Mon, Apr 23, 2012 at 1:13 PM, Ashwin Bihari <abihari@gmail.com> wrot=
e:
> Greetings,
>
> I'm trying to add support for our DM3730-based SOMs to the latest
> Kernel and am basing my work on the latest and greatest Linux-next
> (3.4.0-rc4-next-20120423-dirty currently) and am finding an
> interesting issue with the use of msleep.
>
> I'm trying to bring up a basic system with SD and Ethernet support fo=
r
> starters, and am finding that the MMC detection code just hangs, afte=
r
> some digging around I found the issue to be related to the use of
> mmc_delay() calls which depending on the timeout required either uses
> mdelay() or msleep(). All of the calls to mdelay() succeed, while the
> msleep() call hangs.
>
> Interestingly, msleep() is used in earlier
> (arch/arm/mach-omap2)/board-* level files and that seems to function
> properly.
>
> I got around the mmc_delay() properly by using the change below (this
> is only temporary), but I end up hanging somewhere farther along and
> the last few lines are:
>
> [ =A0 =A02.047088] twl_rtc twl_rtc: Power up reset detected.
> [ =A0 =A02.052673] twl_rtc twl_rtc: Enabling TWL-RTC
> [ =A0 =A02.064331] twl_rtc twl_rtc: rtc core: registered twl_rtc as r=
tc0
> [ =A0 =A02.073028] i2c /dev entries driver
> [ =A0 =A02.080505] Driver for 1-wire Dallas network protocol.
> [ =A0 =A02.091522] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial ti=
meout 60 sec
> [ =A0 =A02.101043] twl4030_wdt twl4030_wdt: Failed to register misc d=
evice
> [ =A0 =A02.107940] twl4030_wdt: probe of twl4030_wdt failed with erro=
r -16
> [ =A0 =A02.122222] omap_hsmmc omap_hsmmc.0: Failed to get debounce cl=
k
> [ =A0 =A02.382659] usbcore: registered new interface driver usbhid
> [ =A0 =A02.388549] usbhid: USB HID core driver
> [ =A0 =A02.392822] oprofile: hardware counters not available
> [ =A0 =A02.398284] oprofile: using timer interrupt.
> [ =A0 =A02.403961] TCP: cubic registered
> [ =A0 =A02.407623] Initializing XFRM netlink socket
> [ =A0 =A02.412506] NET: Registered protocol family 17
> [ =A0 =A02.417388] NET: Registered protocol family 15
> [ =A0 =A02.422821] Registering the dns_resolver key type
> [ =A0 =A02.428222] VFP support v0.3: implementor 41 architecture 3 pa=
rt 30
> variant c rev 3
> [ =A0 =A02.436676] ThumbEE CPU extension supported.
> [ =A0 =A02.493072] clock: disabling unused clocks to save power
> [ =A0 =A02.545989] twl_rtc twl_rtc: setting system clock to 2000-01-0=
1
> 00:00:00 UTC (946684800)
> [ =A0 =A02.560760] Waiting for root device /dev/mmcblk0p2...
> [ =A0 =A02.783111] mmc0: host does not support reading read-only swit=
ch.
> assuming write-enable.
> [ =A0 =A02.794372] mmc0: new high speed SDHC card at address b368
> [ =A0 =A02.814636] mmcblk0: mmc0:b368 00000 3.74 GiB
> [ =A0 =A02.828704] =A0mmcblk0: p1 p2
>
> Does anyone have any pointers for me to try out to see what's going o=
n?
>
> ------------
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 3bdafbc..7062f15 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -48,12 +48,16 @@ void mmc_power_off(struct mmc_host *host);
>
> =A0static inline void mmc_delay(unsigned int ms)
> =A0{
> + =A0 =A0 =A0 cond_resched();
> + =A0 =A0 =A0 mdelay(ms);
> +#if 0
> =A0 =A0 =A0 =A0if (ms < 1000 / HZ) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cond_resched();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mdelay(ms);
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msleep(ms);
> =A0 =A0 =A0 =A0}
> +#endif
> =A0}
>
> =A0void mmc_rescan(struct work_struct *work);
>
>
> -- Ashwin

I've continued to debug this a bit further and have been updating to
the latest versions of linux-next to see if any of the behavior change
and it hasn't yet. However, I did try to see if I could use an EXT2
ramdisk (that I know works on other Kernels I have) to avoid any
potential issues I am having with the SD and it turns out that the
ramdisk also doesn't mount. The mounting of the ramdisk root also
hangs in some of the very code "fs/namespace.c" code that I haven't
even touched.

I have a OMAP3530 SOM that works with the same image and it boots from
ramdisk, SD and all without any problems.

I must be missing or have no configured something at a very early
level to get this messed up..any ideas?

-- Ashwin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
