From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 2/5] OMAP: mailbox: fix rx interrupt disable in omap4
Date: Wed, 24 Nov 2010 10:53:38 +0200
Message-ID: <20101124085338.GH2468@legolas.emea.dhcp.ti.com>
References: <1290547617-16640-1-git-send-email-h-kanigeri2@ti.com>
 <1290547617-16640-3-git-send-email-h-kanigeri2@ti.com>
 <AANLkTimNW8ixBPyuwckZYnijXmT+t-XSY37xMUVvubLB@mail.gmail.com>
 <20101124082245.GF2468@legolas.emea.dhcp.ti.com>
 <AANLkTimevr4qgRZQW+DOEBND15VxA0MjkW3pkwND92JL@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:44753 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750744Ab0KXIxo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 03:53:44 -0500
Received: by yxd5 with SMTP id 5so5725057yxd.6
        for <linux-omap@vger.kernel.org>; Wed, 24 Nov 2010 00:53:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimevr4qgRZQW+DOEBND15VxA0MjkW3pkwND92JL@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: balbi@ti.com, Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Benoit Cousson <b-cousson@ti.com>

On Wed, Nov 24, 2010 at 02:20:40PM +0530, Varadarajan, Charulatha wrote=
:
>On Wed, Nov 24, 2010 at 13:52, Felipe Balbi <balbi@ti.com> wrote:
>> On Wed, Nov 24, 2010 at 10:46:04AM +0530, Varadarajan, Charulatha wr=
ote:
>>>>
>>>> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mai=
lbox.c
>>>> index 48e161c..a1c6bd9 100644
>>>> --- a/arch/arm/plat-omap/mailbox.c
>>>> +++ b/arch/arm/plat-omap/mailbox.c
>>>> @@ -358,6 +358,10 @@ int omap_mbox_register(struct device *parent,=
 struct
>>>> omap_mbox **list)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D PTR_ERR(mbo=
x->dev);
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_out;
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap44xx())
>>>
>>> Do not use cpu_is* checks in plat-omap/*
>>
>> see the previous thread.
>
>Referring to [1], I do not find why cpu_is* checks is used in plat-oma=
p and
>why it can't be avoided.
>
>In [1], it was suggested to create the pdata field that will be
>populated at init
>time using the cpu_is* check. But in this version, I am finding that
>this is done
>in plat-omap. This can be handled in mach-omap layer itself and can be=
 passed
>as a pdata field which can be extracted during probe.
>
>[1] https://patchwork.kernel.org/patch/337131/

true, since I saw mbox->rev, I confused that with something that was
coming from pdata, sorry. You're right, this is not the right way to do
it.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
