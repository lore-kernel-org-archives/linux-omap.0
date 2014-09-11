From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: make of_device_ids const
Date: Thu, 11 Sep 2014 10:39:43 -0700
Message-ID: <20140911173943.GB18849@atomide.com>
References: <1410337579-23466-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1410337579-23466-2-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52650 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbaIKRkH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2014 13:40:07 -0400
Content-Disposition: inline
In-Reply-To: <1410337579-23466-2-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, Rajendra Nayak <rnayak@ti.com>, devicetree@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de, linux-omap@vger.kernel.org

* Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> [140910 01:27]=
:
> of_device_ids (i.e. compatible strings and the respective data) are n=
ot
> supposed to change at runtime. All functions working with of_device_i=
ds
> provided by <linux/of.h> work with const of_device_ids. So mark the
> non-const function parameters and structs for OMAP2+ as const, too.

Hmm this does not seem to compile with omap2plus_defconfig because
of section type conflicts. Looks like there's some issue now with the
use of __initconst:

arch/arm/mach-omap2/board-generic.c:262:20: error: dra72x_boards_compat=
 causes a section type conflict with omap_dt_match_table
arch/arm/mach-omap2/board-generic.c:30:34: note: =E2=80=98omap_dt_match=
_table=E2=80=99 was declared here
scripts/Makefile.build:257: recipe for target 'arch/arm/mach-omap2/boar=
d-generic.o' failed

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
