From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 12/14] ARM: OMAP1: Timer32K: Fix timer32K for clockevents and clean it up, take #2
Date: Tue, 25 Mar 2008 22:16:11 +0000
Message-ID: <20080325221611.GB3895@flint.arm.linux.org.uk>
References: <1205746958-11242-8-git-send-email-tony@atomide.com> <1205746958-11242-9-git-send-email-tony@atomide.com> <1205746958-11242-10-git-send-email-tony@atomide.com> <1205746958-11242-11-git-send-email-tony@atomide.com> <1205746958-11242-12-git-send-email-tony@atomide.com> <1205746958-11242-13-git-send-email-tony@atomide.com> <20080320165243.GD16166@flint.arm.linux.org.uk> <87y78dntfz.fsf@paris.hilman.org> <20080321120425.GA3732@flint.arm.linux.org.uk> <20080325100940.GQ14978@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59342 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885AbYCYWRH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Mar 2008 18:17:07 -0400
Content-Disposition: inline
In-Reply-To: <20080325100940.GQ14978@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@mvista.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

On Tue, Mar 25, 2008 at 12:09:41PM +0200, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [080321 14:05]:
> > Or just omit the bogus change from the original patch.
> 
> OK, here's the fixed patch.

Yup, is ok.
