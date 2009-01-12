From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 06/10] ARM: OMAP: Fix DMA CCR programming for request line > 63
Date: Mon, 12 Jan 2009 15:58:19 +0000
Message-ID: <20090112155819.GA6152@n2100.arm.linux.org.uk>
References: <20090112144453.24205.18451.stgit@localhost> <5A47E75E594F054BAF48C5E4FC4B92AB02E678260F@dbde02.ent.ti.com> <20090112153526.GN9373@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60334 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbZALP6e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 10:58:34 -0500
Content-Disposition: inline
In-Reply-To: <20090112153526.GN9373@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Jan 12, 2009 at 05:35:28PM +0200, Tony Lindgren wrote:
> Well at least you could remove some parens.
> How about (dma_trigger / 32) << 19 instead?

Be very careful.  gcc 4.3.2 ignores the cost of calling its support
functions, so it could well decide to _actually_ do that as a divide
rather than the obvious bit clear.  Not only that, but the guys at
Simtec found that gcc 4.3.2 sometimes generates the optimal code
followed by the library call, followed by code overwrite the result
of the library call with the version from the optimal code!

This issue is the subject of an open gcc bug; and I believe is the
reason that kautobuild's compiler doesn't have ARMv7 support at the
moment.
