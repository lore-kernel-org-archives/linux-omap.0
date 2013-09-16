From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH RFC v3 08/12] ARM: OMAP2+: CM: AM43x clockdomain data
Date: Mon, 16 Sep 2013 10:26:15 -0500
Message-ID: <52372317.3000901@ti.com>
References: <cover.1379337301.git.afzal@ti.com> <5dd3b417a32b7d52c7de1e19e69e6100b1ed991b.1379337301.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57229 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab3IPP06 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Sep 2013 11:26:58 -0400
In-Reply-To: <5dd3b417a32b7d52c7de1e19e69e6100b1ed991b.1379337301.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ambresh K <ambresh@ti.com>

On 09/16/2013 08:48 AM, Afzal Mohammed wrote:
> From: Ambresh K <ambresh@ti.com>
> 
> Add the data file to describe clock domains in AM43x SoC.
> OMAP4 clockdomain operations is being reused here.
> 
> Signed-off-by: Ambresh K <ambresh@ti.com>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/mach-omap2/clockdomain.h           |   2 +
>  arch/arm/mach-omap2/clockdomains43xx_data.c | 199 ++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/cminst44xx.c            |   9 ++
>  3 files changed, 210 insertions(+)
>  create mode 100644 arch/arm/mach-omap2/clockdomains43xx_data.c

I suggest we drop this. this can be addressed by Tero's clk series.


-- 
Regards,
Nishanth Menon
