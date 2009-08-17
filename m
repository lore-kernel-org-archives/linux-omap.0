From: Rabin Vincent <rabin@rab.in>
Subject: Re: Exception while  handling MEM Hole on OMAP3 / ARM Cortex A8
Date: Mon, 17 Aug 2009 23:03:44 +0530
Message-ID: <20090817173343.GA17323@debian>
References: <0680EC522D0CC943BC586913CF3768C00378FF3971@dbde02.ent.ti.com>
 <20090807220016.GG31543@n2100.arm.linux.org.uk>
 <0680EC522D0CC943BC586913CF3768C003790C5B3A@dbde02.ent.ti.com>
 <20090808170300.GA23481@n2100.arm.linux.org.uk>
 <0680EC522D0CC943BC586913CF3768C003790C64CF@dbde02.ent.ti.com>
 <20090813173327.GA14872@n2100.arm.linux.org.uk>
 <0680EC522D0CC943BC586913CF3768C003790C6586@dbde02.ent.ti.com>
 <20090815153357.GF29616@n2100.arm.linux.org.uk>
 <0680EC522D0CC943BC586913CF3768C003790C65ED@dbde02.ent.ti.com>
 <20090815181711.GG29616@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f196.google.com ([209.85.216.196]:44228 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756918AbZHQRdw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 13:33:52 -0400
Received: by pxi34 with SMTP id 34so1292524pxi.4
        for <linux-omap@vger.kernel.org>; Mon, 17 Aug 2009 10:33:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090815181711.GG29616@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sat, Aug 15, 2009 at 07:17:11PM +0100, Russell King - ARM Linux wrote:
> +#ifndef CONFIG_SPARSEMEM
> +int pfn_valid(unsigned long pfn)
> +{
> +	struct meminfo *mi = &meminfo;
> +	unsigned int mid, left = 0, right = mi->nr_banks;
> +
> +	while ((mid = (right - left) / 2) > 0) {
> +		struct membank *bank = &mi->bank[mid];
> +
> +		if (pfn < bank_pfn_start(bank))
> +			right = mid;
> +		else if (pfn >= bank_pfn_end(bank))
> +			left = mid + 1;
> +		else
> +			return 1;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL(pfn_valid);
> +#endif

The above function will ignore the first bank.  I don't think that was
intended.

Rabin
