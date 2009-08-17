From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: Exception while  handling MEM Hole on OMAP3 / ARM Cortex A8
Date: Mon, 17 Aug 2009 15:23:18 -0500
Message-ID: <A24693684029E5489D1D202277BE89444A8201BE@dlee02.ent.ti.com>
References: <20090808170300.GA23481@n2100.arm.linux.org.uk>
 <0680EC522D0CC943BC586913CF3768C003790C64CF@dbde02.ent.ti.com>
 <20090813173327.GA14872@n2100.arm.linux.org.uk>
 <0680EC522D0CC943BC586913CF3768C003790C6586@dbde02.ent.ti.com>
 <20090815153357.GF29616@n2100.arm.linux.org.uk>
 <0680EC522D0CC943BC586913CF3768C003790C65ED@dbde02.ent.ti.com>
 <20090815181711.GG29616@n2100.arm.linux.org.uk>
 <20090817173343.GA17323@debian>
 <20090817174718.GU10764@n2100.arm.linux.org.uk>
 <20090817180145.GA17378@debian>
 <20090817180455.GW10764@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58764 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757726AbZHQUUr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 16:20:47 -0400
In-Reply-To: <20090817180455.GW10764@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Rabin Vincent <rabin@rab.in>
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Russell King - ARM Linux
> Sent: Monday, August 17, 2009 1:05 PM
> To: Rabin Vincent
> Cc: Syed Mohammed, Khasim; linux-arm-kernel@lists.arm.linux.org.uk; linux-
> omap@vger.kernel.org
> Subject: Re: Exception while handling MEM Hole on OMAP3 / ARM Cortex A8
> 
> On Mon, Aug 17, 2009 at 11:31:45PM +0530, Rabin Vincent wrote:
> > When mid == 0, the loop exits because the condition you have is :
> >
> >   while ((mid = (right - left) / 2) > 0) {
> >                                   ^^^^^^
> >
> > Thus bank[0] will never be checked.
> 
> Ah yes, right.  Damn it.
> 
> Oh well, this will probably have to wait a couple of weeks now (by
> which time I expect I will have forgotten about the problem.)

How about this?:

#ifndef CONFIG_SPARSEMEM
int pfn_valid(unsigned long pfn)
{
	struct meminfo *mi = &meminfo;
	unsigned int left = 0, right = mi->nr_banks;

	while (left <= right) {
		unsigned int mid = (right - left) / 2;
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
EXPORT_SYMBOL(pfn_valid);
#endif

Regards,
Sergio

> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

