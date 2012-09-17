From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [alsa-devel] [PATCH v3 00/15] ASoC: OMAP: Convert to use dmaengine
Date: Mon, 17 Sep 2012 11:44:48 +0300
Message-ID: <5056E300.809@ti.com>
References: <1347624358-25582-1-git-send-email-peter.ujfalusi@ti.com> <1347851866.1943.126.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:47187 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755103Ab2IQIn7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Sep 2012 04:43:59 -0400
Received: by obbuo13 with SMTP id uo13so8645009obb.19
        for <linux-omap@vger.kernel.org>; Mon, 17 Sep 2012 01:43:58 -0700 (PDT)
In-Reply-To: <1347851866.1943.126.camel@vkoul-udesk3>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, Ricardo Neri <ricardo.neri@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dan Williams <djbw@fb.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>

Hi Vinod,

On 09/17/2012 06:17 AM, Vinod Koul wrote:
> On Fri, 2012-09-14 at 15:05 +0300, Peter Ujfalusi wrote:
>> Hello,
>=20
> dmaengine parts look good to me. How do you want to get this merged,
> dmaengine or ASoC tree?

Thank you, I would prefer it to go via ASoC if it is not a problem. It =
is
possible to separate the dmaengine core related patches and the patches=
 for
the OMAP drivers but I think it is better to keep them together so we c=
an have
them in a same tree for testing it further.

Regards,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
