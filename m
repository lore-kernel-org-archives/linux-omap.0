From: Jeremy Kerr <jeremy.kerr@canonical.com>
Subject: Re: [RFC] Initial attempt to make ARM use LMB
Date: Wed, 31 Mar 2010 14:43:13 +0800
Message-ID: <201003311443.13568.jeremy.kerr@canonical.com>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:51319 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932798Ab0CaGnY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Mar 2010 02:43:24 -0400
In-Reply-To: <20100325233248.GM24984@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Hi Russell,

> LMB... logical memory blocks.

Nice, will be good for the DT work too.

> @@ -483,6 +484,13 @@ static void __init build_mem_type_table(void)
> 
>  #define vectors_base()	(vectors_high() ? 0xffff0000 : 0)
> 
> +static void __init *early_alloc(unsigned long sz)
> +{
> +      void *ptr = __va(lmb_alloc(sz, sz));
> +      memset(ptr, 0, PAGE_SIZE);

memset(ptr, 0, sz) ?

Cheers,


Jeremy

