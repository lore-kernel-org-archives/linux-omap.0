From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] arm: omap: fix trivial warnings for dspbridge
Date: Fri, 4 May 2012 10:31:24 -0700
Message-ID: <20120504173124.GF5613@atomide.com>
References: <1335191549-1047-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:10060 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094Ab2EDRb1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 13:31:27 -0400
Content-Disposition: inline
In-Reply-To: <1335191549-1047-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Jiri Kosina <trivial@kernel.org>, linux-arm-kernel@lists.infradead.org, Omar Ramirez Luna <omar.ramirez@ti.com>

* Felipe Contreras <felipe.contreras@gmail.com> [120423 07:36]:
> arch/arm/plat-omap/devices.c: In function 'omap_dsp_reserve_sdram_memblock':
> arch/arm/plat-omap/devices.c:170: warning: format '%x' expects type 'unsigned int', but argument 3 has type 'phys_addr_t'
> arch/arm/mach-omap2/dsp.c: In function 'omap_dsp_init':
> arch/arm/mach-omap2/dsp.c:60: warning: format '%x' expects type 'unsigned int', but argument 3 has type 'phys_addr_t'
> arch/arm/mach-omap2/dsp.c:60: warning: format '%x' expects type 'unsigned int', but argument 4 has type 'phys_addr_t'

Thanks I'll apply this into fixes-non-critical.

Tony
