From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: AM335x USB DMA seems broken on ISOC URBs
Date: Fri, 17 Jan 2014 13:27:24 -0300
Message-ID: <20140117162723.GB3843@localhost>
References: <20131222055945.GA7194@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:56784 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751701AbaAQQ1M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jan 2014 11:27:12 -0500
Content-Disposition: inline
In-Reply-To: <20131222055945.GA7194@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

On Sun, Dec 22, 2013 at 02:59:45AM -0300, Ezequiel Garcia wrote:
> Hello,
>=20
> While doing some experiments with the stk1160 driver (for "Easycap" T=
V video
> capture devices), ran into problems using v3.13-rc4. The problem is t=
hat the
> stk1160 IRQ handler receives no URBs at all.
>=20
> When configuring with CONFIG_MUSB_PIO_ONLY this looks solved, but the
> bandwidth requirements are too large for PIO (it's a raw video device=
) and the
> video can't get captured.
>=20
> Interesting enough, using an old backported for v3.2 stk1160 driver, =
this same
> setup works with TI PSP v3.2 kernel. So, I guess it's some software b=
ug in
> either the cppi41 dmaengine or the musb.
>=20
> I tried to compare the PSP to the mainline drivers but they seems *ve=
ry*
> different and really beyond my understanding.
>=20
> Any ideas on how can I help debugging this?
>=20

Ping? It would be good to hunt thig bug down. The TI PSP provided USB d=
river
works fine so at least that's a starting point...

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
