From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH v4 0/5] ARM: dts: OMAP2+: Use preprocessor for device
 trees
Date: Fri, 31 May 2013 14:53:56 +0200
Message-ID: <51A89D64.9000803@ti.com>
References: <1370003579-30219-1-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37922 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758Ab3EaMyd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 May 2013 08:54:33 -0400
In-Reply-To: <1370003579-30219-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Tony Lindgren <tony@atomide.com>, Stephen Warren <swarren@wwwdotorg.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hi Florian,

On 05/31/2013 02:32 PM, Florian Vaussard wrote:
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
> As for previous versions, the .dtb files were diff-tested before and after
> applying the series to guarantee identity for all targets.
> 
> The same series for AM3XXX will follow shortly.
> 
> Best regards,
> 
> Florian

Thanks for the series. I've just applied it and will push the update
for_3.11/dts branch ASAP.

Regards,
Benoit

