From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: gpmc: fix: DT NAND child nodes not probed
 when MTD_NAND is built as module
Date: Thu, 13 Feb 2014 15:11:16 -0800
Message-ID: <20140213231116.GL28216@atomide.com>
References: <1390889561-11410-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59556 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbaBMXL2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Feb 2014 18:11:28 -0500
Content-Disposition: inline
In-Reply-To: <1390889561-11410-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Daniel Mack <zonque@gmail.com>

* Pekon Gupta <pekon@ti.com> [140127 22:15]:
> Fixes: commit bc6b1e7b86f5d8e4a6fc1c0189e64bba4077efe0
>        ARM: OMAP: gpmc: add DT bindings for GPMC timings and NAND
> 
> OMAP SoC(s) depend on GPMC controller driver to parse GPMC DT child nodes and
> register them platform_device for NAND driver to probe later. However this does
> not happen if generic MTD_NAND framework is built as module (CONFIG_MTD_NAND=m).
> 
> Therefore, when MTD/NAND and MTD/NAND/OMAP2 modules are loaded, they are unable
> to find any matching platform_device and remain un-binded. This causes on board
> NAND flash to remain un-detected.
> 
> This patch causes GPMC controller to parse DT nodes when
> CONFIG_MTD_NAND=y || CONFIG_MTD_NAND=m

Applying into omap-for-v3.14/fixes for this and the onenand patch.

Tony
