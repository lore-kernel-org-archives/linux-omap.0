From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: dmtimer: cleanup fclk usage
Date: Wed, 18 Apr 2012 10:30:55 +0530
Message-ID: <CAC83ZvJ=TsDvs-pVZP1PyLFQY=nLh48tDE8SYQFxrLOUD-3aHQ@mail.gmail.com>
References: <1334579125-15566-1-git-send-email-tarun.kanti@ti.com>
	<1334579125-15566-4-git-send-email-tarun.kanti@ti.com>
	<alpine.DEB.2.00.1204161034290.29048@utopia.booyaka.com>
	<4F8C864B.4090101@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:45741 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750730Ab2DRFA6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Apr 2012 01:00:58 -0400
Received: by qcsc20 with SMTP id c20so5432766qcs.18
        for <linux-omap@vger.kernel.org>; Tue, 17 Apr 2012 22:00:55 -0700 (PDT)
In-Reply-To: <4F8C864B.4090101@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, santosh.shilimkar@ti.com, rnayak@ti.com

Hi Paul,

On Tue, Apr 17, 2012 at 2:21 AM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> On 4/16/2012 6:40 PM, Paul Walmsley wrote:
>>
>> Hi
>>
>> a few comments
>>
>> On Mon, 16 Apr 2012, Tarun Kanti DebBarma wrote:
>
>
> ...
>
>
>>> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/time=
r.c
>>> index 5d7a0ee..9459d70 100644
>>> --- a/arch/arm/mach-omap2/timer.c
>>> +++ b/arch/arm/mach-omap2/timer.c
>>> @@ -164,8 +164,7 @@ static int __init omap_dm_timer_init_one(struct
>>> omap_dm_timer *timer,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENXIO;
>>>
>>> =A0 =A0 =A0 =A0/* After the dmtimer is using hwmod these clocks won=
't be needed
>>> */
>>> - =A0 =A0 =A0 sprintf(name, "gpt%d_fck", gptimer_id);
>>> - =A0 =A0 =A0 timer->fclk =3D clk_get(NULL, name);
>>> + =A0 =A0 =A0 timer->fclk =3D clk_get(NULL, oh->main_clk);
>>> =A0 =A0 =A0 =A0if (IS_ERR(timer->fclk))
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>>
>>
>> If you find yourself accessing struct omap_hwmod structure fields
>> directly, something is almost certainly wrong; and this case is not =
an
>> exception. =A0Since the omap_device code is defining an "fck" alias =
to the
>> main_clk, all you should need to do is:
>>
>> - =A0 =A0 sprintf(name, "gpt%d_fck", gptimer_id);
>> - =A0 =A0 timer->fclk =3D clk_get(NULL, name);
>> + =A0 =A0 timer->fclk =3D clk_get(NULL, "fck");
>
>
> Are you sure that's the same in that case?
> "timer1_fck" is an unique entry in the clkdev table whereas there are=
 a
> bunch of clock nodes with the "fck" alias local to a device.
> Without the proper dev_id, there is no way to guaranty we will get th=
e timer
> fck clock alias.
That' right, I confirmed that clk_get(NULL, "fck") does not work.
=46or this to work we need the dev pointer in place of NULL.
What is your alternate suggestion? Thanks.
--
Tarun

>
> Since that code is executed pretty early before there is any device,
> accessing directly the hwmod entry seems to be the only method to get=
 the
> proper clock without having to provide again the full clock name.
>
> AFAIR, the "fck" alias is created during the omap_device creation, so=
 I
> guess it is too early here to have it.
>
> To be honest I'm always a little bit confused with that early code, b=
ut it
> looks like there is no device at all in that early part of the code.
>
> Regards,
> Benoit
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
