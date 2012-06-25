From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] OMAPDSS: HDMI: Cache EDID
Date: Mon, 25 Jun 2012 13:26:47 +0530
Message-ID: <CAJe_Zhf1RsDtKXOpQ97Am-ByBYUtOgjJYyySGYGL9zHNYB_Ejw@mail.gmail.com>
References: <1340438806-25622-1-git-send-email-jaswinder.singh@linaro.org>
	<1340606154.12683.34.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:63381 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709Ab2FYH4t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Jun 2012 03:56:49 -0400
Received: by lbbgm6 with SMTP id gm6so6150421lbb.19
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 00:56:48 -0700 (PDT)
In-Reply-To: <1340606154.12683.34.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com

On 25 June 2012 12:05, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Sat, 2012-06-23 at 13:36 +0530, jaswinder.singh@linaro.org wrote:
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
>>
>> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
>> ---
>> =A0drivers/video/omap2/dss/hdmi.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 =
+
>> =A0drivers/video/omap2/dss/ti_hdmi.h =A0 =A0 =A0 =A0 | =A0 =A02 ++
>> =A0drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c | =A0 23 ++++++++++++++=
++++++---
>> =A03 files changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/ds=
s/hdmi.c
>> index 900e621..0a8c825 100644
>> --- a/drivers/video/omap2/dss/hdmi.c
>> +++ b/drivers/video/omap2/dss/hdmi.c
>> @@ -764,6 +764,7 @@ static int __init omapdss_hdmihw_probe(struct pl=
atform_device *pdev)
>> =A0 =A0 =A0 hdmi.ip_data.core_av_offset =3D HDMI_CORE_AV;
>> =A0 =A0 =A0 hdmi.ip_data.pll_offset =3D HDMI_PLLCTRL;
>> =A0 =A0 =A0 hdmi.ip_data.phy_offset =3D HDMI_PHY;
>> + =A0 =A0 hdmi.ip_data.edid_len =3D 0; /* Invalidate EDID Cache */
>> =A0 =A0 =A0 mutex_init(&hdmi.ip_data.lock);
>
> Your HDMI patches seem to depend on each other. Please post them as a
> proper patch series, instead of each one separately.
>
They don't depend functionality wise. Any fix can be accepted
regardless of others.
I deliberately avoided a series, because revision of just one could
require resending 3, otherwise
perfectly OK, patches. I just wanted to limit the noise.
I understand, 'git am' might complain but I think that should be trivia=
l to fix.
I am perfectly OK to resend as a patch series, if you want.

>> =A0 =A0 =A0 hdmi_panel_init();
>> diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2=
/dss/ti_hdmi.h
>> index cc292b8..4735860 100644
>> --- a/drivers/video/omap2/dss/ti_hdmi.h
>> +++ b/drivers/video/omap2/dss/ti_hdmi.h
>> @@ -178,6 +178,8 @@ struct hdmi_ip_data {
>> =A0 =A0 =A0 /* ti_hdmi_4xxx_ip private data. These should be in a se=
parate struct */
>> =A0 =A0 =A0 int hpd_gpio;
>> =A0 =A0 =A0 struct mutex lock;
>> + =A0 =A0 u8 edid_cached[256];
>> + =A0 =A0 unsigned edid_len;
>> =A0};
>> =A0int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data);
>> =A0void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data);
>> diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/vid=
eo/omap2/dss/ti_hdmi_4xxx_ip.c
>> index 04acca9..2633ade 100644
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
>>
>> =A0 =A0 =A0 if (r) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("Failed to %s PHY TX power\n",
>> @@ -454,6 +457,11 @@ int ti_hdmi_4xxx_read_edid(struct hdmi_ip_data =
*ip_data,
>> =A0{
>> =A0 =A0 =A0 int r, l;
>>
>> + =A0 =A0 if (ip_data->edid_len) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 memcpy(edid, ip_data->edid_cached, ip_data=
->edid_len);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ip_data->edid_len;
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 if (len < 128)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>
>> @@ -474,12 +482,21 @@ int ti_hdmi_4xxx_read_edid(struct hdmi_ip_data=
 *ip_data,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 l +=3D 128;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 ip_data->edid_len =3D l;
>> + =A0 =A0 memcpy(ip_data->edid_cached, edid, l);
>> +
>> =A0 =A0 =A0 return l;
>> =A0}
>>
>> =A0bool ti_hdmi_4xxx_detect(struct hdmi_ip_data *ip_data)
>> =A0{
>> - =A0 =A0 return gpio_get_value(ip_data->hpd_gpio);
>> + =A0 =A0 if (gpio_get_value(ip_data->hpd_gpio))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return true;
>> +
>> + =A0 =A0 /* Invalidate EDID Cache */
>> + =A0 =A0 ip_data->edid_len =3D 0;
>> +
>> + =A0 =A0 return false;
>
> Why is this needed? The HPD interrupt should handle this already. And=
 if
> the HPD interrupt doesn't work for some reason, this won't work eithe=
r,
> as the user can plug and unplug his HDMI monitors a thousand times
> between two detect calls.
>
I thought it is almost impossible to unplug->plug cycle the HDMI cable
even twice a second, let alone 1000 times against the 10Hz .detect()
poll  :)    Or you mean some relay controlled HDMI switching
mechanism?

 Anyways, that is not the point of this patch. This patch only aims to
avoid un-ncessary EDID reads while doing its best to make sure we
invalidate EDID 'as soon as possible'.

Thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
