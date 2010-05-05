From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RESEND PATCHv3 0/4] Adding soc related info into /proc/cpuinfo
Date: Wed, 5 May 2010 09:59:32 +0100
Message-ID: <20100505085932.GA7703@n2100.arm.linux.org.uk>
References: <1273048928-6105-1-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42192 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933344Ab0EEI7u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 04:59:50 -0400
Content-Disposition: inline
In-Reply-To: <1273048928-6105-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: linux-arm-kernel@lists.infradead.org, Linux-OMAP <linux-omap@vger.kernel.org>, ext Tony Lindgren <tony@atomide.com>, "\"De-Schrijver Peter (Nokia-D/Helsinki)\"" <Peter.De-Schrijver@nokia.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, santosh.shilimkar@ti.com, felipe.balbi@nokia.com

On Wed, May 05, 2010 at 11:42:04AM +0300, Eduardo Valentin wrote:
> I'm resending this series with minor change in the subject prefix of patch 4/4.
> Removed the PM: prefix. Everything else is same. So, I kept the v3 prefix as well.

I'd much prefer to see a /proc/socinfo rather than extending
/proc/cpuinfo to further include stuff which isn't CPU related.
