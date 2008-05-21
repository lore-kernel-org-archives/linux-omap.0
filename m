From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: MMC/SD cards hotplug scenario
Date: Wed, 21 May 2008 08:30:17 +0100
Message-ID: <20080521073017.GB23427@flint.arm.linux.org.uk>
References: <004e01c8bb09$989fac00$538918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50138 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756134AbYEUHai (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2008 03:30:38 -0400
Content-Disposition: inline
In-Reply-To: <004e01c8bb09$989fac00$538918ac@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: 'Pierre Ossman' <drzeus@drzeus.cx>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

On Wed, May 21, 2008 at 11:42:04AM +0530, Madhusudhan Chikkature Rajashekar wrote:
> After the end of the I/O errors I can umount the partition that was
> mounted and I reinsert the card.

That's rather expected - outstanding IO has to be errored when the
medium is removed.

> It seem not to work very well consistently.

Vague handwaving comment with no useful information.  What precisely is
the problem that you're seeing?
