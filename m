From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch twl] twl4030-core -- more cleanups
Date: Fri, 3 Oct 2008 07:09:19 -0700
Message-ID: <200810030709.19790.david-b@pacbell.net>
References: <200810021221.20286.david-b@pacbell.net> <200810030115.54197.david-b@pacbell.net> <EAF47CD23C76F840A9E7FCE10091EFAB028C5402D4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:23441 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751682AbYJCOJ1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 10:09:27 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB028C5402D4@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday 03 October 2008, Pakaravoor, Jagadeesh wrote:
> > (And then there's the way every SIH handler seems to
> > be getting its own irq_chip and handler thread. =A0I'm
> > sure that can be done much better.)
>=20
> So, is there going to be a change in the current way,
> of spawning a separate thread, for power and gpio irqs?

I'm thinking about it.  Notice the core has twl4030_mod_regs,
which is almost enough to take over irq_chip duties by itself.
And it also has a thread handy ...=20

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
