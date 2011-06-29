From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 1/2] omap: mcbsp: Drop SPI mode support
Date: Wed, 29 Jun 2011 03:31:16 -0700
Message-ID: <20110629103116.GC23145@atomide.com>
References: <1308050632-4733-1-git-send-email-jhnikula@gmail.com>
 <6027329.5ZCJWRgjcM@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:24344 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751735Ab1F2KbW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jun 2011 06:31:22 -0400
Content-Disposition: inline
In-Reply-To: <6027329.5ZCJWRgjcM@barack>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* P=C3=A9ter Ujfalusi <peter.ujfalusi@ti.com> [110614 05:34]:
> On Tuesday 14 June 2011 13:23:51 Jarkko Nikula wrote:
> > We haven't seen any use for the SPI API in McBSP driver over the ye=
ars. More
> > over, Peter Ujfalusi <peter.ujfalusi@ti.com> noticed that SPI mode =
is not
> > even supported since OMAP2430 so it's very unlikely that we'll see =
any use
> > for it in the future either.
> >=20
> > Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
>=20
> Either now or later, but for both:
>=20
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Applying both of these into devel-cleanup branch.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
