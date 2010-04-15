From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 1/2 V4] OMAP: DSS: Add display board file for zoom
 boards
Date: Thu, 15 Apr 2010 13:56:21 +0300
Message-ID: <1271328981.2690.240.camel@tubuntu.research.nokia.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026EE415C2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:24809 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038Ab0DOK47 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Apr 2010 06:56:59 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026EE415C2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Y, Kishore" <kishore.y@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Sat, 2010-03-06 at 15:26 +0100, ext Y, Kishore wrote:
> From: Kishore Y <kishore.y@ti.com>
> 
> board-zoom-display.c added as a common file for display fucntionality
> on boards zoom2, zoom3 and 3630sdp
> 
> Signed-off-by: Mukund Mittal <mmittal@ti.com>
> Signed-off-by: Kishore Y <kishore.y@ti.com>
> Reviewed-by: Gadiyar, Anand <gadiyar@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile                  |    3 +
>  arch/arm/mach-omap2/board-zoom-display.c      |  158 +++++++++++++++++++++++++
>  arch/arm/mach-omap2/board-zoom-peripherals.c  |   50 ++++++++-
>  arch/arm/mach-omap2/include/mach/board-zoom.h |    3 +
>  4 files changed, 213 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-zoom-display.c

<snip>

>  
> +static struct regulator_consumer_supply zoom_vpll2_supply = {
> +	.supply         = "vdds_dsi",
> +};
> +
> +static struct regulator_consumer_supply zoom_vdda_dac_supply = {
> +	.supply         = "vdda_dac",
> +};

I think the same comments about regulators apply here as in this thread:

http://marc.info/?l=linux-omap&m=127107128203856&w=2

 Tomi


