From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 1/5] ARM: omap/fb: move omap_init_fb to .init.text
Date: Thu, 09 Sep 2010 11:40:00 +0300
Message-ID: <1284021600.13006.16.camel@tubuntu.research.nokia.com>
References: <1283408230-22652-1-git-send-email-u.kleine-koenig@pengutronix.de>
	 <1283414622-2663-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:25792 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394Ab0IIIlH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Sep 2010 04:41:07 -0400
In-Reply-To: <1283414622-2663-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

On Thu, 2010-09-02 at 10:03 +0200, ext Uwe Kleine-K=C3=B6nig wrote:
> omap_init_fb() is only called as arch_initcall and so can live in
> .init.text.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

I picked patches 1, 2 and 3 from this patch set to my tree. They look
fine, thanks!

Patch 4 should probably go through Tony, and 5 was marked
work-in-progress.

 Tomi


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
