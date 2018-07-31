From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] pwm: pwm-omap-dmtimer: fix probing problems by returning EPROBE_DEFER
Date: Tue, 31 Jul 2018 08:35:26 +0200
Message-ID: <BC0B4EAD-6DC1-4338-9185-FA319F998D41@goldelico.com>
References: <20180728165914.15871-1-andreas@kemnade.info> <20180728203501.GA16194@lenoch> <BE83C4E8-55B0-4EA7-8FF6-756460464264@goldelico.com> <20180729180804.GA18468@lenoch> <920A2836-9266-46F8-9A3F-111C01999C9E@goldelico.com> <20180730185625.14c0feca.drivshin@awxrd.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180730185625.14c0feca.drivshin@awxrd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Rivshin <drivshin@awxrd.com>
Cc: Ladislav Michl <ladis@linux-mips.org>, David Rivshin <drivshin@allworx.com>, Andreas Kemnade <andreas@kemnade.info>, linux-pwm@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org


> Am 31.07.2018 um 00:56 schrieb David Rivshin <drivshin@awxrd.com>:
>=20
> On Sun, 29 Jul 2018 20:19:08 +0200
> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>=20
>> Hi,
>>=20
>>> Am 29.07.2018 um 20:08 schrieb Ladislav Michl =
<ladis@linux-mips.org>:
>>>=20
>>> On Sun, Jul 29, 2018 at 08:32:41AM +0200, H. Nikolaus Schaller =
wrote: =20
>>>> Hi,
>>>>=20
>>>>> Am 28.07.2018 um 22:35 schrieb Ladislav Michl =
<ladis@linux-mips.org>:
>>>>>=20
>>>>> Hi Andreas,
>>>>>=20
>>>>> On Sat, Jul 28, 2018 at 06:59:14PM +0200, Andreas Kemnade wrote: =20=

>>>>>> I got this in the kernel log:
>>>>>> [    0.756042] omap-dmtimer-pwm dmtimer-pwm: dmtimer pdata =
structure NULL
>>>>>> [    0.756134] omap-dmtimer-pwm: probe of dmtimer-pwm failed with =
error -22
>>>>>>=20
>>>>>> the probe function has to wait until omap_dm_timer_probe() in
>>>>>> clocksource/timer-ti-dm.c has initialized pdata, so defer probing =
=20
>>>>>=20
>>>>> There already is a patch by David Rivshin addressing the same =
issue... =20
>>>>=20
>>>> Here it is:
>>>>=20
>>>> https://patchwork.ozlabs.org/patch/943148/
>>>>=20
>>>> but hasn't arrived in linux-next. =20
>>>=20
>>> That's because there'll be v3.
>>>=20
>>>> But it is questionable if a driver should dev_info() about doing =
deferred probing.
>>>> IMHO, it should just do it which is how Andreas' patch works. =20
>>>=20
>>> See here: https://patchwork.ozlabs.org/patch/949659/ =20
>>=20
>> Ah, I see (neither Andreas nor me did follow the original discussions
>> and therefore came up independently with the same thoughts).
>=20
> Seems a lot of us have tripped over this problem at roughly the same=20=

> time. I'm hoping Thierry picks it up in time for the 4.19 merge =
window.

Well, if possible it should be backported to 4.18 and 4.17.

>=20
>> So we will wait for the v3.
>=20
> FYI, v3 has been posted: https://patchwork.ozlabs.org/patch/951299/
> Let me know if you feel strongly enough about having no message
> (vs dev_dbg) for me to spin a quick v4.

I am fine with dev_dbg.

> Seems like each additional=20
> pair of eyes leans in that direction.
>=20
> Ladislav, I realized just after I sent that I forgot to add your ack
> to the commit message. Sorry for the oversight.
>=20

BR and thanks,
Nikolaus
