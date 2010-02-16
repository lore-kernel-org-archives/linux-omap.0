From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/13] OMAP: clock: cleanup series for 2.6.34
Date: Mon, 15 Feb 2010 17:55:32 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002151754570.28188@utopia.booyaka.com>
References: <20100211181236.795.56094.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55684 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932387Ab0BPAzd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 19:55:33 -0500
In-Reply-To: <20100211181236.795.56094.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 11 Feb 2010, Paul Walmsley wrote:

> this series, targeted for 2.6.34,
> 
> - fixes several OMAP clock bugs,
> 
> - removes several unnecessary clock structure fields and clock flags,
> 
> - splits the OMAP2420 and OMAP2430 clock trees in preparation for
>   multi-OMAP 2 kernels,
> 
> - and modularizes the OMAP3 chip family-specific clock code so
>   some code and data that is not applicable to a targeted build
>   can be elided during compilation.
> 
> The series has been boot-tested on the OMAP2430 SDP.  Further testing
> is now being undertaken on OMAP5912 OSK, N800 and OMAP3530 Beagle.

This series worked on N800 and Overo after minor changes to two of the 
patches - to follow shortly.


- Paul
