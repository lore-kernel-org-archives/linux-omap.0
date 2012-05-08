From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/7] ARM: OMAP4: Don't compile cm2xxx_3xxx.c for OMAP4
 only builds.
Date: Mon, 7 May 2012 23:09:44 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205072309190.9984@utopia.booyaka.com>
References: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com> <1335952093-12541-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47822 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473Ab2EHFJq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 01:09:46 -0400
In-Reply-To: <1335952093-12541-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On Wed, 2 May 2012, Santosh Shilimkar wrote:

> Since OMAP4 code base now makes use of OMAP4 specific PRCM functions,
> cm2xxx_3xxx.c need not be compiled for OMAP4 only builds.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

Will remove the stub functions in a separate patch.


- Paul
