From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: create dsp device only on OMAP3 SoCs
Date: Mon, 7 Jul 2014 03:41:58 -0700
Message-ID: <20140707104157.GL28884@atomide.com>
References: <1403587467-59876-1-git-send-email-s-anna@ti.com>
 <1403587467-59876-4-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53946 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbaGGKl4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jul 2014 06:41:56 -0400
Content-Disposition: inline
In-Reply-To: <1403587467-59876-4-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Suman Anna <s-anna@ti.com> [140623 22:26]:
> The DSP platform device for TI DSP/Bridge is currently
> created unconditionally whenever CONFIG_TIDSPBRIDGE is
> enabled. This device should only be created on OMAP34xx/
> OMAP36xx SoCs, and not for other OMAP3 derived SoCs or when
> booting multi-arch images on other SoCs. So, add a check for
> the SoC family both before creating the device and allocating
> the carveout memory for the device.

Applying this one into omap-for-v3/16/fixes thanks.

Tony
