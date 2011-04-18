From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH v2] Consolidate SRAM support
Date: Mon, 18 Apr 2011 17:18:17 +0100
Message-ID: <20110418161817.GB26044@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk> <20110418085259.GA26044@n2100.arm.linux.org.uk> <B85A65D85D7EB246BE421B3FB0FBB593024CA31B27@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44263 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754659Ab1DRQSr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Apr 2011 12:18:47 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024CA31B27@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nori, Sekhar" <nsekhar@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Apr 18, 2011 at 09:42:10PM +0530, Nori, Sekhar wrote:
> I was able to test this on DaVinci (DA850 suspend-to-RAM) with
> the following additional changes:
> 
> There was a sram_free call remaining in pm.c file.

Hmm, wonder why my build for DaVinci didn't pick that up.  Thanks for
that and I'll merge it in.

> diff --git a/arch/arm/mach-davinci/sleep.S b/arch/arm/mach-davinci/sleep.S
> index fb5e72b..dcb8e9d 100644
> --- a/arch/arm/mach-davinci/sleep.S
> +++ b/arch/arm/mach-davinci/sleep.S
> @@ -50,6 +50,8 @@
>   * 	r4: contains virtual address of the DEEPSLEEP register
>   */
>  ENTRY(davinci_cpu_suspend)
> +	.align 3
> +

I think you want the .align 3 on the line before ENTRY().

> The davinci audio driver in sound/soc/davinci/davinci-pcm.c uses
> the sram allocator too and would need to be converted to the
> new API.

Ah, right - I'll sort that too.  Slightly annoying that sound stuff
is outside the drivers/ subdir.
