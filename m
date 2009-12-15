From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [v2 PATCH 5/5] ARM: OMAP4: PM: Refine the APIs to support OMAP4
 features.
Date: Tue, 15 Dec 2009 09:52:54 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912150950050.12561@utopia.booyaka.com>
References: <1260885177-25665-1-git-send-email-abhijitpagare@ti.com> <1260885177-25665-2-git-send-email-abhijitpagare@ti.com> <1260885177-25665-3-git-send-email-abhijitpagare@ti.com> <1260885177-25665-4-git-send-email-abhijitpagare@ti.com>
 <1260885177-25665-5-git-send-email-abhijitpagare@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41832 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760562AbZLOQwz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 11:52:55 -0500
In-Reply-To: <1260885177-25665-5-git-send-email-abhijitpagare@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Abhijit Pagare <abhijitpagare@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

Hi Abhijit,

just FYI, on this patch:

On Tue, 15 Dec 2009, Abhijit Pagare wrote:

> Port the APIs to support the OMAP4 clockdomain framework.
> Also take care of the compiling requirements for the same.

...

> diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
> index 5366a10..f768d37 100644
> --- a/arch/arm/mach-omap2/clockdomain.c
> +++ b/arch/arm/mach-omap2/clockdomain.c
> @@ -1,10 +1,11 @@
>  /*
> - * OMAP2/3 clockdomain framework functions
> + * OMAP2/3/4 clockdomain framework functions
>   *
>   * Copyright (C) 2008 Texas Instruments, Inc.
>   * Copyright (C) 2008-2009 Nokia Corporation
>   *
>   * Written by Paul Walmsley and Jouni H????gander

... looks like something mangled the UTF-8 which causes this patch to 
not apply cleanly.  Fixed this up by hand.


- Paul
