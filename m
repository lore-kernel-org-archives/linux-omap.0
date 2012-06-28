From: Andy Green <andy.green@linaro.org>
Subject: Re: [PATCH 3/3] OMAPDSS: HDMI: Cache EDID
Date: Thu, 28 Jun 2012 20:15:56 +0800
Message-ID: <4FEC4AFC.6060400@linaro.org>
References: <1340805944-28805-1-git-send-email-jaswinder.singh@linaro.org>  <1340869729.5037.7.camel@deskari>  <CAJe_ZhcWSYhRWSW0v9OqsHRXASsQ8i2P8F8OS+jXkyadoRM9iA@mail.gmail.com>  <1340878461.5037.30.camel@deskari>  <CAJe_Zhc_ye1f=hOVd=AJ7rmCQ_vwDtjQOKsufPYmV1o-58jyAA@mail.gmail.com>  <CAJe_ZhfehDquDcyefb7Z9odH+hfQTFiRAux_iyvAycs9Otovtw@mail.gmail.com>  <1340881815.5037.53.camel@deskari> <1340883482.5037.56.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:51307 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752126Ab2F1MQH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 08:16:07 -0400
In-Reply-To: <1340883482.5037.56.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, n-dechesne@ti.com, patches@linaro.org

On 06/28/12 19:38, the mail apparently from Tomi Valkeinen included:
> On Thu, 2012-06-28 at 14:10 +0300, Tomi Valkeinen wrote:
>> On Thu, 2012-06-28 at 16:28 +0530, Jassi Brar wrote:
>
>>> Sorry a correction. Reading detect() won't work. I suggest we keep =
HPD
>>> IRQ enabled for the lifetime of the driver.
>>
>> Ok, I see. But that's not acceptable. It would require us to keep th=
e
>> TPD12S015 always powered and enabled. Even if you're not interested =
in
>> using HDMI at all.
>
> Btw, a bigger problem that I see is how we have to do read_edid() (an=
d
> detect(), if I recall correctly): we enable the whole video pipeline =
and
> output. We should only enable enough of the HW to be able to read the
> EDID or read the HPD GPIO.
>
> I've noticed that this leads to sync losts quite easily, as we switch
> the hdmi output on and off quickly multiple times. I couldn't figure =
out
> why the sync losts happen though, and I did try quite many different
> combinations how to handle it.

SYNC LOST is one evil lurking in there, the other evil is EDID fetch=20
"operation stopped" error.  We were unable to figure out what was=20
trampling on what there without the SoC HDMI PHY IP data which we don't=
=20
have.

Also at the moment I think we depower / repower the internal SoC and=20
external PHY chip more than we need.  Each time we remove the HDMI link=
=20
power, after a short time where the big capacitor at the charge pump=20
output decays enough (a time dependent on exact details of load=20
presented by the TV or monitor...), hpd from the monitor goes low and=20
remains there until we power the charge pump again.  In turn the new hp=
d=20
recognition provokes a new edid fetch.  Something about that sequence=20
provokes the "operation stopped" on EDID fetch, with Jassi's patches we=
=20
manage to avoid it.

Removing that syndrome, and just not enabling and disabling stuff like=20
SoC HDMI PHY willy nilly can maybe be something else targeted by this=20
proposed 4-state power scheme.

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
