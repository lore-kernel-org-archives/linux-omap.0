From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v8 16/24] gpio/omap: use pm-runtime framework
Date: Mon, 7 Nov 2011 15:39:05 +0530
Message-ID: <CAC83Zv+QFbaZucM8V36qG6tvz_KiFfwGSCxjJSoT60LY2LLuNA@mail.gmail.com>
References: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
	<1317803593-12259-17-git-send-email-tarun.kanti@ti.com>
	<87lirvbykm.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:40848 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753048Ab1KGKJI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Nov 2011 05:09:08 -0500
Received: by qyk2 with SMTP id 2so3272533qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 07 Nov 2011 02:09:05 -0800 (PST)
In-Reply-To: <87lirvbykm.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Charulatha V <charu@ti.com>

On Fri, Nov 4, 2011 at 10:43 PM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> Call runtime pm APIs pm_runtime_get_sync() and pm_runtime_put_sync()
>> for enabling/disabling clocks appropriately. Remove syscore_ops and
>> instead use SET_RUNTIME_PM_OPS macro.
>>
>> Signed-off-by: Charulatha V <charu@ti.com>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/gpio.c | =A0 =A02 -
>> =A0drivers/gpio/gpio-omap.c =A0 | =A0 67 +++++++++++++++++++++++++++=
++---------------
>> =A02 files changed, 44 insertions(+), 25 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
>> index 5ae1cf3..a992802 100644
>> --- a/arch/arm/mach-omap2/gpio.c
>> +++ b/arch/arm/mach-omap2/gpio.c
>> @@ -146,8 +146,6 @@ static int omap2_gpio_dev_init(struct omap_hwmod=
 *oh, void *unused)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(od);
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 omap_device_disable_idle_on_suspend(od);
>> -
>
> No description in the changelog about this change. =A0(Yes, I underst=
and
> why it's removed, but it needs to be described in the changelog so wh=
en
> I forget, I'll have a way to remember.)
Yes, I will put a description explaining that this is not needed after
driver is runtime adapted.
--
Tarun
>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
