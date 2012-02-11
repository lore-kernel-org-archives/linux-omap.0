From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] arm: omap4: allow disabling MPU local timer if 32K
	timer is enabled
Date: Sat, 11 Feb 2012 10:03:51 +0000
Message-ID: <20120211100351.GB13587@n2100.arm.linux.org.uk>
References: <1328949085-4452-1-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60523 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754427Ab2BKKEE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 11 Feb 2012 05:04:04 -0500
Content-Disposition: inline
In-Reply-To: <1328949085-4452-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Feb 11, 2012 at 04:31:25PM +0800, Ming Lei wrote:
> With 32K gp timer, tick can be driven and system can run well, so
> allow MPU local timer to be disabled if someone requires it, otherwise
> MPU local timer is always chosen as the default clock_event_device.

The point being?

What if you want to use NO_HZ?
