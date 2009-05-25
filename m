From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 09/10] ARM: OMAP2/3: Add generic smc91x support when
	connected to GPMC
Date: Mon, 25 May 2009 10:46:38 +0100
Message-ID: <20090525094638.GF28195@n2100.arm.linux.org.uk>
References: <20090519232905.12760.15490.stgit@localhost> <20090519234245.12760.17479.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46906 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbZEYJqq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2009 05:46:46 -0400
Content-Disposition: inline
In-Reply-To: <20090519234245.12760.17479.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Tue, May 19, 2009 at 04:42:45PM -0700, Tony Lindgren wrote:
> Convert the board-rx51 smc91x code to be generic and make
> the boards to use it. This allows future recalculation of the
> timings when the source clock gets scaled.

Same complaint about splitting the stub function from where it's
used - it's worse than wrapping the call in an ifdef itself.
