From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 00/11] OMAP2+: clock: add clockfw autoidle for iclks, OMAP2xxx
Date: Tue, 01 Mar 2011 12:58:20 -0800
Message-ID: <871v2qk177.fsf@ti.com>
References: <20110216065030.22089.61217.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:39689 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756459Ab1CAU6Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 15:58:24 -0500
Received: by mail-iy0-f179.google.com with SMTP id 7so4728690iym.38
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 12:58:23 -0800 (PST)
In-Reply-To: <20110216065030.22089.61217.stgit@twilight.localdomain> (Paul
	Walmsley's message of "Tue, 15 Feb 2011 23:52:39 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> Hello,
>
> This patch series adds clock framework-controlled autoidle support for
> the OMAP2xxx DPLL, APLLs, and OMAP2/3 interface clocks.  The old
> direct register writes in the PM code to enable clock autoidle have been
> removed.  
>
> This series also ensures that all clock autoidle is disabled during
> boot and only re-enabled if CONFIG_PM is enabled.
>
> The series applies on the 'clk_autoidle_a_2.6.39' branch of
> git://git.pwsan.com/linux-2.6.
>
> Boot-tested on N800, and dynamic idle-tested on OMAP3430 Beagleboard.
> Compile-tested with omap1_defconfig, omap2plus_defconfig, a 5912
> OSK-only config, an N8x0-only config, an OMAP3-only config, and an OMAP4-only
> config.

Reviewed-by: Kevin Hilman <khilman@ti.com>

Feel free to merge the various pm*.c changes via your tree.

Kevin
