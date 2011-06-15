From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RESEND PATCH 0/2] ARM IRQ Kconfig patches
Date: Wed, 15 Jun 2011 16:14:22 +0100
Message-ID: <20110615151422.GA2618@n2100.arm.linux.org.uk>
References: <1308142960-20767-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55705 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026Ab1FOPOk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jun 2011 11:14:40 -0400
Content-Disposition: inline
In-Reply-To: <1308142960-20767-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Wed, Jun 15, 2011 at 04:02:38PM +0300, Felipe Balbi wrote:
> I have lost count how many times I have sent
> these patches. Will someone either take them
> in or NAK them so I stop sending ??

It might help to copy the MMP and PXA people so that we get to hear
their side of the story.  It may be that they always require sparse
IRQ support to be enabled.

'cause at the moment I've no idea whether your patch is right or not.
