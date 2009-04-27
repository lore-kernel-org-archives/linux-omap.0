From: David Brownell <david-b@pacbell.net>
Subject: Re: Card detect IRQ errors
Date: Mon, 27 Apr 2009 02:56:15 -0700
Message-ID: <200904270256.15871.david-b@pacbell.net>
References: <6ed0b2680904270213s6ef02ad6i26173245019bca15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:21677 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757274AbZD0J4S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Apr 2009 05:56:18 -0400
In-Reply-To: <6ed0b2680904270213s6ef02ad6i26173245019bca15@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>, lkml <linux-kernel@vger.kernel.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Monday 27 April 2009, Grazvydas Ignotas wrote:
>=20
> With current l-o head when I insert or remove SD card I'm getting thi=
s:
>=20
> [ =A0 20.733489] ------------[ cut here ]------------
> [ =A0 20.738159] WARNING: at kernel/irq/handle.c:366 handle_IRQ_event=
+0x4c/0x14c()
> [ =A0 20.745330] BUG: IRQ handler called from non-hardirq
> context!Modules linked in:
> ...
> [ =A0 20.822753] ---[ end trace 2ca2d8ba630dd6b5 ]---
> [ =A0 20.869415] mmc0: card 8001 removed
>=20
> Has anyone else seen this?

Regresssion caused by 044d408409cc4e1bc75c886e27ca85c270db104c.

Notice the message is internally broken, too -- no newline.

Try reverting that, things will still behave just fine.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
