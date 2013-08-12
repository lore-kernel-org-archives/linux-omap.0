From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2_1=2F1=5D_MAINTAINERS=3A_update_Beno=C3=AEt_Couss?=
	=?UTF-8?Q?on_email_address?=
Date: Mon, 12 Aug 2013 11:09:41 +0200
Message-ID: <CAAwP0s3bt3EiA60UPL3StcRuFHF2pgD6A7DpEkoFkud59tNzEA@mail.gmail.com>
References: <1376234465-15476-1-git-send-email-javier.martinez@collabora.co.uk>
 <20130812075556.GH7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f51.google.com ([209.85.212.51]:59845 "EHLO
	mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab3HLJKC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Aug 2013 05:10:02 -0400
Received: by mail-vb0-f51.google.com with SMTP id x16so5550239vbf.10
        for <linux-omap@vger.kernel.org>; Mon, 12 Aug 2013 02:10:01 -0700 (PDT)
In-Reply-To: <20130812075556.GH7656@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Jiri Kosina <jkosina@suse.cz>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <benoit.cousson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Belisko Marek <marek.belisko@gmail.com>, linux-omap@vger.kernel.org

Hi Tony,

On Mon, Aug 12, 2013 at 9:55 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Javier Martinez Canillas <javier.martinez@collabora.co.uk> [130811 =
08:28]:
>> Using the email address listed on MAINTAINERS I keep
>> getting SMTP 550 Invalid recipient errors.
>>
>> Update with what seems to be current Beno=C3=AEt's email
>> address to make get_maintainer.pl to stop lying.
>>
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.c=
o.uk>
>
> Is the linaro.org address still valid? We should probably
> wait for Benoit to confirm this to avoid more confusion.
>

It seems so, at least I don't the SMTP 550 errors with it. But I agree
that is best to wait for Benoit to confirm what is his current
address. I just wanted to help...

> Regards,
>
> Tony
>

Best regards,
Javier

>> ---
>>
>> Patch on top of Linus's commit c095ba72 ("Linux 3.11-rc4").
>>
>> Changes since v1:
>>  - I mostly send DT patches to Beno=C3=AEt but now I noticed that
>>    he also maintains other subsystems. Update the patch to
>>    change all his MAINTAINERS entries.
>>
>>  MAINTAINERS |    6 +++---
>>  1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index defc053..3466423 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -5879,7 +5879,7 @@ F:      drivers/i2c/busses/i2c-omap.c
>>  F:   include/linux/i2c-omap.h
>>
>>  OMAP DEVICE TREE SUPPORT
>> -M:   Beno=C3=AEt Cousson <b-cousson@ti.com>
>> +M:   Beno=C3=AEt Cousson <benoit.cousson@linaro.org>
>>  M:   Tony Lindgren <tony@atomide.com>
>>  L:   linux-omap@vger.kernel.org
>>  L:   devicetree@vger.kernel.org
>> @@ -5959,14 +5959,14 @@ S:    Maintained
>>  F:   drivers/char/hw_random/omap-rng.c
>>
>>  OMAP HWMOD SUPPORT
>> -M:   Beno=C3=AEt Cousson <b-cousson@ti.com>
>> +M:   Beno=C3=AEt Cousson <benoit.cousson@linaro.org>
>>  M:   Paul Walmsley <paul@pwsan.com>
>>  L:   linux-omap@vger.kernel.org
>>  S:   Maintained
>>  F:   arch/arm/mach-omap2/omap_hwmod.*
>>
>>  OMAP HWMOD DATA FOR OMAP4-BASED DEVICES
>> -M:   Beno=C3=AEt Cousson <b-cousson@ti.com>
>> +M:   Beno=C3=AEt Cousson <benoit.cousson@linaro.org>
>>  L:   linux-omap@vger.kernel.org
>>  S:   Maintained
>>  F:   arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> --
>> 1.7.7.6
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
