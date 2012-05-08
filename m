From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 7/7] ARM: OMAP4+: Add prm and cm base init function.
Date: Mon, 7 May 2012 23:15:39 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205072314480.9984@utopia.booyaka.com>
References: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com> <1335952093-12541-8-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56163 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab2EHFPk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 01:15:40 -0400
In-Reply-To: <1335952093-12541-8-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, R Sricharan <r.sricharan@ti.com>

On Wed, 2 May 2012, Santosh Shilimkar wrote:

> From: R Sricharan <r.sricharan@ti.com>
> 
> Instead of statically defining seperate arrays for every OMAP4+ archs,
> have a generic init function to populate the arrays. This avoids the
> need for creating new array for every arch added in the future that
> reuses the prm and cm registers read/write code.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: R Sricharan <r.sricharan@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks, looks reasonable, will queue this for 3.5.


- Paul
