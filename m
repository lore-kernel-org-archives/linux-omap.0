From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC 3/3] am35xx: pm: Hook-up with TPS65023
Date: Tue, 8 Mar 2011 17:56:27 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C0E6349@dbde02.ent.ti.com>
References: <1298483913-20344-1-git-send-email-premi@ti.com>
 <1298483913-20344-4-git-send-email-premi@ti.com>
 <6356620acee7ee78af7da3906b0ea78a@mail.gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024C0E5D33@dbde02.ent.ti.com>
 <c8691dfff1a8ded9676c2f63d8e896c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33032 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754038Ab1CHM0f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 07:26:35 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p28CQWBW001696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 8 Mar 2011 06:26:35 -0600
In-Reply-To: <c8691dfff1a8ded9676c2f63d8e896c0@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Sripathy, Vishwanath
> Sent: Monday, March 07, 2011 10:01 PM
> To: Premi, Sanjeev; linux-omap@vger.kernel.org
> Subject: RE: [RFC 3/3] am35xx: pm: Hook-up with TPS65023

[snip]...[snip]

> > > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > > owner@vger.kernel.org] On Behalf Of Sanjeev Premi
> > > > Sent: Wednesday, February 23, 2011 11:29 PM
> > > > To: linux-omap@vger.kernel.org
> > > > Cc: Sanjeev Premi
> > > > Subject: [RFC 3/3] am35xx: pm: Hook-up with TPS65023
> > > >
> > > > Add glue logic to hook-up AM35x processors
> > > > with TPS65023.
> > > It seems that you are not really using Voltage layer for any
> interaction
> > > with TPS65023 as you are not using VP and VC. Then what is the
> > purpose of
> > > registering this PMIC with Voltage layer. I fail to understand the
> > purpose
> > > of this patch series.
> >
> > [sp] Then, can you suggest how do I get the AM35x EVM to boot? Given
> > the
> >      current limitation of all voltage related data being "extracted"
> from
> >      the voltage layer - which expects only TWLx0y0 PMICs.
> Pls use regulator framework for setting the voltage for your PMIC.

[sp] If you follow the current framework, voltage.c is ingrained with
OMAP3 initialization and same holds good for opp[_3xxx_data].c.

It would have been great if current implementation allowed pluggable
interface to a PMIC. As it stands today, it isn't.

Until implemented, workarounds have to be put in place to get platform(s)
working. Though patch series is being done for AM35x with TPS65023. The
similar workaround would be required for OMAP3 with TPS65023 (for example).

...and I expect workaround to be simple and unobtrusive.

See:
core_initcall(omap_voltage_early_init);
device_initcall(omap3_opp_init);
late_initcall(omap2_common_pm_late_init);

~sanjeev

[snip]..[snip]
