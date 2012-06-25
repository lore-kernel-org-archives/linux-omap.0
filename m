From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] OMAPDSS: HDMI: Cache EDID
Date: Mon, 25 Jun 2012 14:34:34 +0530
Message-ID: <CAJe_Zhe9aeN1WiMUPTwDtBMs0fUEse-XXTBTqf70bfJcPqw91g@mail.gmail.com>
References: <1340438806-25622-1-git-send-email-jaswinder.singh@linaro.org>
	<1340606154.12683.34.camel@lappyti>
	<CAJe_Zhf1RsDtKXOpQ97Am-ByBYUtOgjJYyySGYGL9zHNYB_Ejw@mail.gmail.com>
	<1340611895.3395.14.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:41634 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842Ab2FYJEf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Jun 2012 05:04:35 -0400
Received: by lbbgm6 with SMTP id gm6so6221885lbb.19
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 02:04:34 -0700 (PDT)
In-Reply-To: <1340611895.3395.14.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com

On 25 June 2012 13:41, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
>> I am perfectly OK to resend as a patch series, if you want.
>
> Yes please.
>
OK, will do.

>> >> =A0bool ti_hdmi_4xxx_detect(struct hdmi_ip_data *ip_data)
>> >> =A0{
>> >> - =A0 =A0 return gpio_get_value(ip_data->hpd_gpio);
>> >> + =A0 =A0 if (gpio_get_value(ip_data->hpd_gpio))
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return true;
>> >> +
>> >> + =A0 =A0 /* Invalidate EDID Cache */
>> >> + =A0 =A0 ip_data->edid_len =3D 0;
>> >> +
>> >> + =A0 =A0 return false;
>> >
>> > Why is this needed? The HPD interrupt should handle this already. =
And if
>> > the HPD interrupt doesn't work for some reason, this won't work ei=
ther,
>> > as the user can plug and unplug his HDMI monitors a thousand times
>> > between two detect calls.
>> >
>> I thought it is almost impossible to unplug->plug cycle the HDMI cab=
le
>> even twice a second, let alone 1000 times against the 10Hz .detect()
>> poll =A0:) =A0 =A0Or you mean some relay controlled HDMI switching
>> mechanism?
>
> omapdss doesn't call the detect function, so it can't presume it's us=
ed
> in some certain frequency. Also, last time I tested omapdrm, I think
> detect was called once in 5 secs or so.
>
It's not omapdss.  It's the DRM stack, via the omapdrm, that polls
every 10 secs (not 5).
Sorry I said 10Hz instead of 1/10Hz.

>> =A0Anyways, that is not the point of this patch. This patch only aim=
s to
>> avoid un-ncessary EDID reads while doing its best to make sure we
>> invalidate EDID 'as soon as possible'.
>
> I'm not sure I understand your point. If the HPD interrupt works
> properly, EDID is invalidated there, and the code in detect is not
> needed. And if the HPD interrupt doesn't work (although I don't see w=
hy
> it wouldn't), the code in detect doesn't work. In either case it's no=
t
> correct.
>
Well, the idea was to tie edid-cache invalidating with de-asserted
HPD, wherever we read HPD. I will drop it.

thnx
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
