From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [alsa-devel] ASoC related suspend problems on OMAP3
Date: Wed, 8 Feb 2012 18:19:38 +0200
Message-ID: <CANOLnOPkirGhw43u8sen9YDrsZH_g+HXsdOAefbNMkXEasifyQ@mail.gmail.com>
References: <CANOLnOMhetqt0ZCCfS0UwnfE0DxLhLhK9=7t0BaQ1SUsv0OWjw@mail.gmail.com>
	<20120208115132.GA25756@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47290 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753935Ab2BHQTk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 11:19:40 -0500
Received: by ghrr11 with SMTP id r11so308097ghr.19
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 08:19:40 -0800 (PST)
In-Reply-To: <20120208115132.GA25756@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: lrg@ti.com, alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>

On Wed, Feb 8, 2012 at 1:51 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Feb 08, 2012 at 02:34:38AM +0200, Grazvydas Ignotas wrote:
>> # aplay /dev/zero
>> ^C
>> # echo mem > /sys/power/state
>> [ =C2=A0104.404663] PM: suspend of devices complete after 78.794 mse=
cs
>> [ =C2=A0104.413909] PM: late suspend of devices complete after 3.021=
 msecs
>> [ =C2=A0106.601196] Powerdomain (per_pwrdm) didn't enter target stat=
e 1
>> [ =C2=A0106.607421] Powerdomain (core_pwrdm) didn't enter target sta=
te 1
>> [ =C2=A0106.613739] Could not enter target state in pm_suspend
>>
>> I'm seeing this on 3.2, unable to verify on current Linus HEAD as
>> something else is preventing core/per low power states there.
>> Any ideas what could be causing this? Perhaps some clock is left ena=
bled?

ok I've figured it out myself - it's because of McBSP2 clock source
selection. Pandora has rather unusual config (compared to other
boards) that it gets McBSP2 audio clock through external pin. As long
as it's set to PRCM functional clock (OMAP internal, reset default)
the system suspends fine, but if it's set to external,
per_pwrdm+core_pwrdm won't switch to lower power states.

Pandora sets this by calling snd_soc_dai_set_sysclk() from
snd_soc_ops.hw_params callback. Now I wonder, where should I set the
clock back so it suspends again, perhaps from snd_soc_ops.hw_free
callback? Or maybe it should be handled by omap-mcbsp ASoC driver,
perhaps something needs to be configured on McBSP itself for it to go
idle with external clock set?

--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
