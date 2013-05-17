From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/4 v2] ARM: OMAP2+: updated ECC scheme attributes for omap2-nand DT
Date: Fri, 17 May 2013 14:46:05 +0200
Message-ID: <201305171446.06023.arnd@arndb.de>
References: <1368791418-14330-1-git-send-email-pekon@ti.com> <1368791418-14330-5-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:50550 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753241Ab3EQMqf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 May 2013 08:46:35 -0400
In-Reply-To: <1368791418-14330-5-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, avinashphilip@ti.com, tony@atomide.com, balbi@ti.com, jp.francois@cynove.com

On Friday 17 May 2013, Gupta, Pekon wrote:
> From: "Gupta, Pekon" <pekon@ti.com>
> 
> Updates ECC scheme selection string same to same as used in omap2-driver code.
> This makes the DT configurations easy to understand and map to actual code.
> 
> Signed-off-by: Gupta, Pekon <pekon@ti.com>

This moves the binding in the wrong direction. First of all, you should never
make incompatible changes to a specification document.

> -	"bch8_hw_detection_sw" 	8-bit BCH with ECC calculation in hardware
> -				and error detection in software
> -				- requires Kconfig CONFIG_MTD_NAND_ECC_BCH

The binding before your change is already broken since it refers to
Linux-specific Kconfig symbols, and you fail to fix that.

> +				"OMAP_ECC_BCH4_CODE_HW_DETECTION_SW"
> +					4-bit BCH with ECC calculation in
> +					hardware & error detection in software.
> +					- requires CONFIG_MTD_NAND_ECC_BCH

Instead you make it worse by using /more/ Linux-isms in the binding.

	Arnd
