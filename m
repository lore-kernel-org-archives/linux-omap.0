From: Anuj Aggarwal <anuj.aggarwal@gmail.com>
Subject: Re: [RFC][PATCH] ARM: OMAP: McBSP: Use register cache
Date: Sat, 5 Sep 2009 23:01:05 +0530
Message-ID: <2ee9e08d0909051031g6463f1b6g1a8bb3a642dd2b0a@mail.gmail.com>
References: <1252042776.23177.39.camel@eenurkka-desktop> <200909041234.06121.jkrzyszt@tis.icnet.pl>
	<1252062431.23177.68.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f175.google.com ([209.85.210.175]:43377 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbZIERbZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Sep 2009 13:31:25 -0400
Received: by yxe5 with SMTP id 5so3803025yxe.33
        for <linux-omap@vger.kernel.org>; Sat, 05 Sep 2009 10:31:27 -0700 (PDT)
In-Reply-To: <1252062431.23177.68.camel@eenurkka-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext-eero.nurkkala@nokia.com
Cc: ext Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "e3-hacking@earth.li" <e3-hacking@earth.li>

On Fri, Sep 4, 2009 at 4:37 PM, Eero
Nurkkala<ext-eero.nurkkala@nokia.com> wrote:
> On Fri, 2009-09-04 at 12:34 +0200, ext Janusz Krzysztofik wrote:
>> in normal (handset) mode, the noise level seems still acceptable. Th=
e only
>> missing piece of a puzzle is my patch, that prevents the kernel driv=
er from
>> putting corrupted values into the McBSP control registers.
>>
>> That learned, please reconsider:
>> 1. Can my patch break anything, related or not?
>
> That needs to be investigated in more detail.
>
>> 2. How does it affect performance of otherwise unaffected machines?
>
> Like you already know, shouldn't.
>
>> 3. Is correcting a poorly designed machine behaviour worth of the ch=
ange?
>>
>> Thanks,
>> Janusz
>
>
> I'd say this is in the right track. All McBSP registers
> (not status etc) will need to be stored in memory. (Now, they're not)=
=2E
> And all those register contents will need to be written back
> in certain situations. So this is the case when there is an external
> audio chip, that takes audio in in bursts. So once the
> burst is complete, all McBSP clocks will be disabled for a duration.
>
> Then (at least >=3D 3430) device will hit OFF mode, meaning
> all register contents are lost, also McBSP's. They will
> need to be written back at some point.
Isn't the better way to achieve this thing, at least from the OFF mode
perspective, is to provide similar implementation for McBSP in
omap3_core_save_context () / omap3_core_restore_context(), in
file arch/arm/mach-omap2/pm34xx.c? Code for other core peripherals
is already there and we have to add support for rest of the core-domain
peripherals.
>
> My quick verdict is, that your patch is, going into right
> direction. But the thing is that my words don't count much ;)
>
> (Possibly worth taking the patch in, if guaranteed to not break
> =A0any others).
>
> - Eero
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Best Regards,
Anuj Aggarwal
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
