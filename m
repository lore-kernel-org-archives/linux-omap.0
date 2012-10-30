From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/13] ARM: OMAP: remove prcm.[ch]
Date: Tue, 30 Oct 2012 11:57:02 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210301156310.12697@utopia.booyaka.com>
References: <20121025231818.17558.57884.stgit@dusk.lan> <508E5B65.2020800@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47951 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab2J3L5D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Oct 2012 07:57:03 -0400
In-Reply-To: <508E5B65.2020800@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 29 Oct 2012, Vaibhav Hiremath wrote:

> 
> 
> On 10/26/2012 4:51 AM, Paul Walmsley wrote:
> > Remove arch/arm/mach-omap2/prcm.c and
> > arch/arm/plat-omap/include/plat/prcm.h.  This is in preparation for
> > moving the PRM/CM code to drivers/, although to be fair, these files
> > should have been removed a long time ago.
> > 
> > Intended for 3.8 cleanup.  Applies on top of the existing PRM/CM split
> > cleanup series, and the WDTIMER cleanup series.
> > 
> 
> Paul,
> 
> By any chance you have branch available with these patches, so that I
> can validate them here at my end?

The current version is at

git://git.pwsan.com/linux-2.6

in the branch

prcm_cleanup_b_3.8


- Paul
