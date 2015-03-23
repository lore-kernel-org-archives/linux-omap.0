From: Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v7 6/6] wlcore: remove wl12xx_platform_data
Date: Mon, 23 Mar 2015 10:06:33 +0200
Message-ID: <CAB3XZEdyQGtHzY-61baafBQuJ3hNHv1MSkBD+1EmjYzgoSG58g@mail.gmail.com>
References: <1426696710-6891-1-git-send-email-eliad@wizery.com>
	<1426696710-6891-7-git-send-email-eliad@wizery.com>
	<550FC60F.4050206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <550FC60F.4050206-l0cyMroinI0@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Luciano Coelho <luca-XPOmlcxoEMv1KXRcyAk9cg@public.gmane.org>, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

hi Sekhar,

On Mon, Mar 23, 2015 at 9:51 AM, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org> wrote:
> + Ido
>
> On Wednesday 18 March 2015 10:08 PM, Eliad Peller wrote:
>> Now that we have wlcore device-tree bindings in place
>> (for both wl12xx and wl18xx), remove the legacy
>> wl12xx_platform_data struct, and move its members
>> into the platform device data (that is passed to wlcore)
>>
>> Davinci 850 is the only platform that still set
>> the platform data in the legacy way (and doesn't
>> have DT bindings), so remove the relevant
>> code/Kconfig option from the board file (as suggested
>> by Sekhar Nori)
>>
>> Since no one currently uses wlcore_spi, simply remove its
>> platform data support (DT bindings will have to be added
>> if someone actually needs it)
>>
>> Signed-off-by: Luciano Coelho <luca-XPOmlcxoEMv1KXRcyAk9cg@public.gmane.org>
>> Signed-off-by: Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
>> ---
>> v7:
>> * fix spi compilation (Tony)
>> * remove irq/irq_trigger from wlcore_platdev_data (they are
>>   being passed separately)
>>
>>  arch/arm/mach-davinci/Kconfig                  |  11 ---
>>  arch/arm/mach-davinci/board-da850-evm.c        | 113 -------------------------
>>  drivers/net/wireless/ti/wilink_platform_data.c |  25 ------
>>  drivers/net/wireless/ti/wl12xx/main.c          |  19 ++---
>>  drivers/net/wireless/ti/wlcore/boot.c          |   1 -
>>  drivers/net/wireless/ti/wlcore/main.c          |   4 +-
>>  drivers/net/wireless/ti/wlcore/sdio.c          |  76 +++++------------
>>  drivers/net/wireless/ti/wlcore/spi.c           |   6 +-
>>  drivers/net/wireless/ti/wlcore/wlcore_i.h      |   6 +-
>>  include/linux/wl12xx.h                         |  25 ------
>>  10 files changed, 35 insertions(+), 251 deletions(-)
>
> The patch looks good to me, but it will be nice to know to which base it
> applies cleanly. I tried applying to v4.0-rc1 and linux-next and both
> failed.
>
The patchset was rebased on top of v4.0-rc4.
(Note that you'll have to apply the whole series, as this patch relies
on some intermediate changes done by the previous patches in the
patchset)

Eliad.
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
