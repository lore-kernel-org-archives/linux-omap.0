From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2 2/3] hwrng: OMAP3 ROM Random Number Generator support
Date: Mon, 18 Nov 2013 22:51:30 +0100
Message-ID: <201311182251.35704@pali>
References: <1379534757-20870-1-git-send-email-pali.rohar@gmail.com> <20131008190408.GM8313@atomide.com> <20131016125734.GA10906@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:42628 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab3KRVvj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Nov 2013 16:51:39 -0500
In-Reply-To: <20131016125734.GA10906@gondor.apana.org.au>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Tony Lindgren <tony@atomide.com>, Matt Mackall <mpm@selenic.com>, Russell King <linux@arm.linux.org.uk>, Joe Perches <joe@perches.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 16 October 2013 14:57:34 Herbert Xu wrote:
> On Tue, Oct 08, 2013 at 12:04:09PM -0700, Tony Lindgren wrote:
> > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [130920 06:33]:
> > > This driver provides kernel-side support for the Random
> > > Number Generator hardware found on OMAP34xx processors.
> > >=20
> > > This driver comes from Maemo 2.6.28 kernel and was tested
> > > on Nokia RX-51. It is platform device because it needs
> > > board specific function for smc calls.
> >=20
> > This one is should be merged via the hw_random patches
> > seprately:
> >=20
> > Acked-by: Tony Lindgren <tony@atomide.com>
>=20
> Patch applied.  Thanks!

Hello, I still do not see this patch (2/3) in linus tree. But=20
patch 1/3 and 3/3 are already merged. So is there any problem?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
