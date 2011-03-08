From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/11] OMAP2+: clock: add clockfw autoidle for iclks,
 OMAP2xxx
Date: Mon, 7 Mar 2011 20:06:02 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103072005150.10981@utopia.booyaka.com>
References: <20110216065030.22089.61217.stgit@twilight.localdomain> <871v2qk177.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38649 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755775Ab1CHDGD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 22:06:03 -0500
In-Reply-To: <871v2qk177.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 1 Mar 2011, Kevin Hilman wrote:

> Paul Walmsley <paul@pwsan.com> writes:
> 
> > This patch series adds clock framework-controlled autoidle support for
> > the OMAP2xxx DPLL, APLLs, and OMAP2/3 interface clocks.  The old
> > direct register writes in the PM code to enable clock autoidle have been
> > removed.  
> >
> > This series also ensures that all clock autoidle is disabled during
> > boot and only re-enabled if CONFIG_PM is enabled.
> >
> > The series applies on the 'clk_autoidle_a_2.6.39' branch of
> > git://git.pwsan.com/linux-2.6.
> >
> > Boot-tested on N800, and dynamic idle-tested on OMAP3430 Beagleboard.
> > Compile-tested with omap1_defconfig, omap2plus_defconfig, a 5912
> > OSK-only config, an N8x0-only config, an OMAP3-only config, and an OMAP4-only
> > config.
> 
> Reviewed-by: Kevin Hilman <khilman@ti.com>

Thanks, added your Reviewed-by: on these.

> Feel free to merge the various pm*.c changes via your tree.


- Paul
