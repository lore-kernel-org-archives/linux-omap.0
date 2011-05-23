From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH] Fix generic irq chip
Date: Mon, 23 May 2011 15:23:09 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D09B1F7@dbde02.ent.ti.com>
References: <20110520220510.GC30675@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50883 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388Ab1EWJxn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 May 2011 05:53:43 -0400
In-Reply-To: <20110520220510.GC30675@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, Lennert Buytenhek <kernel@wantstofly.org>, Nicolas Pitre <nico@>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sat, May 21, 2011 at 03:35:10, Russell King - ARM Linux wrote:
> As a result of c42321c (genirq: Make generic irq chip depend on
> CONFIG_GENERIC_IRQ_CHIP), we now need those platforms using this in
> my tree to select this symbol.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> --
> Please send acks ASAP.  Thanks to Mark for pointing this out with a patch
> for Samsung.

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
