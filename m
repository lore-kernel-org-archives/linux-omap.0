From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH] Backlight driver for omap3evm
Date: Wed, 07 Jan 2009 15:07:10 +0000
Message-ID: <1231340830.5331.22.camel@dax.rpnet.com>
References: <1231340151-16790-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]:55513 "EHLO
	tim.rpsys.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759676AbZAGPGq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Jan 2009 10:06:46 -0500
In-Reply-To: <1231340151-16790-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

On Wed, 2009-01-07 at 20:25 +0530, Sanjeev Premi wrote:
> This patch implements the backlight driver for OMAP3EVM.
> The mechanism for backlight control is reused from the
> existing controls in lcd_omap3evm.c.

Please see the reply to the email you sent me offlist. What happens when
you run this driver on something that isn't an omap3evm?

The problem is that this bit:

omap_backlight_dev = platform_device_alloc(OMAPBL_DEVNAME, -1);

should be done in the platform code for the board, not in the general
driver. If you do that, you should be able to reuse most of the
generic-bl device code.

Regards,

Richard

