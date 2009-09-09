From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: Exception while  handling MEM Hole on OMAP3 / ARM Cortex A8
Date: Wed, 9 Sep 2009 10:12:48 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C0037CF20A00@dbde02.ent.ti.com>
References: <20090815153357.GF29616@n2100.arm.linux.org.uk>
 <0680EC522D0CC943BC586913CF3768C003790C65ED@dbde02.ent.ti.com>
 <20090815181711.GG29616@n2100.arm.linux.org.uk>
 <20090817173343.GA17323@debian>
 <20090817174718.GU10764@n2100.arm.linux.org.uk>
 <20090817180145.GA17378@debian>
 <20090817180455.GW10764@n2100.arm.linux.org.uk>
 <A24693684029E5489D1D202277BE89444A8201BE@dlee02.ent.ti.com>
 <20090818030148.GA2283@debian>
 <20090907142210.GB23361@n2100.arm.linux.org.uk>,<20090908202302.GE23361@n2100.arm.linux.org.uk>
 <A24693684029E5489D1D202277BE89444B781B03@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49957 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751117AbZIIEoD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Sep 2009 00:44:03 -0400
In-Reply-To: <A24693684029E5489D1D202277BE89444B781B03@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Rabin Vincent <rabin@rab.in>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello all,

> -----Original Message-----
> From: Aguirre Rodriguez, Sergio Alberto
> Sent: Wednesday, September 09, 2009 7:35 AM
> To: Russell King - ARM Linux; Rabin Vincent
> Cc: Syed Mohammed, Khasim; linux-arm-kernel@lists.arm.linux.org.uk; linux-
> omap@vger.kernel.org
> Subject: RE: Exception while handling MEM Hole on OMAP3 / ARM Cortex A8
> 
> From: Russell King - ARM Linux [linux@arm.linux.org.uk]
> Sent: Tuesday, September 08, 2009 11:23 PM
> > >
> > > Acks and tested-bys would be useful please.
> >
> > Haven't heard anything, so I've committed it as is.  It is my intention
> > to push it to Linus as is in the next couple of days.
> 
> Russell,
> 
> I don't have ways of testing this, but I think Khasim's testing will make
> more sense,
> since he reported the bug... anyways, it's probably too late.
> 
I am really sorry, wanted to try this out when RMK returns from vacation meanwhile forgot :(

The below logic from Rabin works great !!! no issues with this as well.

File arch/arm/mm/init.c

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

Thanks for all the help.

Regards,
Khasim
