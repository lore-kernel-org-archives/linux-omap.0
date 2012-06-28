From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 3/3] OMAPDSS: HDMI: Cache EDID
Date: Thu, 28 Jun 2012 16:28:17 +0530
Message-ID: <CAJe_ZhfehDquDcyefb7Z9odH+hfQTFiRAux_iyvAycs9Otovtw@mail.gmail.com>
References: <1340805944-28805-1-git-send-email-jaswinder.singh@linaro.org>
	<1340869729.5037.7.camel@deskari>
	<CAJe_ZhcWSYhRWSW0v9OqsHRXASsQ8i2P8F8OS+jXkyadoRM9iA@mail.gmail.com>
	<1340878461.5037.30.camel@deskari>
	<CAJe_Zhc_ye1f=hOVd=AJ7rmCQ_vwDtjQOKsufPYmV1o-58jyAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34768 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754409Ab2F1K6S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 06:58:18 -0400
Received: by lbbgm6 with SMTP id gm6so2934402lbb.19
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 03:58:17 -0700 (PDT)
In-Reply-To: <CAJe_Zhc_ye1f=hOVd=AJ7rmCQ_vwDtjQOKsufPYmV1o-58jyAA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com, patches@linaro.org

On 28 June 2012 16:17, Jassi Brar <jaswinder.singh@linaro.org> wrote:
> On 28 June 2012 15:44, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> On Thu, 2012-06-28 at 15:18 +0530, Jassi Brar wrote:
>
>>> >> --- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
>>> >> +++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
>>> >> @@ -243,10 +243,13 @@ static int hdmi_check_hpd_state(struct hdm=
i_ip_data *ip_data)
>>> >>
>>> >> =A0 =A0 =A0 hpd =3D gpio_get_value(ip_data->hpd_gpio);
>>> >>
>>> >> - =A0 =A0 if (hpd)
>>> >> + =A0 =A0 if (hpd) {
>>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D hdmi_set_phy_pwr(ip_data, HDMI=
_PHYPWRCMD_TXON);
>>> >> - =A0 =A0 else
>>> >> + =A0 =A0 } else {
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* Invalidate EDID Cache */
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 ip_data->edid_len =3D 0;
>>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D hdmi_set_phy_pwr(ip_data, HDMI=
_PHYPWRCMD_LDOON);
>>> >> + =A0 =A0 }
>>> >
>>> > There's a problem with this patch, which leaves a wrong EDID in t=
he
>>> > cache: if you first have the cable connected and hdmi is enabled,=
 you
>>> > then turn off the HDMI display device via sysfs, we do not go to
>>> > hdmi_check_hpd_state at all. The next time hdmi is enabled, we on=
ly get
>>> > the plug-in event, and thus EDID cache is never invalidated.
>>> >
>>> If the hdmi cable is not replugged during that period, I don't see =
why
>>> would you want the EDID invalidated ?
>>
>> I wasn't very clear with my comment.
>>
>> When the display device is disabled, we're not listening to the hpd
>> interrupt anymore. So when it's disabled, the cable can be replugged=
 and
>> the monitor changed, and the driver won't know about it. And so it'l=
l
>> return the old EDID for the new monitor.
>>
> If that could be a problem, then we already have some problem with
> current omapdss.
>
> I think among the first things, while enabling HDMI, should be to see
> if there is really some display connected on the port i.e, HPD
> asserted. Only if ti_hdmi_4_detect() returned true, should we
> proceed otherwise wait for HPQ irq.
>
> Unconditionally invalidating edid really seems like a regression - we
> impose atleast 50ms (edid read) as extra cost on
> hdmi_check_hpd_state(), which kills half the purpose of this patch.
>
Sorry a correction. Reading detect() won't work. I suggest we keep HPD
IRQ enabled for the lifetime of the driver.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
