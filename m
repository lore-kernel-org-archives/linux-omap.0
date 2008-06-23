From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2] ARM: OMAP3: Fix warnings in clock34xx.h
Date: Mon, 23 Jun 2008 13:08:24 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0806231308020.4919@utopia.booyaka.com>
References: <485FCA78.9000209@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58648 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759887AbYFWTIZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jun 2008 15:08:25 -0400
In-Reply-To: <485FCA78.9000209@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 23 Jun 2008, Dirk Behme wrote:

> Fix warnings
> 
> arch/arm/mach-omap2/clock34xx.h:178: warning: initialization makes pointer
> from integer without a cast
> arch/arm/mach-omap2/clock34xx.h:204: warning: initialization makes pointer
> from integer without a cast
> arch/arm/mach-omap2/clock34xx.h:229: warning: initialization makes pointer
> from integer without a cast
> arch/arm/mach-omap2/clock34xx.h:2238: warning: initialization makes pointer
> from integer without a cast
> 
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

Thanks, Dirk.


Acked-by: Paul Walmsley <paul@pwsan.com>

- Paul
