From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: Re: [PATCH v4 2/5] OMAP: mailbox: fix rx interrupt disable in omap4
Date: Wed, 24 Nov 2010 07:01:57 -0600
Message-ID: <AANLkTimzufujCiF6focs1KLCgsDYpr9v9_9w1Hj=3aet@mail.gmail.com>
References: <1290547617-16640-1-git-send-email-h-kanigeri2@ti.com>
	<1290547617-16640-3-git-send-email-h-kanigeri2@ti.com>
	<AANLkTimNW8ixBPyuwckZYnijXmT+t-XSY37xMUVvubLB@mail.gmail.com>
	<20101124082245.GF2468@legolas.emea.dhcp.ti.com>
	<AANLkTimevr4qgRZQW+DOEBND15VxA0MjkW3pkwND92JL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:36910 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754195Ab0KXNB7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 08:01:59 -0500
Received: by mail-qw0-f54.google.com with SMTP id 5so4048qwe.41
        for <linux-omap@vger.kernel.org>; Wed, 24 Nov 2010 05:01:58 -0800 (PST)
In-Reply-To: <AANLkTimevr4qgRZQW+DOEBND15VxA0MjkW3pkwND92JL@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: balbi@ti.com, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Benoit Cousson <b-cousson@ti.com>

On Wed, Nov 24, 2010 at 2:50 AM, Varadarajan, Charulatha <charu@ti.com>=
 wrote:
> On Wed, Nov 24, 2010 at 13:52, Felipe Balbi <balbi@ti.com> wrote:
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
> Referring to [1], I do not find why cpu_is* checks is used in plat-om=
ap and
> why it can't be avoided.
>
> In [1], it was suggested to create the pdata field that will be
> populated at init
> time using the cpu_is* check. But in this version, I am finding that
> this is done
> in plat-omap. This can be handled in mach-omap layer itself and can b=
e passed
> as a pdata field which can be extracted during probe.
>
> [1] https://patchwork.kernel.org/patch/337131/
>

Here are these  reasons why I did this way.

- The function omap_mbox_register is called only once during probe
time, and I thought it was ok to call cpu check once during probe
time. Since each mbox instance needs to be aware of the rev field this
was the right place to add since this function iterates through the
list during probe time. There are already calls to cpu_is_omap44xx in
mailbox probe function.

- platform data is not present for mailbox module. I could add it for
revision sake but I would prefer not to do that since this will be a
throw away code once the hwmod infrastructure is ready (note: mailbox
hwmod patches are under review), and amount of mailbox driver rework
might be considerable.

- I could wait till the hwmod patches are ready to include this
change, but don't want to put the dependency with hwmod since this is
a critical fix and want to make it available in the mainline kernel.

Please let me know what you suggest.

Thank you,
Best regards,
Hari Kanigeri
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
