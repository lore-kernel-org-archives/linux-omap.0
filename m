From: Ruslan Bilovol <ruslan.bilovol@ti.com>
Subject: =?ISO-8859-1?Q?Re=3A_=5BPATCH_v2_1=2F1=5D_MAINTAINERS=3A_update_Beno=EEt_Couss?=
	=?ISO-8859-1?Q?on_email_address?=
Date: Mon, 12 Aug 2013 13:21:31 +0300
Message-ID: <CAB=otbQ5k2JSSTBs-y73-W2Fn4PYCt-hY2QsZRwMPxY9V_BHmQ@mail.gmail.com>
References: <1376234465-15476-1-git-send-email-javier.martinez@collabora.co.uk>
	<20130812075556.GH7656@atomide.com>
	<CAAwP0s3bt3EiA60UPL3StcRuFHF2pgD6A7DpEkoFkud59tNzEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:55490 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663Ab3HLKVc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Aug 2013 06:21:32 -0400
Received: by mail-we0-f172.google.com with SMTP id t61so5388825wes.31
        for <linux-omap@vger.kernel.org>; Mon, 12 Aug 2013 03:21:31 -0700 (PDT)
In-Reply-To: <CAAwP0s3bt3EiA60UPL3StcRuFHF2pgD6A7DpEkoFkud59tNzEA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Jiri Kosina <jkosina@suse.cz>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <benoit.cousson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Belisko Marek <marek.belisko@gmail.com>, linux-omap@vger.kernel.org

Hi,

Looking into Benoit's tree
https://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git=
/
we can see that last change there was made two months ago...
So yes wee need to have at least confirmation from Benoit that he is
going to maintain the tree.
Also looks like OMAP devicetree-related patches hung in mailing lists
at least for last 2 months...

--=20
Best regards,
Ruslan Bilvol

On Mon, Aug 12, 2013 at 12:09 PM, Javier Martinez Canillas
<martinez.javier@gmail.com> wrote:
> Hi Tony,
>
> On Mon, Aug 12, 2013 at 9:55 AM, Tony Lindgren <tony@atomide.com> wro=
te:
>> * Javier Martinez Canillas <javier.martinez@collabora.co.uk> [130811=
 08:28]:
>>> Using the email address listed on MAINTAINERS I keep
>>> getting SMTP 550 Invalid recipient errors.
>>>
>>> Update with what seems to be current Beno=EEt's email
>>> address to make get_maintainer.pl to stop lying.
>>>
>>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.=
co.uk>
>>
>> Is the linaro.org address still valid? We should probably
>> wait for Benoit to confirm this to avoid more confusion.
>>
>
> It seems so, at least I don't the SMTP 550 errors with it. But I agre=
e
> that is best to wait for Benoit to confirm what is his current
> address. I just wanted to help...
>
>> Regards,
>>
>> Tony
>>
>
> Best regards,
> Javier
>
>>> ---
>>>
>>> Patch on top of Linus's commit c095ba72 ("Linux 3.11-rc4").
>>>
>>> Changes since v1:
>>>  - I mostly send DT patches to Beno=EEt but now I noticed that
>>>    he also maintains other subsystems. Update the patch to
>>>    change all his MAINTAINERS entries.
>>>
>>>  MAINTAINERS |    6 +++---
>>>  1 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index defc053..3466423 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -5879,7 +5879,7 @@ F:      drivers/i2c/busses/i2c-omap.c
>>>  F:   include/linux/i2c-omap.h
>>>
>>>  OMAP DEVICE TREE SUPPORT
>>> -M:   Beno=EEt Cousson <b-cousson@ti.com>
>>> +M:   Beno=EEt Cousson <benoit.cousson@linaro.org>
>>>  M:   Tony Lindgren <tony@atomide.com>
>>>  L:   linux-omap@vger.kernel.org
>>>  L:   devicetree@vger.kernel.org
>>> @@ -5959,14 +5959,14 @@ S:    Maintained
>>>  F:   drivers/char/hw_random/omap-rng.c
>>>
>>>  OMAP HWMOD SUPPORT
>>> -M:   Beno=EEt Cousson <b-cousson@ti.com>
>>> +M:   Beno=EEt Cousson <benoit.cousson@linaro.org>
>>>  M:   Paul Walmsley <paul@pwsan.com>
>>>  L:   linux-omap@vger.kernel.org
>>>  S:   Maintained
>>>  F:   arch/arm/mach-omap2/omap_hwmod.*
>>>
>>>  OMAP HWMOD DATA FOR OMAP4-BASED DEVICES
>>> -M:   Beno=EEt Cousson <b-cousson@ti.com>
>>> +M:   Beno=EEt Cousson <benoit.cousson@linaro.org>
>>>  L:   linux-omap@vger.kernel.org
>>>  S:   Maintained
>>>  F:   arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>> --
>>> 1.7.7.6
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
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
