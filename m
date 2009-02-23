From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP: HSMMC: Initialize hsmmc controller registers when  resuming
Date: Mon, 23 Feb 2009 10:30:24 -0800
Message-ID: <200902231030.25137.david-b@pacbell.net>
References: <4d34a0a70902200400s252f48ddvfd6e0d83e91fa291@mail.gmail.com> <49A258A2.2020408@nokia.com> <9c9fda240902230426s2003d208xebeb6630c61b3bec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:21264 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753647AbZBWSa2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Feb 2009 13:30:28 -0500
In-Reply-To: <9c9fda240902230426s2003d208xebeb6630c61b3bec@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>, Adrian Hunter <ext-adrian.hunter@nokia.com>
Cc: Kim Kyuwon <chammoru@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "drzeus-mmc@drzeus.cx" <drzeus-mmc@drzeus.cx>, =?utf-8?q?=EA=B9=80=EA=B7=9C=EC=9B=90?= <q1.kim@samsung.com>

On Monday 23 February 2009, Kyungmin Park wrote:
> > Although I have not tested it, I very much doubt
> > dual-voltage cards work. =A0That is because VMMC1_185V
> > is zero, which has the side-effect of turning the
> > regulator off (see arch/arm/mach-omap2/mmc-twl4030.c)

Right, looks like a longstanding bug in that glue.
So IMO, no rush to fix for 2.6.29-rc ...


> It's also to difficult to test in our H/W since it's configured only
> support 3.0V.

Easily tested with a Beagle or SDP though, if you
have a 1.8V or dual-voltage card (maybe RS-MMC, as
for an N770 tablet).


> How about to separate it two phases, first fix the mmc suspend/resume
> works again, and then verify dual voltage if there are these hardware

Well, two patches for sure; I don't know that the order
will matter.  I just sent a patch fixing that code in
the current OMAP git tree, which has some fixes that are
scheduled to merge for 2.6.30-rc.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
