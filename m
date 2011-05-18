From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] OMAP4: McBSP: Clear rx_irq at probe time
Date: Wed, 18 May 2011 08:52:07 +0300
Message-ID: <201105180852.08264.peter.ujfalusi@ti.com>
References: <1305628420-10592-1-git-send-email-peter.ujfalusi@ti.com> <20110517152954.477365e6.jhnikula@gmail.com> <20110517125700.GY5323@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46516 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753427Ab1ERFwN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 01:52:13 -0400
In-Reply-To: <20110517125700.GY5323@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>

On Tuesday 17 May 2011 15:57:00 Tony Lindgren wrote:
> This file should be under drivers/ somewhere, can you
> guys please take care of that?

Yeah, this has been discussed several times, and we have not reached ag=
reement=20
where to move this very OMAP specific code.
One option was to move it under sound/soc/omap/ , since currently the o=
nly=20
user for mcbsp is audio.
But McBSP is really versatile beast, it can be used for other things (f=
or=20
example it can handle SPI bus as well), so if we move it under ASoC, we=
 are=20
going to limit/block other use of these pins.
We can not just cp arc/arm/plat-omap/mcbsp.c drivers/wherever...
If we do that, we need to move it under some framework, or create a new=
 one=20
(bus driver?), which might be a bit tricky since we have special use of=
 McBSP=20
from audio side, this does not really fit the bus mode. Other uses of M=
cBSP=20
might be happy with the bus driver conversion, but we just do not have =
those.

IMHO the only place we can move this is under sound/soc/omap/ , but who=
 can=20
decide, that the McBSP can only be used for audio??

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
