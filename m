From: Andy Green <andy.green@linaro.org>
Subject: Re: [PATCH 3/3] OMAPDSS: HDMI: Cache EDID
Date: Thu, 28 Jun 2012 20:03:06 +0800
Message-ID: <4FEC47FA.1040801@linaro.org>
References: <1340805944-28805-1-git-send-email-jaswinder.singh@linaro.org>  <1340869729.5037.7.camel@deskari>  <CAJe_ZhcWSYhRWSW0v9OqsHRXASsQ8i2P8F8OS+jXkyadoRM9iA@mail.gmail.com>  <1340878461.5037.30.camel@deskari>  <CAJe_Zhc_ye1f=hOVd=AJ7rmCQ_vwDtjQOKsufPYmV1o-58jyAA@mail.gmail.com>  <CAJe_ZhfehDquDcyefb7Z9odH+hfQTFiRAux_iyvAycs9Otovtw@mail.gmail.com> <1340881815.5037.53.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:38760 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754989Ab2F1MDQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 08:03:16 -0400
In-Reply-To: <1340881815.5037.53.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, n-dechesne@ti.com, patches@linaro.org

On 06/28/12 19:10, the mail apparently from Tomi Valkeinen included:
> On Thu, 2012-06-28 at 16:28 +0530, Jassi Brar wrote:
>> On 28 June 2012 16:17, Jassi Brar <jaswinder.singh@linaro.org> wrote=
:
>>> On 28 June 2012 15:44, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote=
:
>>>> On Thu, 2012-06-28 at 15:18 +0530, Jassi Brar wrote:
>>>
>>>>>>> --- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
>>>>>>> +++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
>>>>>>> @@ -243,10 +243,13 @@ static int hdmi_check_hpd_state(struct hd=
mi_ip_data *ip_data)
>>>>>>>
>>>>>>>        hpd =3D gpio_get_value(ip_data->hpd_gpio);
>>>>>>>
>>>>>>> -     if (hpd)
>>>>>>> +     if (hpd) {
>>>>>>>                r =3D hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_T=
XON);
>>>>>>> -     else
>>>>>>> +     } else {
>>>>>>> +             /* Invalidate EDID Cache */
>>>>>>> +             ip_data->edid_len =3D 0;
>>>>>>>                r =3D hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_L=
DOON);
>>>>>>> +     }
>>>>>>
>>>>>> There's a problem with this patch, which leaves a wrong EDID in =
the
>>>>>> cache: if you first have the cable connected and hdmi is enabled=
, you
>>>>>> then turn off the HDMI display device via sysfs, we do not go to
>>>>>> hdmi_check_hpd_state at all. The next time hdmi is enabled, we o=
nly get
>>>>>> the plug-in event, and thus EDID cache is never invalidated.
>>>>>>
>>>>> If the hdmi cable is not replugged during that period, I don't se=
e why
>>>>> would you want the EDID invalidated ?
>>>>
>>>> I wasn't very clear with my comment.
>>>>
>>>> When the display device is disabled, we're not listening to the hp=
d
>>>> interrupt anymore. So when it's disabled, the cable can be replugg=
ed and
>>>> the monitor changed, and the driver won't know about it. And so it=
'll
>>>> return the old EDID for the new monitor.
>>>>
>>> If that could be a problem, then we already have some problem with
>>> current omapdss.
>>>
>>> I think among the first things, while enabling HDMI, should be to s=
ee
>>> if there is really some display connected on the port i.e, HPD
>>> asserted. Only if ti_hdmi_4_detect() returned true, should we
>>> proceed otherwise wait for HPQ irq.
>>>
>>> Unconditionally invalidating edid really seems like a regression - =
we
>>> impose atleast 50ms (edid read) as extra cost on
>>> hdmi_check_hpd_state(), which kills half the purpose of this patch.
>>>
>> Sorry a correction. Reading detect() won't work. I suggest we keep H=
PD
>> IRQ enabled for the lifetime of the driver.
>
> Ok, I see. But that's not acceptable. It would require us to keep the
> TPD12S015 always powered and enabled. Even if you're not interested i=
n
> using HDMI at all.
>
> For this to work like you want we need a bigger restructuring of HDMI
> and partly omapdss also. Currently we have just one big "enabled" or
> "disabled" state. We need multiple states. Probably something like:
>
> - disabled, everything totally off
> - low power, hotplug detection enabled
> - powered on, but no video
> - video enabled
>
> Been long in my mind, but I'm not very familiar with HDMI so I could =
get
> my simple prototypes to work when I tried something like this once.

That doesn't sound too hard since the difference between the first thre=
e=20
states at the HDMI chip is just whether the two gpio controlling it are=
=20
00, 10 or 11.

If Jassi's alright with it we might have a go at implementing this, but=
=20
can you define a bit more about how we logically tell DSS that we want=20
to, eg, disable HDMI totally?

-Andy

--=20
Andy Green | TI Landing Team Leader
Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  -=20
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
