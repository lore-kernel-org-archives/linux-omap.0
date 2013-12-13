From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: WG: [PATCH] usb: musb: omap2430: fix occasional musb breakage on boot
Date: Fri, 13 Dec 2013 14:34:39 +0200
Message-ID: <CANOLnON65xu0HKBzmhWOnoEoXscguBuozwKUV5FZAYObt=tP5w@mail.gmail.com>
References: <EE4E4767751A8B40949306E403F4DDD8032AA82A@sv03ultra002.ultratronik.de>
	<52AA2AA8.4090402@andin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-13
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:56932 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602Ab3LMMek convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Dec 2013 07:34:40 -0500
In-Reply-To: <52AA2AA8.4090402@andin.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andreas Naumann <dev@andin.de>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, fbalbi@ti.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Dec 12, 2013 at 11:29 PM, Andreas Naumann <dev@andin.de> wrote:
> Hi Grazvydas,
>
>> Von: Grazvydas Ignotas [mailto:notasas@gmail.com]
>> Gesendet: Donnerstag, 12. Dezember 2013 01:21
>> An: linux-usb@vger.kernel.org
>> Cc: Felipe Balbi; linux-omap@vger.kernel.org; Naumann Andreas; Grazv=
ydas
>> Ignotas; stable@vger.kernel.org
>> Betreff: [PATCH] usb: musb: omap2430: fix occasional musb breakage o=
n boot
>>
>>
>> This is a hard to reproduce problem which leads to non-functional
>> USB-OTG port in 0.1%-1% of all boots. Tracked it down to commit
>> e25bec160158abe86c "omap2+: save and restore OTG_INTERFSEL",
>> which introduces save/restore of OTG_INTERFSEL over suspend.
>>
>> Since the resume function is also called early in driver init, it us=
es a
>> non-initialized value (which is 0 and a non-supported setting in DM3=
7xx
>> for INTERFSEL). Shortly after the correct value is set. Apparently t=
his
>> works most time, but not always.
>>
>> Fix it by not writing the value on runtime resume if it is 0
>> (0 should never be saved in the context as it's invalid value,
>> so we use it as an indicator that context hasn't been saved yet).
>>
>> This issue was originally found by Andreas Naumann:
>> http://marc.info/?l=3Dlinux-usb&m=3D138562574719654&w=3D2
>>
>> Reported-and-bisected-by: Andreas Naumann <anaumann@ultratronik.de>
>> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>> This is a regression from 3.2, so should go to -rc and stable, IMO.
>> It's really annoying issue if you want to have a stable OTG behavior=
,
>> I've burned quite a lot of time on it myself over a year ago and gav=
e up
>> eventually. Good thing Andreas finally found it, many thanks to him!
>>
>>   drivers/usb/musb/omap2430.c |    3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430=
=2Ec
>> index 2a408cd..737b3da 100644
>> --- a/drivers/usb/musb/omap2430.c
>> +++ b/drivers/usb/musb/omap2430.c
>> @@ -672,7 +672,8 @@ static int omap2430_runtime_resume(struct device=
 *dev)
>>
>>         if (musb) {
>>                 omap2430_low_level_init(musb);
>> -               musb_writel(musb->mregs, OTG_INTERFSEL,
>> +               if (musb->context.otg_interfsel !=3D 0)
>> +                       musb_writel(musb->mregs, OTG_INTERFSEL,
>>                                 musb->context.otg_interfsel);
>>                 phy_power_on(musb->phy);
>>         }
>>
>
> Oh, easy way out. I like it but I've also been thinking about your co=
mment
> on my original post, which was that initializing otg_interfsel to the=
 PHYSEL
> bits only might be dangerous because we cant be sure that there are o=
ther
> bits in the register.
> However, isnt assuming that 0 is invalid on all OMAPs just as dangero=
us?

Well I was trying to do a minimal fix so that it could be suitable for
merging to stable kernels. But yes you're right, I've just checked
OMAP4 TRM and 0 is actually valid value there..

> After thinking about my patch again, I would propose to change otg_in=
terfsel
> into otg_physel and read-modify-write only those bits in resume() as =
you
> suggested in your first answer. That way I could discard the problema=
tic
> first read in probe() while leaving other bits untouched. If you agre=
e I
> post a patch for this tomorrow.

Hmm I don't know about that, this would be inconsistent with what all
other OMAP drivers do. Maybe we should do what musb_core.c does just
to be consistent and add a similar comment. Only the static variable
could be avoided in favor of struct omap2430_glue member.

Gra=FEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
