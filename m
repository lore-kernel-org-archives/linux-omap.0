From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 3/3] OMAPDSS: HDMI: Cache EDID
Date: Thu, 28 Jun 2012 15:18:00 +0530
Message-ID: <CAJe_ZhcWSYhRWSW0v9OqsHRXASsQ8i2P8F8OS+jXkyadoRM9iA@mail.gmail.com>
References: <1340805944-28805-1-git-send-email-jaswinder.singh@linaro.org>
	<1340869729.5037.7.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:62086 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932243Ab2F1JsB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 05:48:01 -0400
Received: by lbbgm6 with SMTP id gm6so2856900lbb.19
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 02:48:00 -0700 (PDT)
In-Reply-To: <1340869729.5037.7.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com, patches@linaro.org

On 28 June 2012 13:18, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Wed, 2012-06-27 at 19:35 +0530, jaswinder.singh@linaro.org wrote:
>> From: Jassi Brar <jaswinder.singh@linaro.org>
>>
>> We can easily keep track of latest EDID from the display and hence a=
void
>> expensive EDID re-reads over I2C.
>> This could also help some cheapo displays that provide EDID reliably=
 only
>> immediately after asserting HPD and not later.
>> Even with good displays, there is something in OMAPDSS that apparant=
ly
>> messes up DDC occasionally while EDID is being read, giving the
>> =A0 "operation stopped when reading edid" error.
>
> Btw, this is in nitpicking area, but what editor do you use? I find i=
t
> difficult to read text that is not formatted properly =3D). At least =
vim
> formats text nicely with its formating commands.
>
Indeed a nitpick :)
I use vim and, iirc, checkpatch.pl gave 0 warning. Perhaps my poor
cmoposition. Please do tell how I could I make it more appealing to
you ?

>> --- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
>> +++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
>> @@ -243,10 +243,13 @@ static int hdmi_check_hpd_state(struct hdmi_ip=
_data *ip_data)
>>
>> =A0 =A0 =A0 hpd =3D gpio_get_value(ip_data->hpd_gpio);
>>
>> - =A0 =A0 if (hpd)
>> + =A0 =A0 if (hpd) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D hdmi_set_phy_pwr(ip_data, HDMI_PHY=
PWRCMD_TXON);
>> - =A0 =A0 else
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Invalidate EDID Cache */
>> + =A0 =A0 =A0 =A0 =A0 =A0 ip_data->edid_len =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D hdmi_set_phy_pwr(ip_data, HDMI_PHY=
PWRCMD_LDOON);
>> + =A0 =A0 }
>
> There's a problem with this patch, which leaves a wrong EDID in the
> cache: if you first have the cable connected and hdmi is enabled, you
> then turn off the HDMI display device via sysfs, we do not go to
> hdmi_check_hpd_state at all. The next time hdmi is enabled, we only g=
et
> the plug-in event, and thus EDID cache is never invalidated.
>
If the hdmi cable is not replugged during that period, I don't see why
would you want the EDID invalidated ?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
