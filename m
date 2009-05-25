From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 05/10] ARM: OMAP1: Make 770 LCD work
Date: Mon, 25 May 2009 10:29:11 +0100
Message-ID: <20090525092911.GC28195@n2100.arm.linux.org.uk>
References: <20090519232905.12760.15490.stgit@localhost> <20090519233732.12760.34595.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34026 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbZEYJ3j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2009 05:29:39 -0400
Content-Disposition: inline
In-Reply-To: <20090519233732.12760.34595.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Imre Deak <imre.deak@nokia.com>, Andrew de Quincey <adq_dvb@lidskialf.net>, linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Tue, May 19, 2009 at 04:37:32PM -0700, Tony Lindgren wrote:
> Make 770 LCD work by passing the clock from platform data.
> Also remove the old unused functions.

I don't like this - because its passing struct clk's through platform
data.  That's not how things are supposed to work.

The way PXA solves this problem is to have clock aliases - see
clk_add_alias().
