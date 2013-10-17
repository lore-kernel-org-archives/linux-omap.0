From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v9 0/9] mtd:nand:omap2: clean-up of supported ECC
 schemes
Date: Wed, 16 Oct 2013 19:35:36 -0700
Message-ID: <20131017023536.GE23337@ld-irv-0074.broadcom.com>
References: <1381816197-20477-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:34365 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757163Ab3JQCfn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Oct 2013 22:35:43 -0400
Content-Disposition: inline
In-Reply-To: <1381816197-20477-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: mark.rutland@arm.com, olof@lixom.net, dedekind1@gmail.com, tony@atomide.com, bcousson@baylibre.com, robherring2@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

Hi,

On Tue, Oct 15, 2013 at 11:19:48AM +0530, Pekon Gupta wrote:
> 
> *changes v8 -> v9*
> [PATCH 1/9] <no update from [PATCH v8 1/6]>
> [PATCH 2/9] <only commit log updated from [PATCH v8 2/6]>
>  As per feedbacks from Brian Norris <computersforpeace@gmail.com> previous
>  revision [PATCH v8 3/6] and [PATCH 4/6] are split into following sub-patches:
> - [PATCH 3/9] <new> replaces local reference with generic names (mtd, nand_chip)
> - [PATCH 4/9] <new> enables auto-detection of bus-width
> - [PATCH 5/9] <new> removes omap3_init_bch: populates ecc-scheme data
> - [PATCH 6/9] <new> removes omap3_init_bch_tail: populates ecc-layout
> - [PATCH 7/9] <new> replaces lib/bch.c with nand_bch.c wrapper
> [PATCH 8/9] <no update same as [PATCH v8 5/6]
> [PATCH 9/9] removed devm_free_xx functions

[...]

I had a few comments on patches 4 and 7, but everything else is looking
a lot better.

Thanks,
Brian
