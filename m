From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCHv3 1/17] OMAP2/3/4:dmtimer:add device names to flck nodes
Date: Thu, 23 Sep 2010 00:30:55 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94027863D709@dbde02.ent.ti.com>
References: <1285059060-26316-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42178 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754848Ab0IVTBG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 15:01:06 -0400
In-Reply-To: <1285059060-26316-1-git-send-email-tarun.kanti@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Gopinath, Thara" <thara@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> DebBarma, Tarun Kanti
> Sent: Tuesday, September 21, 2010 2:21 PM
> To: linux-omap@vger.kernel.org
> Cc: Gopinath, Thara; Basak, Partha; DebBarma, Tarun Kanti; 
> Cousson, Benoit; Paul Walmsley; Kevin Hilman; Tony Lindgren
> Subject: [PATCHv3 1/17] OMAP2/3/4:dmtimer:add device names to 
> flck nodes
> 
> From: Thara Gopinath <thara@ti.com>
> 
> This patch adds device name info to OMAP2 dmtimer fclk nodes 
> so that the fclk nodes can be retrieved by doing a clk_get 
> with the corresponding device pointers.
> 
> Signed-off-by: Partha Basak <p-basak2@ti.com>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Cc: Cousson, Benoit <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/clock2420_data.c |   26 
> +++++++++++++++-----------
>  arch/arm/mach-omap2/clock2430_data.c |   26 
> +++++++++++++++-----------
>  arch/arm/mach-omap2/clock3xxx_data.c |   26 
> +++++++++++++++-----------
>  arch/arm/mach-omap2/clock44xx_data.c |   24 ++++++++++++++----------
>  4 files changed, 59 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock2420_data.c 
> b/arch/arm/mach-omap2/clock2420_data.c
> index 37d65d6..6378e6d 100644
> --- a/arch/arm/mach-omap2/clock2420_data.c
> +++ b/arch/arm/mach-omap2/clock2420_data.c
> @@ -1765,29 +1765,33 @@ static struct omap_clk omap2420_clks[] = {
>  	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_242X),
>  	/* general l4 interface ck, multi-parent functional clk */
>  	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_242X),
> +	/*
> +	 * gpt1 will be modified in subsequent patch when dmtimers
> +	 * will be fully converted to platform device
> +	 */

This comment can fit better in patch description instead of putting
it in source code.

