From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] arm: omap: Fix errors and warnings when building for
	one board
Date: Thu, 13 Oct 2011 15:56:15 +0100
Message-ID: <20111013145615.GB22076@n2100.arm.linux.org.uk>
References: <1318517623-16066-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57976 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755339Ab1JMO41 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Oct 2011 10:56:27 -0400
Content-Disposition: inline
In-Reply-To: <1318517623-16066-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Oct 13, 2011 at 08:23:43PM +0530, Sanjeev Premi wrote:
> +#if defined(CONFIG_ARCH_OMAP4)

Please use #ifdef unless you're intending to expand the condition.
