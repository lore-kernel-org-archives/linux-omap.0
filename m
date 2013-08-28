From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] non-critical omap fixes for v3.12 merge window
Date: Wed, 28 Aug 2013 11:50:45 -0700
Message-ID: <20130828185045.GI8607@quad.lixom.net>
References: <20130823054609.GW7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:39660 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755167Ab3H1SvZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Aug 2013 14:51:25 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so6595095pbc.18
        for <linux-omap@vger.kernel.org>; Wed, 28 Aug 2013 11:51:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130823054609.GW7656@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@linaro.org>, arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Matus Ujhelyi <ujhelyi.m@gmail.com>

On Thu, Aug 22, 2013 at 10:46:10PM -0700, Tony Lindgren wrote:

> Matus Ujhelyi (1):
>       ARM: OMAP2+: am33xx-restart: trigger warm reset on omap2+ boards

Sigh. am33xx has been a bit of a pain this release cycle. Can you please
start double-checking builds when you apply am33xx stuff? :(

This breaks with:

        multi_v7_defconfig:
arch/arm/mach-omap2/am33xx-restart.c:27:26: error: 'AM33XX_RST_GLOBAL_WARM_SW_MASK' undeclared (first use in this function)

        omap2plus_defconfig:
arch/arm/mach-omap2/am33xx-restart.c:27:26: error: 'AM33XX_RST_GLOBAL_WARM_SW_MASK' undeclared (first use in this function)


I've unmerged the branch until that's resolved.

-Olof
