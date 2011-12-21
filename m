From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH v2 5/7] MTD: NAND: ams-delta: use GPIO instead of custom
 I/O
Date: Wed, 21 Dec 2011 22:56:50 +0200
Message-ID: <1324501012.2110.2.camel@koala>
References: <1323634328-856-1-git-send-email-jkrzyszt@tis.icnet.pl>
	 <ebab42f6ddd313afb38b71880ac7865e4e0ceab4.1324331816.git.jkrzyszt@tis.icnet.pl>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:51674 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751481Ab1LUU4z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Dec 2011 15:56:55 -0500
In-Reply-To: <ebab42f6ddd313afb38b71880ac7865e4e0ceab4.1324331816.git.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>

On Tue, 2011-12-20 at 00:08 +0100, Janusz Krzysztofik wrote:
> Don't use Amstrad Delta custom I/O functions for controlling the device,
> use GPIO API instead.
> 
> While being at it, add missing gpio_free(AMS_DELTA_GPIO_PIN_NAND_RB).
> 
> Depends on patch 2/7 "ARM: OMAP1: ams-delta: convert latches to
> basic_mmio_gpio"
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Tony Lindgren <tony@atomide.com>

Looks good, thanks!

Reviewed-by: Artem Bityutskiy <Artem.Bityutskiy@linux.intel.com>

