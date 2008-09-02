From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 21/33] add OMAP HighSpeed mmc controller driver
Date: Tue, 2 Sep 2008 23:05:21 +0100
Message-ID: <20080902220521.GC32575@flint.arm.linux.org.uk>
References: <1220116593-862-13-git-send-email-me@felipebalbi.com> <1220116593-862-14-git-send-email-me@felipebalbi.com> <1220116593-862-15-git-send-email-me@felipebalbi.com> <1220116593-862-16-git-send-email-me@felipebalbi.com> <1220116593-862-17-git-send-email-me@felipebalbi.com> <1220116593-862-18-git-send-email-me@felipebalbi.com> <1220116593-862-19-git-send-email-me@felipebalbi.com> <1220116593-862-20-git-send-email-me@felipebalbi.com> <1220116593-862-21-git-send-email-me@felipebalbi.com> <1220116593-862-22-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38628 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbYIBWFg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 18:05:36 -0400
Content-Disposition: inline
In-Reply-To: <1220116593-862-22-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Sat, Aug 30, 2008 at 08:16:21PM +0300, Felipe Balbi wrote:
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/platform_device.h>
> +#include <linux/workqueue.h>
> +#include <linux/timer.h>
> +#include <linux/clk.h>
> +#include <linux/mmc/host.h>
> +#include <linux/io.h>
> +#include <linux/semaphore.h>
> +#include <asm/dma.h>
> +#include <mach/hardware.h>
> +#include <mach/board.h>

Is there really anything in here which is board specific?  If yes,
shouldn't that be passed through platform data?

