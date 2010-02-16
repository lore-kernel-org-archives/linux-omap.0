From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 08/13] OMAP3/4 clock: split into per-chip family
 files
Date: Tue, 16 Feb 2010 14:54:54 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002161453440.10478@utopia.booyaka.com>
References: <20100211181236.795.56094.stgit@localhost.localdomain> <20100211181706.795.84644.stgit@localhost.localdomain> <alpine.DEB.2.00.1002151755530.28188@utopia.booyaka.com> <20100216192301.GQ21755@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35162 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933311Ab0BPVyy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 16:54:54 -0500
In-Reply-To: <20100216192301.GQ21755@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Ranjith Lohithakshan <ranjithl@ti.com>

On Tue, 16 Feb 2010, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [100215 16:56]:
> > 
> > clock34xx_data.c now contains data for the OMAP34xx family, the
> > OMAP36xx family, and the OMAP3517 family, so rename it to
> > clock3xxx_data.c.  Rename clock34xx.c to clock3xxx.c, and move the
> > chip family-specific clock functions to clock34xx.c, clock36xx.c, or
> > clock3517.c, as appropriate.  So now "clock3xxx.*" refers to the OMAP3
> > superset.
> > 
> > The main goal here is to prepare to compile chip family-specific clock
> > functions only for kernel builds that target that chip family.  To get to
> > that point, we also need to add CONFIG_ARCH_* options for those other
> > chip families; that will be done in a future patch, planned for 2.6.35.
> 
> Just to comment on the naming, we should call additional cpu options
> CONFIG_CPU_OMAP3630 etc instead of CONFIG_ARCH_OMAP to avoid confusion.
> 
> I thought about renaming CONFIG_ARCH_OMAP2420 and CONFIG_ARCH_OMAP2430
> into CONFIG_CPU_OMAP2420 and CONFIG_CPU_OMAP2430, but as it covers
> a bunch of drivers too I've postponed that to 2.6.35.

Thanks, I've updated the patch description accordingly to reference
CONFIG_CPU_* rather than CONFIG_ARCH_*.


- Paul
