From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH] Don't mark shared helper functions as inline
Date: Mon, 26 Nov 2012 14:00:38 -0700
Message-ID: <20121126210038.GA3987@animalcreek.com>
References: <1353957609-1295-1-git-send-email-Russ.Dill@ti.com>
 <20121126195742.21126.16500@nucleus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:36046 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756515Ab2KZVAj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Nov 2012 16:00:39 -0500
Content-Disposition: inline
In-Reply-To: <20121126195742.21126.16500@nucleus>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Mon, Nov 26, 2012 at 11:57:42AM -0800, Mike Turquette wrote:
> Quoting Russ Dill (2012-11-26 11:20:09)
> > The helper functions that access the opaque struct clk should
> > not be marked inline since they are contained in clk.c, but expecte=
d
> > to be used by other compilation units. This causes compile errors
> > under gcc-4.7
> >=20
> > In file included from arch/arm/mach-omap2/clockdomain.c:25:0:
> > arch/arm/mach-omap2/clockdomain.c: In function =E2=80=98clkdm_clk_d=
isable=E2=80=99:
> > include/linux/clk-provider.h:338:12: error: inlining failed in call=
 to always_inline =E2=80=98__clk_get_enable_count=E2=80=99: function bo=
dy not available
> > arch/arm/mach-omap2/clockdomain.c:1001:28: error: called from here
> > make[1]: *** [arch/arm/mach-omap2/clockdomain.o] Error 1
> > make: *** [arch/arm/mach-omap2] Error 2
> >=20
>=20

Hi Mike.

> Regardless, I'm still considering this patch.  I've heard many times
> that we should trust the compiler to optimize for us and some folks l=
ook
> down on inlining in general.  If anyone has an opinion on removing
> inlines from the common clk core then please do speak up.

You should take a look at "Chapter 15: The inline disease" in
Documentation/CodingStyle.

Mark
--
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
