Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795125047;
	b=o+Ta/6U0aqZWPAninaTKIDXyUOozCRe7jUj3v2LtQGGV2+4N7MvPB/FJRXw+ZhLPQOLs
	 hisnLgLBP61i5gNab/n2GhYq+v6HDF8WmCrcRvqcZsQEoshL9Pr0QbppF2g3lD3y+kVJ7
	 IT29Flp+qR1uLvd+HA84N3iUkzkkFE+vrYKVUmxFZOedNxjeVErA4a8IsrmFzmKJdNYBS
	 qzaulY+kJdKFjXt9DFwvC7GP52sx75ybq3IdFHpOBcPgt7xeP9rPQ5RMSnFuPPkJjoFo4
	 keLvIolu4gfwbgpYE1HQyCV2t8Wc3TCtR+Zny+iUHQkJ6rdOIExfXbqi+jnhfSN0vSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795125047;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vzam9azfkf4B2QjTL0Ocw4FvWfNSsyoxxQWc2bs79yk=;
	b=tPgvo9ySoNh9QhFINRPAZvUxdqDqEDGpfON/jJcdXp2S+2oCbQhbB0wcSq0B4+sW0irn
	 alZaqgP7/cF6bd/scvD7ppmU+aAQk6uEMxI1qYcEHZ9/t1p089T3avZBf5nsSqRV4AaDF
	 5PTgOFcKQ5F+jZ6PYsY+wsLFGQ3iDb55mOelXcl3bax1Xa87URsoKTsonxjFVdykzg4Cz
	 id/+gF6Ut8WAUEKnnlQbUSQHe9PCHtvE5eK8Ww0ckZHUS9ICnywJe+gbvjX3dwgZLMcgu
	 KJcAR7r5aA9+i9c6EfM1jYR3diRLRyuWqfWPTQQ/F/pxJOx2lqdtcK1Nf2As4HJKlkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=QZzhip07;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B541E606A320;
	Thu, 19 Nov 2026 21:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B541E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=QZzhip07
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=vzam9azfkf4B2QjTL0Ocw4FvWfNSsyoxxQWc2bs79yk=; t=1795125046; x=1796334646; 
	b=QZzhip079B0obmamkBNrBF2baTdS2f3I1oV2oniLlbeQsw3gAx3F9gsIYW0BASURvqnuqbwCggs
	ayx3DNyWnPTtRUgo0q1TUv0Lt2pz9wD96lOYuaykMZKfXESSfoZCth1H7hHiXJHAFPhyw5WwBWZip
	1MKMvbRfFr/zQVmosiqyjcs1Yp326JSE+Q9WJhugR0RgrLsqwnlMR8OrCaitMUoXkK4/7dhlOUb94
	aUgKfHkqCB4SnxPPdXciCIpc+xDRoApWv+C89JceVs4h7Tw3sbWhOXO3I22a1AOKjAovjKy3GDK/8
	+iCMtFdGhc+sfztZ4mUP7P04Tbfl1UTdGsLg==;
Date: Thu, 19 Nov 2026 22:50:17 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman
 <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Paul Walmsley
 <paul@pwsan.com>, Stephen Boyd <sboyd@kernel.org>, Brian Masney
 <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, Sandy
 Huang <hjc@rock-chips.com>, Heiko =?UTF-8?B?U3TDvGJuZXI=?=
 <heiko@sntech.de>, Andy Yan <andyshrk@163.com>, Ulf Hansson
 <ulfh@kernel.org>, linux-clk@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/6] [RFT] ARM: OMAP2+: Convert to
 dev_clk_get_from_provider()
Message-ID: <20261119225017.15a7b5cc@kemnade.info>
In-Reply-To: <683b5b189409e5ee04100044fb615b01cb877f3d.1795094688.git.geert+renesas@glider.be>
References: <cover.1795094688.git.geert+renesas@glider.be>
	<683b5b189409e5ee04100044fb615b01cb877f3d.1795094688.git.geert+renesas@glider.be>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Nov 2026 14:40:38 +0100
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> OMAP2+ clock handling uses of_clk_get_from_provider() to obtain clocks
> used for power management, so the latter show up as "deviceless" in the
> consumer column of the clk_summary file in debugfs.
> 
> Fix this by using dev_clk_get_from_provider() instead, letting us pass
> the consumer device, too.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested only.
> 
> The first change is probably OK.  The second change may fail if anything
> in the oh->od->pdev->dev chain is not available yet at this point.

