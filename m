From: Hari Kanigeri <hari.kanigeri@gmail.com>
Subject: Re: [PATCH v4 2/5] OMAP: mailbox: fix rx interrupt disable in omap4
Date: Thu, 25 Nov 2010 08:03:13 -0600
Message-ID: <AANLkTimBWyksOaUCRPVKKuzaCiJGi2Er3DUJhEn7Jq6N@mail.gmail.com>
References: <1290547617-16640-1-git-send-email-h-kanigeri2@ti.com>
	<1290547617-16640-3-git-send-email-h-kanigeri2@ti.com>
	<AANLkTimNW8ixBPyuwckZYnijXmT+t-XSY37xMUVvubLB@mail.gmail.com>
	<20101124082245.GF2468@legolas.emea.dhcp.ti.com>
	<AANLkTimevr4qgRZQW+DOEBND15VxA0MjkW3pkwND92JL@mail.gmail.com>
	<AANLkTimzufujCiF6focs1KLCgsDYpr9v9_9w1Hj=3aet@mail.gmail.com>
	<AANLkTi=5YHOU9jdxagygijx8xzaR38eTPDXnC-=M_Wb4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53753 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172Ab0KYODP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Nov 2010 09:03:15 -0500
Received: by gyb11 with SMTP id 11so466863gyb.19
        for <linux-omap@vger.kernel.org>; Thu, 25 Nov 2010 06:03:15 -0800 (PST)
In-Reply-To: <AANLkTi=5YHOU9jdxagygijx8xzaR38eTPDXnC-=M_Wb4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Tony Lindgren <tony@atomide.com>, balbi@ti.com, Benoit Cousson <b-cousson@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Thu, Nov 25, 2010 at 1:04 AM, Varadarajan, Charulatha <charu@ti.com>=
 wrote:
> Hari,
>
> On Wed, Nov 24, 2010 at 18:31, Kanigeri, Hari <h-kanigeri2@ti.com> wr=
ote:
>> On Wed, Nov 24, 2010 at 2:50 AM, Varadarajan, Charulatha <charu@ti.c=
om> wrote:
>>> On Wed, Nov 24, 2010 at 13:52, Felipe Balbi <balbi@ti.com> wrote:
>>>> On Wed, Nov 24, 2010 at 10:46:04AM +0530, Varadarajan, Charulatha =
wrote:
>>>>>>
>>>>>> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/m=
ailbox.c
>>>>>> index 48e161c..a1c6bd9 100644
>>>>>> --- a/arch/arm/plat-omap/mailbox.c
>>>>>> +++ b/arch/arm/plat-omap/mailbox.c
>>>>>> @@ -358,6 +358,10 @@ int omap_mbox_register(struct device *paren=
t, struct
>>>>>> omap_mbox **list)
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D PTR_ERR(m=
box->dev);
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_out;
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap44xx())
>>>>>
>>>>> Do not use cpu_is* checks in plat-omap/*
>>>>
>>>> see the previous thread.
>>>
>>> Referring to [1], I do not find why cpu_is* checks is used in plat-=
omap and
>>> why it can't be avoided.
>>>
>>> In [1], it was suggested to create the pdata field that will be
>>> populated at init
>>> time using the cpu_is* check. But in this version, I am finding tha=
t
>>> this is done
>>> in plat-omap. This can be handled in mach-omap layer itself and can=
 be passed
>>> as a pdata field which can be extracted during probe.
>>>
>>> [1] https://patchwork.kernel.org/patch/337131/
>>>
>>
>> Here are these =A0reasons why I did this way.
>>
>> - The function omap_mbox_register is called only once during probe
>> time, and I thought it was ok to call cpu check once during probe
>> time.
>
> AFAIK it is not okay. Patches are not accepted by maintainers if cpu_=
is*
> checks are newly added in plat-omap/*
> Moreover, the plat-omap is for common code between omap1 and omap2+
> If any specific info is required due to unavoidable reasons, they sho=
uld be
> managed using pdata fld/ by some other means.
>
>> Since each mbox instance needs to be aware of the rev field this
>> was the right place to add since this function iterates through the
>> list during probe time. There are already calls to cpu_is_omap44xx i=
n
>> mailbox probe function.
>
> Infact , there are some more drivers like that. But some of them are =
getting
> cleaned up slowly (work under progress). But old code having cpu_is* =
checks
> does not justify adding a new cpu_is* check. As I mentioned, it is re=
peatedly
> being insisted in LO mailing list to avoid cpu_is* checks in plat-oma=
p and to
> clean up the drivers to avoid these checks.
>
>>
>> - platform data is not present for mailbox module. I could add it fo=
r
>> revision sake but I would prefer not to do that since this will be a
>> throw away code once the hwmod infrastructure is ready (note: mailbo=
x
>> hwmod patches are under review), and amount of mailbox driver rework
>> might be considerable.
>
> I would leave this to Tony/ Felipe/ Benoit to decide on this. If agre=
ed, I don't
> see any issue. But there should be atleast a "TODO" mentioning that t=
his
> needs to be cleaned up.
>

fair enough. I am dropping this patch from the patch set and will send
it with Omar's hwmod patches.
I will send the revised patch set excluding this patch.

Thank you,
Best regards,
Hari
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
