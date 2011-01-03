From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3 1/4] TI816X: Update common omap platform files
Date: Mon, 3 Jan 2011 16:07:27 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101031603070.10403@utopia.booyaka.com>
References: <1294075737-22320-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48166 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab1ACXH2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jan 2011 18:07:28 -0500
In-Reply-To: <1294075737-22320-1-git-send-email-hemantp@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@deeprootsystems.com

Hello Hemant 

On Mon, 3 Jan 2011, Hemant Pedanekar wrote:

> This patch updates the common platform files with TI816X support. Also adds new
> files for TI816X modules base addresseses and irq definitions.
> 
> The approach taken in this patch is to add TI816X as part of OMAP3 variant where
> the cpu class is considered as OMAP34XX and the type is TI816X. This means, both
> cpu_is_omap34xx() and cpu_is_ti816x() checks return success on TI816X.

Looks like you should add a CONFIG_ARCH_OMAPTI816X Kconfig option for this 
chip.  I suspect that many handheld device manufacturers won't want to 
include TI816X-specific code/data in their builds, and vice versa.


- Paul
