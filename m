From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] omap1: Use asm_irq_flags for entry-macro.S
Date: Fri, 10 Dec 2010 09:44:08 -0800
Message-ID: <20101210174407.GV3054@atomide.com>
References: <20101204001435.28853.29616.stgit@baageli.muru.com>
 <20101208014548.GJ17435@atomide.com>
 <20101208014728.GK17435@atomide.com>
 <201012101706.24089.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:38900 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129Ab0LJRoU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Dec 2010 12:44:20 -0500
Content-Disposition: inline
In-Reply-To: <201012101706.24089.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [101210 08:06]:
> Wednesday 08 December 2010 02:47:28 Tony Lindgren napisa=C5=82(a):
> > Initialize asm_irq_flags in omap_init_irq and use it in
> > get_irqnr_and_base to detect between omap7xx and omap15xx/16xx.
> >
> > Note that both INT_1510_IH2_IRQ and INT_1510_IH2_IRQ are defined
> > as 0, so use INT_1510_IH2_IRQ for both of them.
>=20
> Tested on Amstrad Delta.
>=20
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
>=20
> Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Thanks, merging these into omap-for-linus.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
