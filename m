From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 3/3] OMAPDSS: HDMI: Cache EDID
Date: Thu, 28 Jun 2012 18:43:07 +0530
Message-ID: <CAJe_Zhdkhu4TciiwGJB2Kz8oZp2RQNZfESSr5Cfv0R1MNn=r9A@mail.gmail.com>
References: <1340805944-28805-1-git-send-email-jaswinder.singh@linaro.org>
	<1340869729.5037.7.camel@deskari>
	<CAJe_ZhcWSYhRWSW0v9OqsHRXASsQ8i2P8F8OS+jXkyadoRM9iA@mail.gmail.com>
	<1340878461.5037.30.camel@deskari>
	<CAJe_Zhc_ye1f=hOVd=AJ7rmCQ_vwDtjQOKsufPYmV1o-58jyAA@mail.gmail.com>
	<CAJe_ZhfehDquDcyefb7Z9odH+hfQTFiRAux_iyvAycs9Otovtw@mail.gmail.com>
	<1340881815.5037.53.camel@deskari>
	<4FEC47FA.1040801@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:38345 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108Ab2F1NNJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 09:13:09 -0400
Received: by lbbgm6 with SMTP id gm6so3085350lbb.19
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 06:13:07 -0700 (PDT)
In-Reply-To: <4FEC47FA.1040801@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy.green@linaro.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, n-dechesne@ti.com, patches@linaro.org

On 28 June 2012 17:33, Andy Green <andy.green@linaro.org> wrote:
> On 06/28/12 19:10, the mail apparently from Tomi Valkeinen included:
>
>> On Thu, 2012-06-28 at 16:28 +0530, Jassi Brar wrote:
>>>
>>> On 28 June 2012 16:17, Jassi Brar <jaswinder.singh@linaro.org> wrot=
e:
>>>>
>>>> On 28 June 2012 15:44, Tomi Valkeinen <tomi.valkeinen@ti.com> wrot=
e:
>>>>>
>>>>> On Thu, 2012-06-28 at 15:18 +0530, Jassi Brar wrote:
>>>>
>>>>
>>>>>>>> --- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
>>>>>>>> +++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
>>>>>>>> @@ -243,10 +243,13 @@ static int hdmi_check_hpd_state(struct
>>>>>>>> hdmi_ip_data *ip_data)
>>>>>>>>
>>>>>>>> =A0 =A0 =A0 hpd =3D gpio_get_value(ip_data->hpd_gpio);
>>>>>>>>
>>>>>>>> - =A0 =A0 if (hpd)
>>>>>>>> + =A0 =A0 if (hpd) {
>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D hdmi_set_phy_pwr(ip_data, HD=
MI_PHYPWRCMD_TXON);
>>>>>>>> - =A0 =A0 else
>>>>>>>> + =A0 =A0 } else {
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Invalidate EDID Cache */
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 ip_data->edid_len =3D 0;
>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D hdmi_set_phy_pwr(ip_data, HD=
MI_PHYPWRCMD_LDOON);
>>>>>>>> + =A0 =A0 }
>>>>>>>
>>>>>>>
>>>>>>> There's a problem with this patch, which leaves a wrong EDID in=
 the
>>>>>>> cache: if you first have the cable connected and hdmi is enable=
d, you
>>>>>>> then turn off the HDMI display device via sysfs, we do not go t=
o
>>>>>>> hdmi_check_hpd_state at all. The next time hdmi is enabled, we =
only
>>>>>>> get
>>>>>>> the plug-in event, and thus EDID cache is never invalidated.
>>>>>>>
>>>>>> If the hdmi cable is not replugged during that period, I don't s=
ee why
>>>>>> would you want the EDID invalidated ?
>>>>>
>>>>>
>>>>> I wasn't very clear with my comment.
>>>>>
>>>>> When the display device is disabled, we're not listening to the h=
pd
>>>>> interrupt anymore. So when it's disabled, the cable can be replug=
ged
>>>>> and
>>>>> the monitor changed, and the driver won't know about it. And so i=
t'll
>>>>> return the old EDID for the new monitor.
>>>>>
>>>> If that could be a problem, then we already have some problem with
>>>> current omapdss.
>>>>
>>>> I think among the first things, while enabling HDMI, should be to =
see
>>>> if there is really some display connected on the port i.e, HPD
>>>> asserted. Only if ti_hdmi_4_detect() returned true, should we
>>>> proceed otherwise wait for HPQ irq.
>>>>
>>>> Unconditionally invalidating edid really seems like a regression -=
 we
>>>> impose atleast 50ms (edid read) as extra cost on
>>>> hdmi_check_hpd_state(), which kills half the purpose of this patch=
=2E
>>>>
>>> Sorry a correction. Reading detect() won't work. I suggest we keep =
HPD
>>> IRQ enabled for the lifetime of the driver.
>>
>>
>> Ok, I see. But that's not acceptable. It would require us to keep th=
e
>> TPD12S015 always powered and enabled. Even if you're not interested =
in
>> using HDMI at all.
>>
>> For this to work like you want we need a bigger restructuring of HDM=
I
>> and partly omapdss also. Currently we have just one big "enabled" or
>> "disabled" state. We need multiple states. Probably something like:
>>
>> - disabled, everything totally off
>> - low power, hotplug detection enabled
>> - powered on, but no video
>> - video enabled
>>
>> Been long in my mind, but I'm not very familiar with HDMI so I could=
 get
>> my simple prototypes to work when I tried something like this once.
>
>
> That doesn't sound too hard since the difference between the first th=
ree
> states at the HDMI chip is just whether the two gpio controlling it a=
re 00,
> 10 or 11.
>
> If Jassi's alright with it we might have a go at implementing this, b=
ut can
> you define a bit more about how we logically tell DSS that we want to=
, eg,
> disable HDMI totally?
>
A quick reaction of my guts say, we simply enable 5V/HPD_IRQ during
probe and disable during remove.
HDMI enable/disable via /sysfs/ and HPD (de)assertion, switch only
HDMI_PHY on/off.
The user selecting "Autodetect and Configure" option would then equate
to "(un)loading" of the HDMI driver.
Not to mean a trivial job.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
