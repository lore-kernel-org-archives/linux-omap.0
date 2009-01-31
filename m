From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH B 03/10] OMAP2/3 clockdomains: add CM, PRM, virt_opp_clkdm clockdomains
Date: Sat, 31 Jan 2009 14:09:35 +0000
Message-ID: <20090131140935.GI1394@n2100.arm.linux.org.uk>
References: <20090128024301.27240.39391.stgit@localhost.localdomain> <20090128024411.27240.28757.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58135 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbZAaOJr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Jan 2009 09:09:47 -0500
Content-Disposition: inline
In-Reply-To: <20090128024411.27240.28757.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

On Tue, Jan 27, 2009 at 07:44:15PM -0700, Paul Walmsley wrote:
> Add clockdomains for the CM and PRM.  These replace "wkup_clkdm", a
> placeholder clockdomain which does not exist on the hardware.  Add a
> clockdomain for virtual OPP clocks, "virt_opp_clkdm".  Mark all clocks
> in the clock tree with a valid clockdomain.
> 
> The following TI documents are used as reference:
> 
> OMAP2420 Multimedia Processor Silicon Revision 2.1.1, 2.2 TRM Version Q
> OMAP34xx Multimedia Device Silicon Revision 3.0 Version I TRM
> OMAP34xx Multimedia High Security (HS) Device Silicon Revision 3.0 Security
>     Addendum Version B TRM
> 
> This patch includes an earlier fix to sys_clkout2's clockdomain by
> Tomi Valkeinen <tomi.valkeinen@nokia.com>.
> 
> linux-omap source commits are a4061e5422dae1433264b40178f73dc6f1d6d748,
> 859207f04c6b64ee714a65a58ee629ddde91bfa8, and
> f34f5bdd731fe828241d729fd465612a56d7e35f.

Given my comments on F6, I've so far avoided merging 859207f.
