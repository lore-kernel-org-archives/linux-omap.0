From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v3 12/13] gpio/omap: fix incorrect context restore logic
 in omap_gpio_runtime_resume
Date: Thu, 8 Mar 2012 08:19:15 +0100
Message-ID: <CAMQu2gzgM=Hc4fis5AsgL50e2KLttTR79iroOtExGecU7F50yw@mail.gmail.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
 <1331118963-26364-13-git-send-email-tarun.kanti@ti.com> <4F574F95.7090801@ti.com>
 <CAC83ZvLFoSppTiPw-_a=z_Mnpmk6nHeaadTShdJP8RpDWh9TLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:57761 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751282Ab2CHHTq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Mar 2012 02:19:46 -0500
Received: by qcsu28 with SMTP id u28so151930qcs.8
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 23:19:35 -0800 (PST)
In-Reply-To: <CAC83ZvLFoSppTiPw-_a=z_Mnpmk6nHeaadTShdJP8RpDWh9TLg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Thu, Mar 8, 2012 at 4:58 AM, DebBarma, Tarun Kanti
<tarun.kanti@ti.com> wrote:
> On Wed, Mar 7, 2012 at 5:37 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
>> On Wednesday 07 March 2012 12:16 PM, Tarun Kanti DebBarma wrote:
>>> In omap_gpio_runtime_resume() the context restore should be indepen=
dent
>>> of bank->enabled_non_wakeup_gpios. This was preventing context rest=
ore
>>> of GPIO lines which are not wakeup enabled.
>>>
>>> Reported-by: Govindraj Raja <govindraj.raja@ti.com>
>>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>>> ---
>>> =A0drivers/gpio/gpio-omap.c | =A0 =A02 +-
>>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>> index 2e8e476..ccfbae0 100644
>>> --- a/drivers/gpio/gpio-omap.c
>>> +++ b/drivers/gpio/gpio-omap.c
>>> @@ -1227,7 +1227,7 @@ static int omap_gpio_runtime_resume(struct de=
vice *dev)
>>> =A0 =A0 =A0 __raw_writel(bank->context.risingdetect,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bank->base + bank->regs->ris=
ingdetect);
>>>
>>> - =A0 =A0 if (!bank->enabled_non_wakeup_gpios || !bank->workaround_=
enabled) {
>>> + =A0 =A0 if (!bank->workaround_enabled) {
>> This doesn't seem to be right.
>> Don't you want to avoid GPIO restore for banks which are in
>> always on domain. Infact the purpose of "enabled_non_wakeup_gpios"
>> is exactly that ? Isn't it.
>>
>> What am I missing ?
> The bank->enabled_non_wakeup_gpios is set whenever a gpio line is pro=
grammed
> as edge trigger as shown below.
> (This is not meant to distinguish between gpios in WKUP domain vs
> those in PER domain).
> The context restore should happen irrespective of whether the trigger
> type is edge or level.
> In fact context restore was not happening for a gpio line because of
> this condition while
> testing suspend/resume.
>
> [...]
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (trigger & IRQ_TYPE_EDGE_BOTH)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bank->enabled_non_wake=
up_gpios |=3D gpio_bit;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bank->enabled_non_wake=
up_gpios &=3D ~gpio_bit;
> [...]

Make sense now. Thanks for clarification Tarun.
You can add mine..
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
