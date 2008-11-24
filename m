From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: Parse ATAG_VIDEOLFB to screen_info
Date: Mon, 24 Nov 2008 12:12:17 +0000
Message-ID: <20081124121217.GB5330@flint.arm.linux.org.uk>
References: <1227263136-14862-1-git-send-email-tomi.valkeinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60688 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868AbYKXMMb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2008 07:12:31 -0500
Content-Disposition: inline
In-Reply-To: <1227263136-14862-1-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Fri, Nov 21, 2008 at 12:25:36PM +0200, Tomi Valkeinen wrote:
> Parse ATAG_VIDEOLFB received from bootloader to screen_info struct,
> so that video drivers can use the information.

Boot loaders tend to be absolutely diabolical about passing correct
information to the kernel, so I really don't want to see such platform
specific stuff being passed.  Please put it in the board specific file
instead, just like everyone else does.
