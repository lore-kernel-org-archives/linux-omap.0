From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [GIT PULL] ARM: OMAP5: hwmod, prm/cm data files and updates for
 3.10
Date: Mon, 15 Apr 2013 05:06:33 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EC55521@DBDE01.ent.ti.com>
References: <1363768852-18125-1-git-send-email-santosh.shilimkar@ti.com>
 <20130401170539.GK10155@atomide.com> <515BA76D.3000302@ti.com>
 <alpine.DEB.2.00.1304031146230.2616@utopia.booyaka.com>
 <515D6020.2030103@ti.com> <20130404165208.GI10155@atomide.com>
 <515DB110.9000503@ti.com> <515F00B8.3000501@ti.com>
 <79CD15C6BA57404B839C016229A409A83EC4A81D@DBDE01.ent.ti.com>
 <51654DC5.2040909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46037 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932513Ab3DOFGo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Apr 2013 01:06:44 -0400
In-Reply-To: <51654DC5.2040909@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Kristo, Tero" <t-kristo@ti.com>, "Menon, Nishanth" <nm@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Valentin, Eduardo" <eduardo.valentin@ti.com>, "Anna, Suman" <s-anna@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>


> -----Original Message-----
> From: Shilimkar, Santosh
> Sent: Wednesday, April 10, 2013 5:02 PM
> To: Hiremath, Vaibhav
> Cc: Tony Lindgren; Paul Walmsley; linux-omap@vger.kernel.org; linux-
> arm-kernel@lists.infradead.org; Kristo, Tero; Menon, Nishanth; Nayak,
> Rajendra; Valentin, Eduardo; Anna, Suman; Bedia, Vaibhav
> Subject: Re: [GIT PULL] ARM: OMAP5: hwmod, prm/cm data files and
> updates for 3.10
> 
> On Wednesday 10 April 2013 04:45 PM, Hiremath, Vaibhav wrote:
> >> -----Original Message-----
> >> From: Shilimkar, Santosh
> >> Sent: Friday, April 05, 2013 10:20 PM
> >> To: Tony Lindgren
> >> Cc: Paul Walmsley; linux-omap@vger.kernel.org; linux-arm-
> >> kernel@lists.infradead.org; Kristo, Tero; Menon, Nishanth; Nayak,
> >> Rajendra; Valentin, Eduardo; Anna, Suman; Bedia, Vaibhav; Hiremath,
> >> Vaibhav
> >> Subject: Re: [GIT PULL] ARM: OMAP5: hwmod, prm/cm data files and
> >> updates for 3.10
> >>
> >> On Thursday 04 April 2013 10:27 PM, Santosh Shilimkar wrote:
> >>> On Thursday 04 April 2013 10:22 PM, Tony Lindgren wrote:
> >>>> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130404 04:15]:
> >> [..]
> >>
> >>>> Can't we already trim the am33xx hwmod data after your patches for
> >>>> v3.10 as am33xx is already DT only? Unfortunately we cannot create
> >>>> negative diffstat in other ways for v3.10 merge window as we
> cannot
> >>>> make omap4 DT only just quite yet.
> >>>>
> >>> Yes we can and I can take a stab it tomorrow. The only thing is I
> >>> might need some support for testing but thats manageable. Will
> >>> take a stab at it tomorrow and if everything goes well, post a
> >>> patch for smae.
> >>>
> >> Patch for the AM33XX to trim is end of the email. Thanks to
> >> Sricharan and Pekon for patch and testing. Looping both
> >> Vaibhav's if they have any objection on the patch.
> >>
> >> Regards,
> >> Santosh
> >>
> >> From b95dd33fe59b8e77727eb3b1717d763bbf9a2893 Mon Sep 17 00:00:00
> 2001
> >> From: Sricharan R <r.sricharan@ti.com>
> >> Date: Fri, 5 Apr 2013 20:39:12 +0530
> >> Subject: [PATCH] ARM: AM33XX: hwmod data: Clean up the data file
> >>
> >> - The IO resource information like dma request lines, irq number and
> >> ocp address space can be populated via dt blob. So such data can be
> >> stripped
> >> from SOC hwmod data file.
> >>
> >> - The devices like adc, mailbox, gpmc which are missing the device
> >> tree bindings, hwmod data is not added since AM33XX is DT only
> build.
> >> When such devices add the dt bindings, respective hwmod data can be
> >> added along with it.
> >>
> > This seems unnecessary churn to me. DT bindings for most of the
> devices
> > which you mentioned above are submitted and are at various stages of
> review
> > process.
> >
> > ADC:
> >
> > GPMC:
> >
> > PWM:
> >
> The modules are dropped as per what is going for 3.10 merge window.
> Above 3 modules can be retained if the DT conversion patches are
> under review and can go along with this patch most likely for 3.11.
> 
> >
> >> - The hwmod like firewall etc which are not useful are also dropped.
> >>
> >> This gets us around ~2000 loc of negative diff. Patch is boot tested
> on
> >> AM335X EVM.
> >>
> > I would not recommend to get into unnecessary code churn in the
> future just
> > to reduce temp Number of Lines of code. This will also kill our
> autogeneration
> > concept as well.
> >
> It doesn't break any concept. We just autogenrate what is *useful*
> rather.
> BTW, I didn't find any srcipt to auto-generate the AM33XX data so we
> have
> to manually do the updates. Can you send me a pointer if you have a
> sript
> for this. With script it is much simpler to clean-up the data.
> 
> 
> > I would suggest you to just alone drop base-addr, irq and dma
> references
> > from hwmod entries.
> >
> That we are doing anyways. Apart from that we should also clean-up data
> which is not used and useful. Why do you need unused data like firewall
> and
> friends ?
> 
> So as I understood, you would like to keep the data for ADC, PWM and
> GPMC
> which is fine by me. We just need those DT bindings in place so that
> they
> go together. Who is following the DT patches for these ?
> 
> Thanks for looking into it Vaibhav.
> 
Are you planning to send updated version of this?
I would rather prefer to review next version.

Please let me know if you need any help here.

Thanks,
Vaibhav
