From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5] OMAP1: LCD_DMA: Use some define rather than a
 hexadecimal constant for LCD register
Date: Mon, 7 Dec 2009 13:15:31 -0800
Message-ID: <20091207211531.GH24013@atomide.com>
References: <20091116222517.GT3684@atomide.com>
 <20091117161058.GA29266@atomide.com>
 <200911242234.11705.jkrzyszt@tis.icnet.pl>
 <200912051449.30525.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56096 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964975AbZLGVP2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Dec 2009 16:15:28 -0500
Content-Disposition: inline
In-Reply-To: <200912051449.30525.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091205 05:48]:
> Tuesday 24 November 2009 22:34:10 Janusz Krzysztofik napisa=C5=82(a):
> > The patch corrects the issue introduced with one of my earlier patc=
hes:
> > 	OMAP: DMA: Fix omapfb/lcdc on OMAP1510 broken when PM set[1]
> > as pointed out by OMAP subsystem maintainer.
>=20
> Tony,
>=20
> I've noticed that you've marked this patch as Superseded in your patc=
hwork=20
> queue. This is not the case. It is still supposed to correct the issu=
e, now=20
> sitting in mach-omap1/lcd_dma.c after being moved from plat-omap/dma.=
c.

OK, thanks for letting me know. Adding it to for-next-vol2.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
