From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/9] OMAP: remove OMAP_TAG_UART
Date: Thu, 13 Aug 2009 10:16:31 +0100
Message-ID: <20090813091631.GM6132@n2100.arm.linux.org.uk>
References: <20090811094348.32577.81307.stgit@localhost> <20090811094756.32577.86259.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52947 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353AbZHMJQr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 05:16:47 -0400
Content-Disposition: inline
In-Reply-To: <20090811094756.32577.86259.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Kalle Valo <kalle.valo@iki.fi>, linux-omap@vger.kernel.org

On Tue, Aug 11, 2009 at 12:47:56PM +0300, Tony Lindgren wrote:
> From: Kalle Valo <kalle.valo@iki.fi>
> 
> Omap tags are deprecrated and convert all OMAP_TAG_UART cases to use
> omap_uart_platform_data instead.

Ok.
