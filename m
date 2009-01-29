From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH C 07/13] OMAP3 clock: recalculate DPLL subtree after bypass entry/exit
Date: Thu, 29 Jan 2009 10:33:01 +0000
Message-ID: <20090129103301.GB12627@n2100.arm.linux.org.uk>
References: <20090128190724.12092.22239.stgit@localhost.localdomain> <20090128190826.12092.12778.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40172 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979AbZA2KdN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jan 2009 05:33:13 -0500
Content-Disposition: inline
In-Reply-To: <20090128190826.12092.12778.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Wed, Jan 28, 2009 at 12:08:29PM -0700, Paul Walmsley wrote:
> The DPLL's rate changes when it enters or leaves bypass, so the DPLL's
> rate and the rates of all dependent clocks need to be recalculated
> when this happens.
> 
> Also, fix test for bypass to test against the appropriate bypass clock,
> rather than the parent clock (which is not the bypass clock for DPLL1
> and DPLL2).

Surely this is a bug fix to the previous patch?
