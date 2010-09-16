From: Linus Walleij <linus.walleij@stericsson.com>
Subject: Re: [PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs
Date: Thu, 16 Sep 2010 14:19:59 +0200
Message-ID: <AANLkTimC9NOJ5TSqkb1ekBQ_ei2-Ci2ewL66+4aCnyk=@mail.gmail.com>
References: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com>
	<1284587799-9637-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47325 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754639Ab0IPMUA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 08:20:00 -0400
Received: by qyk36 with SMTP id 36so4860354qyk.19
        for <linux-omap@vger.kernel.org>; Thu, 16 Sep 2010 05:20:00 -0700 (PDT)
In-Reply-To: <1284587799-9637-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

2010/9/15 Kevin Hilman <khilman@deeprootsystems.com>:

> OMAP SOCs have a standard set of tuples consisting of frequency and
> voltage pairs that the device will support per voltage domain. =A0The=
se
> are called Operating Performance Points or OPPs.
> (...)
> This introduces a common handling OPP mechanism accross all OMAPs.
> As a start this is used for OMAP3.

OPPs are a generic concept, it's in silicon construction textbooks and =
all.
Should this code not be made generic instead? You wouldn't make
regulators or even DMA platform-specific these days, so why should
OPPs be?

What in this code is actually OMAP-specific, more than that you name
some functions omap_*, and how hard would it be to put it under
arch/arm/common/*.c
arch/arm/include/asm/*.h

Possible even higher up in the directory hiearchy in include/linux/opp.=
h
for the header and drivers/opp/*.c, because I think SuperH and power
are not that different in this respect.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
