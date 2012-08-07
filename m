From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap2: mux: remove comment for nonexistent member
Date: Tue, 7 Aug 2012 00:51:18 -0700
Message-ID: <20120807075117.GS11011@atomide.com>
References: <1343317484-23228-1-git-send-email-michael.jones@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:23532 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830Ab2HGHvU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 03:51:20 -0400
Content-Disposition: inline
In-Reply-To: <1343317484-23228-1-git-send-email-michael.jones@matrix-vision.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Jones <michael.jones@matrix-vision.de>
Cc: linux-omap@vger.kernel.org

* Michael Jones <michael.jones@matrix-vision.de> [120726 08:54]:
> 
> Signed-off-by: Michael Jones <michael.jones@matrix-vision.de>
> ---
>  arch/arm/mach-omap2/mux.h |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
> index 471e62a..76f9b3c 100644
> --- a/arch/arm/mach-omap2/mux.h
> +++ b/arch/arm/mach-omap2/mux.h
> @@ -127,7 +127,6 @@ struct omap_mux_partition {
>   * @gpio:	GPIO number
>   * @muxnames:	available signal modes for a ball
>   * @balls:	available balls on the package
> - * @partition:	mux partition
>   */
>  struct omap_mux {
>  	u16	reg_offset;

Thanks applying into fixes.

Tony
