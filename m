From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH] omap: dma: Clear status registers on enable/disable irq.
Date: Fri, 04 May 2012 21:39:32 +0200
Message-ID: <1633215.yCrxk1mQVq@acer>
References: <1334954578-10478-1-git-send-email-oleg.matcovschi@ti.com> <20120504165146.GB5613@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:56364 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754148Ab2EDTmV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 15:42:21 -0400
In-Reply-To: <20120504165146.GB5613@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Oleg Matcovschi <oleg.matcovschi@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, Jarkko Nikula <jarkko.nikula@bitmer.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>

Dnia pi=C4=85tek, 4 maja 2012 09:51:46 Tony Lindgren pisze:
> Hi,
>=20
> * Oleg Matcovschi <oleg.matcovschi@ti.com> [120420 13:49]:
> > Use omap_disable_channel_irq() function instead of directly=20
accessing CICR.
> > The omap_disable_chanel_irq() function clears pending interrupts
> > and disables interrupt on channel.
> > Functions omap2_enable_irq_lch()/omap2_disable_irq_lch() clear=20
interrupt
> > status register.
>=20
> This seems like a nice fix to me. As it affects all omaps, I'd like t=
o
> see some tested-by from Janusz/Jarkko/Peter. Can you guys give it a=20
try
> with some audio tests?

OK, I can do, but perhaps not before next Saturday, when I'm back home,=
=20
able to actually listen to the audio, not only watch the IRQ counters=20
rising up ;-).

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
