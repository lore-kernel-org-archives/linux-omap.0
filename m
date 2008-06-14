From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 18/21] ARM: OMAP: Remove __REG access for multi-omap
Date: Sat, 14 Jun 2008 10:06:01 +0100
Message-ID: <20080614090601.GO32122@flint.arm.linux.org.uk>
References: <1212802253-17797-10-git-send-email-tony@atomide.com> <1212802253-17797-11-git-send-email-tony@atomide.com> <1212802253-17797-12-git-send-email-tony@atomide.com> <1212802253-17797-13-git-send-email-tony@atomide.com> <1212802253-17797-14-git-send-email-tony@atomide.com> <1212802253-17797-15-git-send-email-tony@atomide.com> <1212802253-17797-16-git-send-email-tony@atomide.com> <1212802253-17797-17-git-send-email-tony@atomide.com> <1212802253-17797-18-git-send-email-tony@atomide.com> <1212802253-17797-19-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50141 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758412AbYFNJGO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Jun 2008 05:06:14 -0400
Content-Disposition: inline
In-Reply-To: <1212802253-17797-19-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Fri, Jun 06, 2008 at 06:30:50PM -0700, Tony Lindgren wrote:
> This does not play nicely with multi-omap as it cannot be replaced
> by a function in io.c for omaps with different IO bases.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Ok.
