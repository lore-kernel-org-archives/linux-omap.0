From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] mfd: twl-core: Fix passing of platform data in the
 device tree case
Date: Mon, 25 Nov 2013 15:22:45 -0800
Message-ID: <20131125232245.GY10023@atomide.com>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
 <1384562167-14725-2-git-send-email-tony@atomide.com>
 <20131118102907.GC13640@lee--X1>
 <20131118172510.GI16038@saruman.home>
 <20131118174638.GQ13640@lee--X1>
 <20131118181110.GM10317@atomide.com>
 <20131118190921.GT13640@lee--X1>
 <20131118192256.GU10317@atomide.com>
 <20131121104654.GA23067@lee--X1>
 <20131121110950.GC23067@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:13576 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751655Ab3KYXWt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 18:22:49 -0500
Content-Disposition: inline
In-Reply-To: <20131121110950.GC23067@lee--X1>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

* Lee Jones <lee.jones@linaro.org> [131121 03:10]:
> > Here Tony, you can take this one.
> >=20
> > I will simply apply my other fixes on top of it.
> >=20
> > The issue is, I will most likely have to rebase it on top of -rc1 p=
rior
> > to sending a request to Linus, so in that regard it's not exactly
> > immutable.
> >=20
>=20
> Ignore the above. This is what you want:

Thanks, I'll use that commit in my omap-for-v3.14/board-removal branch.

Regards,

Tony
=20
> The following changes since commit 5e01dc7b26d9f24f39abace5da98ccbd6a=
5ceb52:
>=20
>   Linux 3.12 (2013-11-03 15:41:51 -0800)
>=20
> are available in the git repository at:
>=20
>   git://git.linaro.org/people/ljones/mfd.git tags/ib-tony
>=20
> for you to fetch changes up to f984370913d3ba5d13806cc8ac6fc26f8ebd16=
94:
>=20
>   mfd: twl-core: Fix passing of platform data in the device tree case=
 (2013-11-21 10:42:36 +0000)
>=20
> ----------------------------------------------------------------
> warning: refname 'ib-tony' is ambiguous.
> Immutable branch for Tony Lindgren
>=20
> ----------------------------------------------------------------
> Tony Lindgren (1):
>       mfd: twl-core: Fix passing of platform data in the device tree =
case
>=20
>  drivers/mfd/twl-core.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> --=20
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
