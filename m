From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [RFC PATCH 04/10] OMAP: GPIO: Remove dependency on gpio_bank_count
Date: Fri, 20 May 2011 14:00:15 +0530
Message-ID: <BANLkTinSL0GYrjhM7BSQvMVKBS+EgdzPbw@mail.gmail.com>
References: <1305546104-1511-1-git-send-email-tarun.kanti@ti.com>
 <1305546104-1511-5-git-send-email-tarun.kanti@ti.com> <8739ka7igv.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:34371 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934559Ab1ETIa6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 May 2011 04:30:58 -0400
Received: by mail-iw0-f169.google.com with SMTP id 8so3089459iwg.28
        for <linux-omap@vger.kernel.org>; Fri, 20 May 2011 01:30:55 -0700 (PDT)
In-Reply-To: <8739ka7igv.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

Kevin,

Thanks for the comments.

On Thu, May 19, 2011 at 22:09, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> From: Charulatha V <charu@ti.com>
>>
>> gpio_bank_count is the count of number of GPIO devices
>> in a SoC. Remove this dependency from the driver. Also remove
>> the dependency on array of pointers to gpio_bank struct of
>> all GPIO devices.
>>
>> The cpu_is*() checks used in omap2_gpio_prepare_for_idle() and
>> omap2_gpio_resume_after_idle() would be removed in one of the
>> patches in this series
>>
>> Signed-off-by: Charulatha V <charu@ti.com>
>
> This is all in the right direction, but some comments about the
> save/restore context...
>
> [...]
>
>> @@ -1497,11 +1494,16 @@ void omap2_gpio_resume_after_idle(void)
>> =A0/* save the registers of bank 2-6 */
>> =A0void omap_gpio_save_context(void)
>> =A0{
>> - =A0 =A0 int i;
>> + =A0 =A0 struct gpio_bank *bank;
>> + =A0 =A0 int i =3D 0;
>>
>> =A0 =A0 =A0 /* saving banks from 2-6 only since GPIO1 is in WKUP */
>> - =A0 =A0 for (i =3D 1; i < gpio_bank_count; i++) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 struct gpio_bank *bank =3D &gpio_bank[i];
>> + =A0 =A0 list_for_each_entry(bank, &omap_gpio_list, node) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 i++;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (bank->id =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> +
>
> Rather than add a list iterator here, I'd rather see the save_context
> called from the prepare_for_idle, only for the specific banks needed
> (and then gpio_save_context can be removed from pm34xx.c.)
>
> Similar for restore.

Okay.

>
> If you prefer, you can do that in an additional patch on top of this
> one.

Yes. I am adding a couple of more patches to this series.

-V Charulatha

>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
