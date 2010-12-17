From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v1] OMAP: GPIO: Correct IP version message during boot
Date: Fri, 17 Dec 2010 09:15:03 -0500
Message-ID: <AANLkTimUrDAR1Wc4oJf74iYKhpxHKkGKLQOEuSNpcBXo@mail.gmail.com>
References: <1292508586-21651-1-git-send-email-charu@ti.com> <8739pxhdcz.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:54374 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754534Ab0LQOPq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Dec 2010 09:15:46 -0500
Received: by mail-iy0-f180.google.com with SMTP id 12so734559iyi.25
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 06:15:43 -0800 (PST)
In-Reply-To: <8739pxhdcz.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, balbi@ti.com

Kevin,

On Thu, Dec 16, 2010 at 11:49, Kevin Hilman <khilman@deeprootsystems.co=
m> wrote:
> "Varadarajan, Charulatha" <charu@ti.com> writes:
>
>> With the commit 9a748053f5f58a77cd71864f1d7b804175b0e47d whose subje=
ct is
>> "OMAP: GPIO: Make omap_gpio_show_rev bank specific" (see [1]),
>> the IP version information for all the banks are shown during bootup=
,
>> but it does not show the bank number.
>>
>> Use dev_info instead of printk in omap_gpio_show_rev() so that the
>> bank id is displayed along with the IP version
>>
>> [1] http://www.spinics.net/lists/arm-kernel/msg105872.html
>
> A related question, the commit above also changed the GPIO revision
> display from one-time to once per bank. =A0Do we need to know the GPI=
O HW
> revision for each bank, or can we assume it's the same for all banks?

The IP version is the same for all the gpio banks in all OMAP2+ CPUs.
But I am not sure about OMAP16xx.

>
> Kevin
>
>> Signed-off-by: Varadarajan, Charulatha <charu@ti.com>
>> Acked-by: Felipe Balbi <balbi@ti.com>
>> ---
>> =A0arch/arm/plat-omap/gpio.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
>> index 8d493b9..47aeaeb 100644
>> --- a/arch/arm/plat-omap/gpio.c
>> +++ b/arch/arm/plat-omap/gpio.c
>> @@ -1554,7 +1554,7 @@ static void __init omap_gpio_show_rev(struct g=
pio_bank *bank)
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> - =A0 =A0 printk(KERN_INFO "OMAP GPIO hardware version %d.%d\n",
>> + =A0 =A0 dev_info(bank->dev, "hardware version %d.%d\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 (rev >> 4) & 0x0f, rev & 0x0f);
>> =A0}
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
