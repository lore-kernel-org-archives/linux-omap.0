From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 2/4] ARM: add flush_mem api for ARMv6
Date: Wed, 20 Jun 2012 09:45:47 +0100
Message-ID: <20120620084547.GB13009@n2100.arm.linux.org.uk>
References: <CADysL2acF3ttJ-TR2as+GT66MfJiK4YyWYaAiP5j8yQ+YLBGYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58911 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754678Ab2FTIpz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jun 2012 04:45:55 -0400
Content-Disposition: inline
In-Reply-To: <CADysL2acF3ttJ-TR2as+GT66MfJiK4YyWYaAiP5j8yQ+YLBGYQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ramesh" <grgupta@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tony@atomide.com

On Tue, Jun 19, 2012 at 04:51:16PM +0530, Gupta, Ramesh wrote:
> >From 630a3a8f341eb7f58f9a63bf786d732b5bdfd01e Mon Sep 17 00:00:00 2001
> From: Ramesh Gupta G <grgupta@ti.com>
> Date: Fri, 15 Jun 2012 16:39:21 +0530
> Subject: [PATCH v2 2/4] ARM: add flush_mem api for ARMv6
> 
> Added flush_mem cache maintenance api for ARMv6.
> The implementation is based on dma_flush_range.

And what about all the other users of the define_cache_functions macro?

This series is incomplete, and therefore entirely unsuitable for
upstreaming.
