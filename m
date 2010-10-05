From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: hwmod: Handle modules with 16bit registers
Date: Tue, 05 Oct 2010 10:21:04 -0700
Message-ID: <87wrpwsghr.fsf@deeprootsystems.com>
References: <alpine.DEB.2.00.1010051058290.13816@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38175 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727Ab0JERVI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 13:21:08 -0400
Received: by gxk9 with SMTP id 9so2076099gxk.19
        for <linux-omap@vger.kernel.org>; Tue, 05 Oct 2010 10:21:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1010051058290.13816@utopia.booyaka.com> (Paul
	Walmsley's message of "Tue, 5 Oct 2010 10:59:44 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@ti.com, tony@atomide.com

Paul Walmsley <paul@pwsan.com> writes:

> From: Rajendra Nayak <rnayak@ti.com>
>
> Some modules which have 16bit registers can cause imprecise
> aborts if a __raw_readl/writel is used to read/write 32 bits.
>
> Add an additional flag to identify modules which have such
> hard requirement, and handle it in the hwmod framework.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Acked-by: Paul Walmsley <paul@pwsan.com>

Tested-by: Kevin Hilman <khilman@deeprootsystems.com>

Added the flag to the 2420 hwmods and tested this patch on n810 using
the i2c hwmods and it now boots without the imprecise abort.

Kevin
