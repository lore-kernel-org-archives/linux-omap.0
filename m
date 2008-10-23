From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/5] OMAP242x omapdev: add OMAP242x omapdev records
Date: Thu, 23 Oct 2008 00:34:25 -0700
Message-ID: <200810230034.26002.david-b@pacbell.net>
References: <20081018215247.9699.35039.stgit@localhost.localdomain> <20081018215910.9699.13379.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:26040 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751564AbYJWJEt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Oct 2008 05:04:49 -0400
In-Reply-To: <20081018215910.9699.13379.stgit@localhost.localdomain>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

On Saturday 18 October 2008, Paul Walmsley wrote:
> --- a/arch/arm/mach-omap2/omapdev-common.h
> +++ b/arch/arm/mach-omap2/omapdev-common.h
> @@ -21,6 +21,87 @@
> =A0#include "omapdev3xxx.h"
> =A0
> =A0static struct omapdev *omapdevs[] =3D {
> +
> +#ifdef CONFIG_ARCH_OMAP2420
> +=A0=A0=A0=A0=A0=A0=A0&mpu_242x_omapdev,
> +=A0=A0=A0=A0=A0=A0=A0&iva_242x_omapdev,
> +=A0=A0=A0=A0=A0=A0=A0&gfx_242x_omapdev,
>	...

Urgh, this is unpleasant style:  declaration of a large
static data structure in a header file.

Cleaner:  just have some omap2420-specific C file declare
the struct, and hand it off to whatever code uses it.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
