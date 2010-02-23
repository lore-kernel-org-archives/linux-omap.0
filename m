From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PM-WIP-OPP] [PATCH 0/2] cleanups for pointer handling
Date: Tue, 23 Feb 2010 10:36:03 -0800
Message-ID: <87ljejztnw.fsf@deeprootsystems.com>
References: <1266308837-23262-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33852 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219Ab0BWSgO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 13:36:14 -0500
Received: by vws6 with SMTP id 6so503703vws.19
        for <linux-omap@vger.kernel.org>; Tue, 23 Feb 2010 10:36:13 -0800 (PST)
In-Reply-To: <1266308837-23262-1-git-send-email-nm@ti.com> (Nishanth Menon's message of "Tue\, 16 Feb 2010 02\:27\:15 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Ambresh K <ambresh@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

Nishanth Menon <nm@ti.com> writes:

> Few pointer handling related cleanup patches
>
> Nishanth Menon (2):
>   omap3:pm:srf: check if pointer results with IS_ERR
>   omap:pm: return error pointers if inactive opp layer
>
>  arch/arm/mach-omap2/resource34xx.c    |    2 +-
>  arch/arm/plat-omap/include/plat/opp.h |   12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> Cc: Ambresh K <ambresh@ti.com>
> Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

Thanks, applying to pm-wip-opp.

Kevin
