From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: dts: OMAP4+: remove multimedia carveouts
Date: Mon, 6 May 2013 14:36:54 +0200
Message-ID: <5187A3E6.4000208@ti.com>
References: <1366233990-29724-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52589 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753340Ab3EFMhI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 May 2013 08:37:08 -0400
In-Reply-To: <1366233990-29724-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org

Hi Suman,

On 04/17/2013 11:26 PM, Suman Anna wrote:
> The carveouts that have been reserved for multimedia usecases
> are not being used currently by any driver and so have been
> cleaned up. Memory will be allocated runtime through CMA for
> enabling the multimedia usecases.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>

Thanks for that cleanup. I'll queue that after the merge widow on top of
3.10-rc1.

Regards,
Benoit

> ---
>  arch/arm/boot/dts/omap4.dtsi | 8 --------
>  arch/arm/boot/dts/omap5.dtsi | 8 --------
>  2 files changed, 16 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 55c633a..79aaafe 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -6,14 +6,6 @@
>   * published by the Free Software Foundation.
>   */
>  
> -/*
> - * Carveout for multimedia usecases
> - * It should be the last 48MB of the first 512MB memory part
> - * In theory, it should not even exist. That zone should be reserved
> - * dynamically during the .reserve callback.
> - */
> -/memreserve/ 0x9d000000 0x03000000;
> -
>  /include/ "skeleton.dtsi"
>  
>  / {
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index c9ecdbe..7006554 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -7,14 +7,6 @@
>   * Based on "omap4.dtsi"
>   */
>  
> -/*
> - * Carveout for multimedia usecases
> - * It should be the last 48MB of the first 512MB memory part
> - * In theory, it should not even exist. That zone should be reserved
> - * dynamically during the .reserve callback.
> - */
> -/memreserve/ 0x9d000000 0x03000000;
> -
>  /include/ "skeleton.dtsi"
>  
>  / {
> 

