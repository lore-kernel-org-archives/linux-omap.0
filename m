From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/5] ASoC: OMAP2+: Update Audio IP with sDMA binding for
 DT boot
Date: Fri, 8 Mar 2013 10:23:41 +0100
Message-ID: <5139AE1D.3080102@ti.com>
References: <1362660204-27074-1-git-send-email-s-guiriec@ti.com> <51389023.2000907@ti.com> <20130308092543.c355b2c6235c297efbe162e0@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36384 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933331Ab3CHJXx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Mar 2013 04:23:53 -0500
In-Reply-To: <20130308092543.c355b2c6235c297efbe162e0@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Sebastien Guiriec <s-guiriec@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, =?ISO-8859-1?Q?Beno=EE?= =?ISO-8859-1?Q?t_Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

On 03/08/2013 08:25 AM, Jarkko Nikula wrote:
>> The content of the patches looks about right for me, however I would
>> squash together the IP and platform driver patches so we avoid break=
age
>> within the series. Also I would put the patch for the .dtsi files as
>> first one.
>>=20
> Looks ok to me too at quick look. Would it be possible to avoid possi=
ble
> breakage if first patch is divided to omap-pcm.h change which come be=
fore
> audio link driver changes and do omap-pcm.c change last?

If we have them as separate we will have runtime regression between the
patches. It is better to have them squashed together.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
