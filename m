From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 08/21] ARM: OMAP: SRAM: Move omap2 sram-fn.S to sram242x.S
Date: Sun, 22 Jun 2008 15:06:50 +0100
Message-ID: <20080622140650.GF21366@flint.arm.linux.org.uk>
References: <1212802253-17797-2-git-send-email-tony@atomide.com> <1212802253-17797-3-git-send-email-tony@atomide.com> <1212802253-17797-4-git-send-email-tony@atomide.com> <1212802253-17797-5-git-send-email-tony@atomide.com> <1212802253-17797-6-git-send-email-tony@atomide.com> <1212802253-17797-7-git-send-email-tony@atomide.com> <1212802253-17797-8-git-send-email-tony@atomide.com> <1212802253-17797-9-git-send-email-tony@atomide.com> <20080614080553.GI32122@flint.arm.linux.org.uk> <20080617073613.GE13078@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54215 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbYFVOHB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Jun 2008 10:07:01 -0400
Content-Disposition: inline
In-Reply-To: <20080617073613.GE13078@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Tue, Jun 17, 2008 at 10:36:14AM +0300, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [080614 11:06]:
> > On Fri, Jun 06, 2008 at 06:30:40PM -0700, Tony Lindgren wrote:
> > > This file will get split between sram242x.S and sram243x.S
> > > in following patch.
> > > 
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > Please use '-M' so git diff detects renames.
> 
> Here's the updated patch with diff -M.

Ok.
