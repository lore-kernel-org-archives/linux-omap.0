From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 10/12] arm: omap3: am35x: Add minimal EMIF4 support
Date: Wed, 11 Apr 2012 15:31:25 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204111529120.29473@utopia.booyaka.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com> <1334171147-7517-11-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44077 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932867Ab2DKVb0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 17:31:26 -0400
In-Reply-To: <1334171147-7517-11-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, aneesh@ti.com

cc Aneesh

On Wed, 11 Apr 2012, Mark A. Greer wrote:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> The typical SDRAM Controller Subsystem module (SDRC)
> on TI OMAP3 devices has two submodules: the SDRAM Memory
> Scheduler (SMS) submodule, and the SDRC submodule--the
> 'SDRC' acronym/term is overloaded.  The am35x family of
> devices is different in that it has an EMIF4 submodule
> instead of an SDRC submodule.  The SMS submodules are
> similar, though.

The best thing to do is to add an EMIF driver stub that is initialized 
based on hwmod data, rather than hacking this into the existing SDRC.

I don't know what the current state of the EMIF driver is.  Aneesh, 
do you know what the current status is?

If it's not going upstream for some reason, then I'd suggest adding 
arch/arm/mach-omap2/emif.c for now.


- Paul
