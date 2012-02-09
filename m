From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [alsa-devel] ASoC related suspend problems on OMAP3
Date: Thu, 09 Feb 2012 10:59:38 +0200
Message-ID: <4F338AFA.4000204@ti.com>
References: <CANOLnOMhetqt0ZCCfS0UwnfE0DxLhLhK9=7t0BaQ1SUsv0OWjw@mail.gmail.com> <20120208115132.GA25756@sirena.org.uk> <CANOLnOPkirGhw43u8sen9YDrsZH_g+HXsdOAefbNMkXEasifyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:53903 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750810Ab2BII7h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 03:59:37 -0500
Received: by lahi5 with SMTP id i5so1742096lah.18
        for <linux-omap@vger.kernel.org>; Thu, 09 Feb 2012 00:59:34 -0800 (PST)
In-Reply-To: <CANOLnOPkirGhw43u8sen9YDrsZH_g+HXsdOAefbNMkXEasifyQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@ti.com, alsa-devel@alsa-project.org, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>

On 02/08/2012 06:19 PM, Grazvydas Ignotas wrote:
> ok I've figured it out myself - it's because of McBSP2 clock source
> selection. Pandora has rather unusual config (compared to other
> boards) that it gets McBSP2 audio clock through external pin. As long
> as it's set to PRCM functional clock (OMAP internal, reset default)
> the system suspends fine, but if it's set to external,
> per_pwrdm+core_pwrdm won't switch to lower power states.
>=20
> Pandora sets this by calling snd_soc_dai_set_sysclk() from
> snd_soc_ops.hw_params callback. Now I wonder, where should I set the
> clock back so it suspends again, perhaps from snd_soc_ops.hw_free
> callback? Or maybe it should be handled by omap-mcbsp ASoC driver,
> perhaps something needs to be configured on McBSP itself for it to go
> idle with external clock set?

I assume this worked in the past on pandora (suspend), right?

Can you try one _hack_ to see if it helps?
In omap_mcbsp_request function:
set the CLOCKACTIVITY field to 0x3 in the sysconfig register.
Or you can as well try to do the same in
mach-omap2/omap_hwmod_3xxx_data.c, look for omap3xxx_mcbsp_sysc, and
change the .clockact =3D 0x2 to 0x3.

Not sure if this helps, but I would be interested to see the results...

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
