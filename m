From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] i2c: tea5761: New-style i2c driver
Date: Fri, 28 Mar 2008 13:38:20 +0200
Message-ID: <20080328133820.5a35eca0.jarkko.nikula@nokia.com>
References: <1206631880-12173-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:35198 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868AbYC1LiF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2008 07:38:05 -0400
In-Reply-To: <1206631880-12173-1-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Eduardo Valentin <edubezval@gmail.com>
Cc: linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>

On Thu, 27 Mar 2008 11:31:20 -0400
"ext Eduardo Valentin" <edubezval@gmail.com> wrote:

> From: Eduardo Valentin <eduardo.valentin@indt.org.br>
> 
> This patch updates the fm radio driver for tea5761 chip.
> It also moves board dependent code to its correct board
> file place.
> 
Good move forward!

Any plans to send this driver with Kconfig & Makefile modifications to
relevant V4L etc mailing list?

Note there are three minor warnings if you run your patch with
scripts/checkpatch.pl.

You could also remove these two headers files below since they are not
needed anymore.

> diff --git a/drivers/media/radio/radio-tea5761.c
> b/drivers/media/radio/radio-tea5761.c index ac0f621..2341e66 100644
> --- a/drivers/media/radio/radio-tea5761.c
> +++ b/drivers/media/radio/radio-tea5761.c
@@ -23,8 +23,8 @@
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <media/v4l2-common.h>
-#include <asm/arch/gpio.h>
-#include <asm/arch/board.h>


-- 
Jarkko
