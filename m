From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/2] Put OMAP2 SPI CS in unactive state when return from  suspend
Date: Wed, 11 Aug 2010 11:21:58 -0700
Message-ID: <871va52ent.fsf@deeprootsystems.com>
References: <AANLkTin7-ZqFRH4GXT4aUfQ4sE=8Jc=3i0j8rTH7EyBm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42268 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717Ab0HKSWB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 14:22:01 -0400
Received: by pzk26 with SMTP id 26so152390pzk.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Aug 2010 11:22:00 -0700 (PDT)
In-Reply-To: <AANLkTin7-ZqFRH4GXT4aUfQ4sE=8Jc=3i0j8rTH7EyBm@mail.gmail.com>
	(Gregory CLEMENT's message of "Wed, 11 Aug 2010 16:42:52 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gregory CLEMENT <gclement00@gmail.com>
Cc: spi-devel-general <spi-devel-general@lists.sourceforge.net>, linux-omap <linux-omap@vger.kernel.org>

Gregory CLEMENT <gclement00@gmail.com> writes:

> We notice that when system wake up from OFF mode, then CS is in
> unactive state until the first SPI transfert.
> For our design it lead to some conflict on this I/O.
> Unactive state for CS when there is no transfert shoudl be the correct
> behaviour: this is the purpose of these patches.

This approach handles an off-mode transition during suspend, but if
off-mode is enabled, you can also have an off-mode transition during
idle.

Since you didn't describe what the conflicts you're seeing are, I would
assume that you'll have the same problems in idle as in suspend, and
this series doesn't address the idle case.

Kevin



> Gregory CLEMENT (2):
>   spi: Add hook on suspend/resume for spi master
>   spi/omap2_mcspi: When SPI wake up from OFF mode, CS is in wrong
>     state: force it to unactive state
>
>  drivers/spi/omap2_mcspi.c |   11 ++++++++++-
>  drivers/spi/spi.c         |   15 ++++++++++++++-
>  include/linux/spi/spi.h   |    4 +++-
>  3 files changed, 27 insertions(+), 3 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
