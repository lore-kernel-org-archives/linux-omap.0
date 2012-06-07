From: Tony Lindgren <tony@atomide.com>
Subject: Re: [CFT 04/11] mmc: omap: add DMA engine support
Date: Thu, 7 Jun 2012 10:05:41 -0700
Message-ID: <20120607170541.GG12766@atomide.com>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
 <E1ScaYw-0003th-6i@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65449 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932338Ab2FGRFs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 13:05:48 -0400
Content-Disposition: inline
In-Reply-To: <E1ScaYw-0003th-6i@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jarkko Lavinen <jarkko.lavinen@nokia.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

* Russell King <rmk+kernel@arm.linux.org.uk> [120607 04:11]:
> Add DMA engine support to the OMAP driver.  This supplements the
> private DMA API implementation contained within this driver, and the
> driver can be switched at build time between using DMA engine and the
> private DMA API.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

This I boot tested on 770 and N800:

Tested-by: Tony Lindgren <tony@atomide.com>
