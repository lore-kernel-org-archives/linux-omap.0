From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC PATCH v2 0/6] TI81XX: Add clock and hwmod data
Date: Tue, 30 Aug 2011 12:46:35 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108301246170.26173@utopia.booyaka.com>
References: <1314119594-22647-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51830 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755789Ab1H3Sqg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Aug 2011 14:46:36 -0400
In-Reply-To: <1314119594-22647-1-git-send-email-hemantp@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>

On Tue, 23 Aug 2011, Hemant Pedanekar wrote:

> This patch set is the v2 of TI816X clock and hwmods patches sent earlier.
> 
> The clock data is currently added only for TI816X, while minimal hwmod data
> common for TI816X and TI814X is added.
> 
> This patch set depends on following patches:
> 	TI81XX: Prepare for addition of TI814X support
> 	TI814X: Add cpu type macros and detection support
> 	TI814X: Create board support and enable build for TI8148 EVM
> 
> Please note that CHIP_IS_TI816X/CHIP_IS_TI814X are still being used and I will
> send update once SoC list usage is available.	

Thanks - am working away on these patches & hope to have them out soon.


- Paul
