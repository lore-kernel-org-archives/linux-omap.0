From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP4: I2C: Enable FIFO usage for OMAP4
Date: Wed, 29 Jun 2011 16:23:57 -0700
Message-ID: <871uycql0y.fsf@ti.com>
References: <1309327221-4121-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:47483 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752348Ab1F2XYE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Jun 2011 19:24:04 -0400
In-Reply-To: <1309327221-4121-1-git-send-email-shubhrajyoti@ti.com>
	(Shubhrajyoti D.'s message of "Wed, 29 Jun 2011 11:30:21 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> Currently the fifo depth is set to zero for OMAP4 which disables
> the FIFO usage. This patch enables the FIFO usage for I2C transactions
> on OMAP4 also.

Do you know the history of why the FIFO depth was set to zero?  A
summary of that history would greatly help reviewers.

> Reported-By:Nishanth Menon <nm@ti.com>

minor: missing space after ':'

> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Tested on what platforms?   OMAP3 also?

Could you please rebase this onto my for_3.1/i2c-andy branch[1] where we
have a large series of I2C patches queued up for the v3.1 merge window
already? 

Thanks,

Kevin

[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git

