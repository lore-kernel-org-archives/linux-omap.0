From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] OMAP: serial: Release the claimed memory region in
 remove
Date: Sat, 11 Feb 2012 11:27:22 +0000
Message-ID: <20120211112721.GA21453@sirena.org.uk>
References: <1328945607-4025-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:52243 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754815Ab2BKL1Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 11 Feb 2012 06:27:24 -0500
Content-Disposition: inline
In-Reply-To: <1328945607-4025-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-serial@vger.kernel.org, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Feb 11, 2012 at 01:03:27PM +0530, Shubhrajyoti D wrote:
> Currently the memory region is not released the folowing error is
> observed.

> /testsuites # insmod omap-serial.ko
> [  130.746917] omap_uart omap_uart.0: memory region already claimed
> [  130.753143] omap_uart: probe of omap_uart.0 failed with error -16

It'd be better yet to use the devm_ functions to prevent such issues
recurring in future.
