From: Rabin Vincent <rabin@rab.in>
Subject: Re: Exception while  handling MEM Hole on OMAP3 / ARM Cortex A8
Date: Tue, 18 Aug 2009 08:31:49 +0530
Message-ID: <20090818030148.GA2283@debian>
References: <20090813173327.GA14872@n2100.arm.linux.org.uk>
 <0680EC522D0CC943BC586913CF3768C003790C6586@dbde02.ent.ti.com>
 <20090815153357.GF29616@n2100.arm.linux.org.uk>
 <0680EC522D0CC943BC586913CF3768C003790C65ED@dbde02.ent.ti.com>
 <20090815181711.GG29616@n2100.arm.linux.org.uk>
 <20090817173343.GA17323@debian>
 <20090817174718.GU10764@n2100.arm.linux.org.uk>
 <20090817180145.GA17378@debian>
 <20090817180455.GW10764@n2100.arm.linux.org.uk>
 <A24693684029E5489D1D202277BE89444A8201BE@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:59518 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbZHRDCF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 23:02:05 -0400
Received: by rv-out-0506.google.com with SMTP id k40so596711rvb.5
        for <linux-omap@vger.kernel.org>; Mon, 17 Aug 2009 20:02:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <A24693684029E5489D1D202277BE89444A8201BE@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Syed Mohammed, Khasim" <khasim@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Aug 17, 2009 at 03:23:18PM -0500, Aguirre Rodriguez, Sergio Alberto wrote:
> #ifndef CONFIG_SPARSEMEM
> int pfn_valid(unsigned long pfn)
> {
> 	struct meminfo *mi = &meminfo;
> 	unsigned int left = 0, right = mi->nr_banks;
> 
> 	while (left <= right) {

This condition will cause the while to loop forever when left == right
and pfn < bank_pfn_start(bank).

> 		unsigned int mid = (right - left) / 2;

This calculation is incorrect when left != 0 (also in the original
patch).

> 		struct membank *bank = &mi->bank[mid];
> 
> 		if (pfn < bank_pfn_start(bank))
> 			right = mid;
> 		else if (pfn >= bank_pfn_end(bank))
> 			left = mid + 1;
> 		else
> 			return 1;
> 	}
> 	return 0;
> }
> EXPORT_SYMBOL(pfn_valid);
> #endif

Here's a fixed version:

int pfn_valid(unsigned long pfn)
{
	struct meminfo *mi = &meminfo;
	unsigned int left = 0, right = mi->nr_banks;

	while (left < right) {
			unsigned int mid = (left + right) / 2;
			struct membank *bank = &mi->bank[mid];

			if (pfn < bank_pfn_start(bank))
				right = mid;
			else if (pfn >= bank_pfn_end(bank))
				left = mid + 1;
			else
				return 1;
	}

	return 0;
}

Rabin
