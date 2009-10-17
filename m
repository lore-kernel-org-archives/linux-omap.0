From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 05/14] omap: Use ioremap in gpio.c
Date: Sat, 17 Oct 2009 09:10:04 +0100
Message-ID: <20091017081004.GA648@n2100.arm.linux.org.uk>
References: <20091016233624.2463.26653.stgit@localhost> <20091016234104.2463.54276.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41990 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbZJQIKN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Oct 2009 04:10:13 -0400
Content-Disposition: inline
In-Reply-To: <20091016234104.2463.54276.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Fri, Oct 16, 2009 at 04:41:04PM -0700, Tony Lindgren wrote:
> +	{ OMAP1_MPUIO_VBASE, 0, INT_MPUIO, IH_MPUIO_BASE,

That 0 should be NULL - it's a pointer.
