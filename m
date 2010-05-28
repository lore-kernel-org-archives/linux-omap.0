From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ARM: OMAP: Fix board data to support device only, host  only and OTG roles.
Date: Fri, 28 May 2010 11:32:44 -0700 (PDT)
Message-ID: <987022.25256.qm@web180303.mail.gq1.yahoo.com>
References: <AANLkTim7r5zq-G8iF1fxHQ9ohqfoOiuUkkMXfRYxkBQu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n23a.bullet.mail.mud.yahoo.com ([68.142.207.189]:33369 "HELO
	n23a.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752627Ab0E1Scq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 May 2010 14:32:46 -0400
In-Reply-To: <AANLkTim7r5zq-G8iF1fxHQ9ohqfoOiuUkkMXfRYxkBQu@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap@vger.kernel.org, Maulik Mankad <x0082077@ti.com>, linux-usb@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>

--- On Fri, 5/28/10, Steve Sakoman <sakoman@gmail.com> wrote:

> > By the way ... the #ifdeffery should indeed vanish
> from all board
> > configs except the Davinci DM6446 EVM. =A0That board is
> kind of quirky
> > in terms of USB support, and needs jumpering to get
> host or peripheral mode (and can't do OTG).


> For Overo this patch actually makes quite a bit of sense
> (and I have
> been using something similar for quite some time).
>=20
> The Overo COM itself has no USB connector -- the customer
> can choose
> or create a daughter card with the type of USB connector
> appropriate> to their application,

So that would be another exception ... because it doesn't
have a fixed USB connector (and thus does not convey to
users any specific details about what modes it supports).

- Dave


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
