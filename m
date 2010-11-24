From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v4 2/5] OMAP: mailbox: fix rx interrupt disable in omap4
Date: Wed, 24 Nov 2010 14:20:40 +0530
Message-ID: <AANLkTimevr4qgRZQW+DOEBND15VxA0MjkW3pkwND92JL@mail.gmail.com>
References: <1290547617-16640-1-git-send-email-h-kanigeri2@ti.com>
 <1290547617-16640-3-git-send-email-h-kanigeri2@ti.com> <AANLkTimNW8ixBPyuwckZYnijXmT+t-XSY37xMUVvubLB@mail.gmail.com>
 <20101124082245.GF2468@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:56250 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750744Ab0KXIvV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 03:51:21 -0500
Received: by iwn3 with SMTP id 3so12356328iwn.40
        for <linux-omap@vger.kernel.org>; Wed, 24 Nov 2010 00:51:20 -0800 (PST)
In-Reply-To: <20101124082245.GF2468@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Benoit Cousson <b-cousson@ti.com>

On Wed, Nov 24, 2010 at 13:52, Felipe Balbi <balbi@ti.com> wrote:
> On Wed, Nov 24, 2010 at 10:46:04AM +0530, Varadarajan, Charulatha wro=
te:
>>>
>>> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mail=
box.c
>>> index 48e161c..a1c6bd9 100644
>>> --- a/arch/arm/plat-omap/mailbox.c
>>> +++ b/arch/arm/plat-omap/mailbox.c
>>> @@ -358,6 +358,10 @@ int omap_mbox_register(struct device *parent, =
struct
>>> omap_mbox **list)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D PTR_ERR(mbox=
->dev);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_out;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap44xx())
>>
>> Do not use cpu_is* checks in plat-omap/*
>
> see the previous thread.

Referring to [1], I do not find why cpu_is* checks is used in plat-omap=
 and
why it can't be avoided.

In [1], it was suggested to create the pdata field that will be
populated at init
time using the cpu_is* check. But in this version, I am finding that
this is done
in plat-omap. This can be handled in mach-omap layer itself and can be =
passed
as a pdata field which can be extracted during probe.

[1] https://patchwork.kernel.org/patch/337131/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
