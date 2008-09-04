From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: cpu_is_omap15xx() doesn't get set for OMAP310
Date: Thu, 4 Sep 2008 23:10:27 +0100
Message-ID: <20080904221027.GI2309@flint.arm.linux.org.uk>
References: <20080904211036.GH2309@flint.arm.linux.org.uk> <20080904215109.GV23085@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51154 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbYIDWKp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 18:10:45 -0400
Content-Disposition: inline
In-Reply-To: <20080904215109.GV23085@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Thu, Sep 04, 2008 at 02:51:13PM -0700, Tony Lindgren wrote:
> The ugly short term fix would be to define IS_OMAP_CLASS in a different
> way for omap1 and omap2. Anyways, I can fix it properly unless you're
> already patching it.

Haven't pushed any fix for it; my temporary workaround for it was quite
hacky to the extent of breaking omap2.
