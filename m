From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: io: Fix namespace conflicts.
Date: Tue, 23 Nov 2010 19:15:58 +0000
Message-ID: <20101123191558.GB26510@n2100.arm.linux.org.uk>
References: <1286967121-5888-1-git-send-email-charu@ti.com> <20101123140116.GP4693@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48830 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033Ab0KWTQM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Nov 2010 14:16:12 -0500
Content-Disposition: inline
In-Reply-To: <20101123140116.GP4693@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Sourav Poddar <sourav.poddar@ti.com>

On Tue, Nov 23, 2010 at 03:01:17PM +0100, Uwe Kleine-K=F6nig wrote:
> I wonder if it's not better to make these static inlines instead.  Th=
en
> no naming conflicts can occur.  And maybe we'd catch some more strang=
e
> things because p gets a proper type.
>=20
> I don't know how this influences gcc though.

See my email about how code changes affect the optimization of complete=
ly
unrelated functions.  Someone pointed out that the problem has been
reported on x86, and GCC people say that it's intentional.

That makes it almost impossible to evaluate whether making these inline
functions is a net benefit or net loss as there is too much noise from
such a change.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
