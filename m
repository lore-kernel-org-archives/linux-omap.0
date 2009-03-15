From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/4] ARM: OMAP3: Add support for 3430 SDP
Date: Sun, 15 Mar 2009 15:47:01 +0000
Message-ID: <20090315154701.GB10541@n2100.arm.linux.org.uk>
References: <20090313224259.8810.3283.stgit@localhost> <20090313224726.8810.25536.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36537 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178AbZCOPrL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Mar 2009 11:47:11 -0400
Content-Disposition: inline
In-Reply-To: <20090313224726.8810.25536.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Syed Mohammed Khasim <x0khasim@ti.com>

On Fri, Mar 13, 2009 at 03:47:26PM -0700, Tony Lindgren wrote:
> +#include <mach/mcspi.h>
> +#include <mach/gpio.h>

Shouldn't this be linux/gpio.h ?
