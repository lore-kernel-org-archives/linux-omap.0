From: David Brownell <david-b@pacbell.net>
Subject: RE: Re: omap_musb_board_data -- trouble specifying 500mA supply
Date: Sat, 22 May 2010 07:04:20 -0700 (PDT)
Message-ID: <188600.31899.qm@web180315.mail.gq1.yahoo.com>
References: <19F8576C6E063C45BE387C64729E7394044E6162B3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n1-vm1.bullet.mail.gq1.yahoo.com ([67.195.23.153]:43259 "HELO
	n1-vm1.bullet.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754080Ab0EVOEV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 22 May 2010 10:04:21 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E6162B3@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Users <linux-omap@vger.kernel.org>, Ajay KumarGupta <ajay.gupta@ti.com>
Cc: Cliff Brake <cliff.brake@gmail.com>


> Actually in OMAP board files, power values have been
> provided
> With units of 1mA 

Everywhere (!!) in the Linux-USB stack, those units
should be 2mA (just like in config descriptors) ...

which gets divided to half in
> arch/arm/mach-omap2/usb-musb.c

... which is why there's a divide-by-two there.


 before sending it to musb
> driver.

... the divide-by-two should only be skipped when
talking to power supplies or regulators, which don't
have USB conventions to be concerned with.

Looks like some board files need bugfixing.

- Dave


