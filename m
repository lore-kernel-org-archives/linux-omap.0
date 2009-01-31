From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH F 10/12] OMAP2/3 clock: omap2_clk_enable(): fix logic
Date: Sat, 31 Jan 2009 10:58:48 +0000
Message-ID: <20090131105848.GC1394@n2100.arm.linux.org.uk>
References: <20090128193326.2396.9437.stgit@localhost.localdomain> <20090128193525.2396.11744.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58972 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbZAaK7B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Jan 2009 05:59:01 -0500
Content-Disposition: inline
In-Reply-To: <20090128193525.2396.11744.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Wed, Jan 28, 2009 at 12:35:28PM -0700, Paul Walmsley wrote:
> Rearrange the parent clock enable status check code so it actually makes
> sense.  No functional change.

I don't think there's anything gained from introducing the additional
'parent_ret' variable.
