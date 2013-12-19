From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFT/RFC/PATCH 00/31] arm: omap: irq: cleanup INTC driver
Date: Thu, 19 Dec 2013 10:48:15 -0800
Message-ID: <20131219184815.GU27438@atomide.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:15718 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753547Ab3LSSsT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Dec 2013 13:48:19 -0500
Content-Disposition: inline
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [131120 10:10]:
> Afte these patches, we're very close to being able
> to move arch/arm/mach-omap2/irq.c to drivers/irqchip/irq-intc.c

That would be nice :)
=20
> All which would be missing is for Tony to drop all OMAP2/3 board
> files so we remove the few pending bits and pieces left in
> for legacy boot.

That may still need to wait a while, but let's see.
=20
> Note that I have only boot tested these on AM335x Bone Black
> (with a small fix for fixed regulator which should be in
> the mailing list already), so I'd need help testing all
> other impacted platforms, specially when it comes to PM.

Sorry have not had much of a chance to test these with PM with
all the fixes needed for omap3 DT mode. Tried testing these
just now, but I get:

arch/arm/mach-omap2/board-generic.c:134: error: =E2=80=98omap_intc_of_i=
nit=E2=80=99 undeclared here (not in a function)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
