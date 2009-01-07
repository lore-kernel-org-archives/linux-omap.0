From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 2/2] ARM: OMAP: Fix gpio by switching to generic gpio
 calls
Date: Wed, 7 Jan 2009 13:37:47 +0200
Message-ID: <20090107133747.d448222e.jarkko.nikula@nokia.com>
References: <20090107111415.GF27566@atomide.com>
	<20090107111615.GG27566@atomide.com>
	<20090107111744.GH27566@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:21445 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbZAGLiW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2009 06:38:22 -0500
In-Reply-To: <20090107111744.GH27566@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, ext-adrian.hunter@nokia.com

On Wed, 7 Jan 2009 13:17:45 +0200
"ext Tony Lindgren" <tony@atomide.com> wrote:

> From: Jarkko Nikula <jarkko.nikula@nokia.com>
> Date: Wed, 7 Jan 2009 12:54:34 +0200
> Subject: [PATCH] ARM: OMAP: Fix gpio by switching to generic gpio calls
> 
> Fix compile by removing remaining omap specific gpio
> calls. Based on earlier patches by Jarkko Nikula.
> 
Thanks Tony!

> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> index 96ecc17..77a4f14 100644
> --- a/drivers/mtd/onenand/omap2.c
> +++ b/drivers/mtd/onenand/omap2.c
>
I think this was already handed over to mtd list by Adrian?


Jarkko
