From: Tony Lindgren <tony@atomide.com>
Subject: Re: [REPOST][PATCH] Fix IGEPv2 second MMC channel power supply
Date: Mon, 13 Dec 2010 12:24:43 -0800
Message-ID: <20101213202443.GB3054@atomide.com>
References: <1291466438-12827-1-git-send-email-maz@misterjones.org>
 <AANLkTi=9+AafKvyBanYeFjQtWQvUKK1rLLLJRO0z1ekw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:10684 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755313Ab0LMUYs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Dec 2010 15:24:48 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=9+AafKvyBanYeFjQtWQvUKK1rLLLJRO0z1ekw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric =?utf-8?B?QmFsbGV0YsOy?= i Serra <eballetbo@gmail.com>
Cc: Marc Zyngier <maz@misterjones.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Enric Balletb=C3=B2 i Serra <eballetbo@gmail.com> [101213 08:47]:
>=20
> Tony, please can this patch be included before 2.6.37 ? Without this
> patch the wifi module on IGEP v2 board not works.

Sorry it's too much for the -rc series. For the -rc series
the fixes should be major bugs. This is in the category
"it never worked before".

I will add it to omap-boards branch for the next merge window
over the next few days while going through all the pending
patches in patchwork.

Cheers,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
