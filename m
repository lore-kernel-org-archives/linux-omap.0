From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP4 clock code needs some modifying now that clockdomains are
 present
Date: Fri, 18 Dec 2009 13:31:36 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912181331010.12561@utopia.booyaka.com>
References: <alpine.DEB.2.00.0912181118100.12561@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52766 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbZLRUbh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 15:31:37 -0500
In-Reply-To: <alpine.DEB.2.00.0912181118100.12561@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: abhijitpagare@ti.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org

Hi Abhijit,

On Fri, 18 Dec 2009, Paul Walmsley wrote:

> going through the clock code, I noticed that it still has several
> 
> #ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once clkdm f/w is in place */

Just noticed this also in clock44xx_data.c:

			/* TODO
			omap2_init_clk_clkdm(c->lk.clk);
			*/

- Paul
