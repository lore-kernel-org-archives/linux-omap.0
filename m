From: Ilkka Koskinen <ikoskine@nokia.com>
Subject: Re: [PATCHv2 1/2] McBSP: OMAP3: Add sidetone feature
Date: Thu, 18 Feb 2010 12:58:55 +0200 (EET)
Message-ID: <alpine.DEB.2.00.1002181244400.13895@tumpelo.nmp.nokia.com>
References: <1266417960-22787-1-git-send-email-ilkka.koskinen@nokia.com> <1266417960-22787-2-git-send-email-ilkka.koskinen@nokia.com> <20100218002543.GG21755@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:17155 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757Ab0BRK5l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 05:57:41 -0500
In-Reply-To: <20100218002543.GG21755@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: "Koskinen Ilkka (Nokia-D/Tampere)" <ilkka.koskinen@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "jhnikula@gmail.com" <jhnikula@gmail.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>


Hi,

On Thu, 18 Feb 2010, ext Tony Lindgren wrote:
> * Ilkka Koskinen <ilkka.koskinen@nokia.com> [100217 06:41]:
>> From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
>>
>> Add sidetone feature to McBSP instances 2 and 3 on OMAP3 based devices.
>>
>> Signed-off-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
>
> This one looks good to me and can be merged via Alsa list along with
> the other patch.
>
> Acked-by: Tony Lindgren <tony@atomide.com>

Is that easiest way to do that? I mean, I'm afraid that the ALSA tree 
doesn't have Janusz Krzysztofik's McBSP register cache patches nor does it 
have your "omap3: Replace ARCH_OMAP34XX with ARCH_OMAP3" patch either.

Anyway, I'll send the updated patches still today.

Cheers, Ilkka
