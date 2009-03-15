From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 04/12] ARM: OMAP3: mmc-twl4030 fix name buffer length
Date: Sun, 15 Mar 2009 16:00:07 +0000
Message-ID: <20090315160007.GC10786@n2100.arm.linux.org.uk>
References: <20090310205824.16425.97745.stgit@localhost> <20090310210608.16425.95680.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47531 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbZCOQAV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Mar 2009 12:00:21 -0400
Content-Disposition: inline
In-Reply-To: <20090310210608.16425.95680.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>

On Tue, Mar 10, 2009 at 02:06:08PM -0700, Tony Lindgren wrote:
> From: Adrian Hunter <adrian.hunter@nokia.com>
> 
> Add 1 to buffer length for null terminator.

Yes, and:

                sprintf(twl->name, "mmc%islot%i", c->mmc, 1);

should be snprintf to ensure that it can't overflow the buffer.
