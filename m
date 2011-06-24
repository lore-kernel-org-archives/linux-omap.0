From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] OMAP3: PM: remove get_*_restore_pointer functions,
	directly use entry points
Date: Fri, 24 Jun 2011 08:55:23 +0100
Message-ID: <20110624075523.GJ9449@n2100.arm.linux.org.uk>
References: <1308874574-30663-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57147 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab1FXHze (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jun 2011 03:55:34 -0400
Content-Disposition: inline
In-Reply-To: <1308874574-30663-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Pihet <jean.pihet@newoldbits.com>

On Thu, Jun 23, 2011 at 05:16:14PM -0700, Kevin Hilman wrote:
> Applies on top of Russell's suspend cleanup/rejig, and available
> (along with Russell's series) in my pm-wip/idle-suspend branch.
> 
> Russell, since it depends on your series, feel free to add it to your
> series if you like.  Or if you prefer, we can take it through the OMAP
> tree.

Thanks, I've picked it up, and changed the prefix on the subject line
to match the rest of my series.  Also cleaned up the trailing tabs
and added Santosh's ack.