Test on OMAP3:

$ diff -u clk-old clk-new
--- clk-old	2026-11-19 22:44:59.810807920 +0100
+++ clk-new	2026-11-19 22:26:52.862531880 +0100
@@ -1,17 +1,17 @@
                                  enable  prepare  protect                                duty  hardware                            connection
    clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                         id
 ---------------------------------------------------------------------------------------------------------------------------------------------
- oscillator                          0       0        0        26000000    0          0     50000      Y   deviceless                      of_clk_get_from_provider 
+ oscillator                          0       0        0        26000000    0          0     50000      Y   deviceless                      dev_clk_get_from_provider
                                                                                                            deviceless                      no_connection_id         
- secure_32k_fck                      0       1        0        32768       0          0     50000      Y   deviceless                      of_clk_get_from_provider 
+ secure_32k_fck                      0       1        0        32768       0          0     50000      Y   deviceless                      dev_clk_get_from_provider
                                                                                                            deviceless                      no_connection_id         
-    wdt1_fck                         0       0        0        32768       0          0     50000      Y      deviceless                      of_clk_get_from_provider 
+    wdt1_fck                         0       0        0        32768       0          0     50000      Y      deviceless                      dev_clk_get_from_provider
                                                                                                               deviceless                      no_connection_id         
     gpt12_fck                        0       1        0        32768       0          0     50000      Y      48304000.timer                  fck                      
                                                                                                               48304000.target-module          fck                      
-                                                                                                              deviceless                      of_clk_get_from_provider 
+                                                                                                              deviceless                      dev_clk_get_from_provider
                                                                                                               deviceless                      no_connection_id         
- dummy_ck                            0       0        0        0           0          0     50000      Y   deviceless                      of_clk_get_from_provider 
+ dummy_ck                            0       0        0        0           0          0     50000      Y   deviceless                      dev_clk_get_from_provider
                                                                                                            deviceless                      no_connection_id         
  mcbsp_clks                          0       5        0        0           0          0     50000      Y   deviceless                      mcbsp_clks               
                                                                                                            deviceless                      mcbsp_clks               
[...]
Regards,
Andreas
> ---
>  arch/arm/mach-omap2/omap_device.c | 2 +-
>  arch/arm/mach-omap2/omap_hwmod.c  | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
> index 77a75b0b9ae69c85..5695e0c8f2392eca 100644
> --- a/arch/arm/mach-omap2/omap_device.c
> +++ b/arch/arm/mach-omap2/omap_device.c
> @@ -73,7 +73,7 @@ static void _add_clkdev(struct omap_device *od, const char *clk_alias,
>  
>  		clkspec.np = of_find_node_by_name(NULL, clk_name);
>  
> -		r = of_clk_get_from_provider(&clkspec);
> +		r = dev_clk_get_from_provider(&od->pdev->dev, &clkspec);
>  
>  		rc = clk_register_clkdev(r, clk_alias,
>  					 dev_name(&od->pdev->dev));
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 03cd523dff874bb0..5e4123014909d4ac 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -147,6 +147,7 @@
>  #include <asm/system_misc.h>
>  
>  #include "clock.h"
> +#include "omap_device.h"
>  #include "omap_hwmod.h"
>  
>  #include "soc.h"
> @@ -796,7 +797,7 @@ static struct clk *_lookup_clkctrl_clk(struct omap_hwmod *oh)
>  				clkspec.args[0] = addr - provider->addr[0];
>  				clkspec.args[1] = 0;
>  
> -				clk = of_clk_get_from_provider(&clkspec);
> +				clk = dev_clk_get_from_provider(&oh->od->pdev->dev, &clkspec);
>  
>  				pr_debug("%s: %s got %p (offset=%x, provider=%pOF)\n",
>  					 __func__, oh->name, clk,

