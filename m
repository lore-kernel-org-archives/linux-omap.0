From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2 0/5] ARM: dts: OMAP2+: use preprocessor for device
 trees
Date: Tue, 28 May 2013 09:07:58 -0600
Message-ID: <51A4C84E.4070005@wwwdotorg.org>
References: <1369323421-4180-1-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:55088 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934474Ab3E1PIB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 May 2013 11:08:01 -0400
In-Reply-To: <1369323421-4180-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On 05/23/2013 09:36 AM, Florian Vaussard wrote:
> Hello,
> 
> Following a similar proposal by Stephen Warren for tegra [1], this series
> makes use of the C preprocessor when compiling OMAP DT files, and
> accomplishes some improvements to improve overall readability.
> 
> Patch 1 is a preparation for the rest of the series.
> Patch 2 uses existing constants for GPIOs. Patch 3 does the same for
> IRQs. Patch 4 creates a new header for OMAP's padmux, and patch 5 uses
> it to simplify pinctrl DT.
> 
> For all targets, the .dtb files were diff-tested before and after
> applying the series to guarantee identity.

The series briefly,

Reviewed-by: Stephen Warren <swarren@nvidia.com>
