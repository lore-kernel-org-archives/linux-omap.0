From: Hugo Vincent <hugo.vincent@gmail.com>
Subject: Re: [PATCH 1/1] OMAP3:WDT:Enable clk in probe, trigger timer reload
Date: Sat, 13 Jun 2009 15:57:33 +1200
Message-ID: <5a7b8b7b0906122057k48f2d16au63adba5278cee04c@mail.gmail.com>
References: <1244822737-20446-1-git-send-email-ubh@ti.com>
	 <87my8dig6e.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:48117 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbZFMD5c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jun 2009 23:57:32 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1773085ywb.1
        for <linux-omap@vger.kernel.org>; Fri, 12 Jun 2009 20:57:34 -0700 (PDT)
In-Reply-To: <87my8dig6e.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Ulrik Bech Hald <ubh@ti.com>, linux-omap@vger.kernel.org

On Sat, Jun 13, 2009 at 4:13 AM, Kevin
Hilman<khilman@deeprootsystems.com> wrote:
> Ulrik Bech Hald <ubh@ti.com> writes:
>
>> This patch contains two bugfixes:
>>
>> 1)In omap_wdt_probe() the watchdog is reset and disabled. This
>> requires register access and the clks needs to be enabled temporaril=
y
>>
>> 2)In omap_wdt_open() the timer register needs to be reloaded
>> to trigger a new timer value (the default of 60s)
>>
>> Signed-off-by: Ulrik Bech Hald <ubh@ti.com>
>
> Can you change the subject slightly to something like:
>
> =A0watchdog: OMAP fixes: enable clock in probe, trigger timer reload
>
> Also add which OMAP platforms you have tested on since this affects
> OMAP2, OMAP3 and presuably OMAP4.

Tested on OMAP3 (OMAP3503, Gumstix Overo).

> After that, you can add
>
> Reviewed-by: Kevin Hilman <khilman@ti.deeprootsystems.com>
>
> And sent to watchdog maintiner, and CC linux-omap, here's excerpt fro=
m
> MAINTAINERS:
>
> WATCHDOG DEVICE DRIVERS
> P: =A0 =A0 =A0Wim Van Sebroeck
> M: =A0 =A0 =A0wim@iguana.be
> T: =A0 =A0 =A0git git://git.kernel.org/pub/scm/linux/kernel/git/wim/l=
inux-2.6-watchdog.git
> S: =A0 =A0 =A0Maintained
> F: =A0 =A0 =A0Documentation/watchdog/
> F: =A0 =A0 =A0drivers/watchdog/
> F: =A0 =A0 =A0include/linux/watchdog.h
>
>> ---
>> =A0drivers/watchdog/omap_wdt.c | =A0 =A07 +++++++
>> =A01 files changed, 7 insertions(+), 0 deletions(-)
>> =A0mode change 100644 =3D> 100755 drivers/watchdog/omap_wdt.c
>>
>> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt=
=2Ec
>> old mode 100644
>> new mode 100755
>> index f271385..3ed571a
>> --- a/drivers/watchdog/omap_wdt.c
>> +++ b/drivers/watchdog/omap_wdt.c
>> @@ -159,6 +159,7 @@ static int omap_wdt_open(struct inode *inode, st=
ruct file *file)
>> =A0 =A0 =A0 file->private_data =3D (void *) wdev;
>>
>> =A0 =A0 =A0 omap_wdt_set_timeout(wdev);
>> + =A0 =A0 omap_wdt_ping(wdev); /* trigger loading of new timeout val=
ue */
>> =A0 =A0 =A0 omap_wdt_enable(wdev);
>>
>> =A0 =A0 =A0 return nonseekable_open(inode, file);
>> @@ -313,6 +314,9 @@ static int __devinit omap_wdt_probe(struct platf=
orm_device *pdev)
>>
>> =A0 =A0 =A0 platform_set_drvdata(pdev, wdev);
>>
>> + =A0 =A0 clk_enable(wdev->ick);
>> + =A0 =A0 clk_enable(wdev->fck);
>> +
>> =A0 =A0 =A0 omap_wdt_disable(wdev);
>> =A0 =A0 =A0 omap_wdt_adjust_timeout(timer_margin);
>>
>> @@ -332,6 +336,9 @@ static int __devinit omap_wdt_probe(struct platf=
orm_device *pdev)
>> =A0 =A0 =A0 /* autogate OCP interface clock */
>> =A0 =A0 =A0 __raw_writel(0x01, wdev->base + OMAP_WATCHDOG_SYS_CONFIG=
);
>>
>> + =A0 =A0 clk_disable(wdev->ick);
>> + =A0 =A0 clk_disable(wdev->fck);
>> +
>> =A0 =A0 =A0 omap_wdt_dev =3D pdev;
>>
>> =A0 =A0 =A0 return 0;
>> --
>> 1.5.4.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
