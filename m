From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH D 11/11] Fix omap1 clock issues
Date: Fri, 6 Feb 2009 21:44:50 +0000
Message-ID: <20090206214450.GN13758@n2100.arm.linux.org.uk>
References: <20090128191638.16688.33452.stgit@localhost.localdomain> <20090128191844.16688.39372.stgit@localhost.localdomain> <20090129143733.GB18233@n2100.arm.linux.org.uk> <alpine.DEB.2.00.0902061417390.26737@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33791 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485AbZBFVpF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Feb 2009 16:45:05 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0902061417390.26737@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Fri, Feb 06, 2009 at 02:19:34PM -0700, Paul Walmsley wrote:
> [paul@pwsan.com: This patch has been updated to use offsets for OMAP1 
> clock enable registers, to resolve all current sparse warnings with the 
> clock code, and to convert most magic constants into symbolic macros.  

Wish you hadn't; I've been avoiding the patches changing the way registers
are accessed for the time being - until I have an opportunity to think
about them for a bit.

As can be seen in the OMAP2 updates, this approach causes additional
struct clk's to appear for mcbsp clocks because they have controlling
registers split across two subsystems.  This is contary to one of your
other statements about wanting the struct clk's to reflect the real
clock structure without virtual clocks.
