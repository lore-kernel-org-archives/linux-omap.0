From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 8/8] OMAP1 clock: convert mach-omap1/clock.h to
 mach-omap1/clock_data.c
Date: Thu, 3 Dec 2009 03:57:08 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912030355050.13408@utopia.booyaka.com>
References: <20091203095830.1203.76290.stgit@localhost.localdomain> <20091203100707.1203.98247.stgit@localhost.localdomain> <20091203102700.GA30423@flint.arm.linux.org.uk> <alpine.DEB.2.00.0912030331360.13408@utopia.booyaka.com>
 <20091203104354.GB20379@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56847 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755889AbZLCK5C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 05:57:02 -0500
In-Reply-To: <20091203104354.GB20379@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>

Hello Russell,

On Thu, 3 Dec 2009, Russell King - ARM Linux wrote:

> You say this, but you're keeping the associated code around as well
> which is pointless.

Could you elaborate?

> You also say about polluting the symbol table unnecessarily.  What
> about the pollution caused by having two (or more) functions made
> public rather than just one data structure?

Good point.  Will move the clkops structures to the appropriate clock.c 
files, and mark the functions static.


- Paul
