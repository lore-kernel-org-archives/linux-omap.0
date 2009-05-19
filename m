From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] OMAP: Cleanup series.
Date: Tue, 19 May 2009 10:47:53 -0700
Message-ID: <20090519174752.GD19742@atomide.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02B49CBCAD@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51011 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799AbZESRsF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 13:48:05 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B49CBCAD@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [090519 06:17]:
> Recent OMAP4 patch reviews brought out some clean-up/reorganization on generic OMAP2/3 software. This patch series addresses those comments.
> It's based on 2.6.30-rc6 (commit:22ef37eed673587ac984965dc88ba94c68873291) and tested on OMAP3430 SDP platform.
> 
> 	[PATCH 1/4] ARM: OMAP2/3: Reorganize Makefile to add omap4 support
> 	[PATCH 2/4] ARM: OMAP: Remove unwanted type casts and fix the compiler warning.
> 	[PATCH 3/4] ARM: OMAP: Remove useless omap_sram_error function.
> 	[PATCH 4/4] ARM: OMAP: Remove unnecessary omap2_globals.

Thanks, I've added these four patches to the omap for-next series
on top of the header clean-up patches.

Regards,

Tony
