From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: Re: [PATCH 0/8] Flip on multiplatform support for omap2plus for v3.9
Date: Fri, 21 Dec 2012 09:48:05 -0300
Message-ID: <CALF0-+Xy+w=4Bs+97WJj76-tAnb56v=hS+zLyr9ue_zBKSQoVg@mail.gmail.com>
References: <20121219192354.22098.33408.stgit@muffinssi.local>
	<20121220155518.GX4989@atomide.com>
	<CALF0-+XspOix_RiNkWN7d1L9uxBZi7Zf5SDaKcx0P7P_Z3anqA@mail.gmail.com>
	<20121221010518.GJ21056@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:64090 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab2LUMsG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Dec 2012 07:48:06 -0500
Received: by mail-ie0-f171.google.com with SMTP id 17so6111713iea.16
        for <linux-omap@vger.kernel.org>; Fri, 21 Dec 2012 04:48:05 -0800 (PST)
In-Reply-To: <20121221010518.GJ21056@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Javier Martinez Canillas <martinez.javier@gmail.com>, lokeshvutla@ti.com

Hi Tony,

On Thu, Dec 20, 2012 at 10:05 PM, Tony Lindgren <tony@atomide.com> wrote:
>
> Maybe use Olof's lates pull request for fixes from LAKML +
> ARM: l2x0: Only set .set_debug on PL310 r3p0 and earlier +
> ARM: disable errata work-arounds which access secure registers
> and these patches?
>

FYI, I've successfully booted my IGEPv2 board using:
* arm-soc/for-next
* igep DT patches
* this multiplatform series
* the two patches mentioned above

With this series CONFIG_MACH_IGEP0020 is not needed,
just CONFIG_MACH_OMAP_GENERIC is selected.

So I guess this means, for igep v2,

Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Nice job,

    Ezequiel
