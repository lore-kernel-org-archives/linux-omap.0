From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/2] OMAP: TWL: sparse fixes
Date: Tue, 04 Jan 2011 10:00:35 -0800
Message-ID: <8762u47dmk.fsf@ti.com>
References: <1294081110-23695-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:60026 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750954Ab1ADSAj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 13:00:39 -0500
Received: by mail-gy0-f173.google.com with SMTP id 5so6502789gye.32
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 10:00:38 -0800 (PST)
In-Reply-To: <1294081110-23695-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Mon, 3 Jan 2011 12:58:28 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony <tony@atomide.com>, l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>

Nishanth Menon <nm@ti.com> writes:

> Source:
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> branch: omap-for-linus
>
> Doing a rm arch/arm/mach-omap2/*.o;make C=1 arch/arm/mach-omap2/
> resulted in the following sparse warnings:
> http://pastebin.mozilla.org/907954
>
> This series fixes the twl warnings
> Nishanth Menon (2):
>   OMAP2+: TWL: make conversion routines static
>   OMAP2+: TWL: include pm header for init protos
>
>  arch/arm/mach-omap2/omap_twl.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)

Acked-by: Kevin Hilman <khilman@ti.com>

Tony, these should probably queue for .38 if it's not too late.

Kevin


