From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [RFC 3/3] am35xx: pm: Hook-up with TPS65023
Date: Tue, 8 Mar 2011 18:15:36 +0530
Message-ID: <6f69c5cb653971e7b50cdd68239c80c8@mail.gmail.com>
References: <1298483913-20344-1-git-send-email-premi@ti.com>
 <1298483913-20344-4-git-send-email-premi@ti.com> <6356620acee7ee78af7da3906b0ea78a@mail.gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024C0E5D33@dbde02.ent.ti.com>
 <c8691dfff1a8ded9676c2f63d8e896c0@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB593024C0E6349@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:34075 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752250Ab1CHMpi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 07:45:38 -0500
Received: by mail-vx0-f174.google.com with SMTP id 39so5727425vxi.5
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 04:45:37 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C0E6349@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org

> -----Original Message-----
> From: Premi, Sanjeev [mailto:premi@ti.com]
> Sent: Tuesday, March 08, 2011 5:56 PM
> To: Sripathy, Vishwanath; linux-omap@vger.kernel.org
> Subject: RE: [RFC 3/3] am35xx: pm: Hook-up with TPS65023
>
> > -----Original Message-----
> > From: Sripathy, Vishwanath
> > Sent: Monday, March 07, 2011 10:01 PM
> > To: Premi, Sanjeev; linux-omap@vger.kernel.org
> > Subject: RE: [RFC 3/3] am35xx: pm: Hook-up with TPS65023
>
> [snip]...[snip]
>
> > > > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > > > owner@vger.kernel.org] On Behalf Of Sanjeev Premi
> > > > > Sent: Wednesday, February 23, 2011 11:29 PM
> > > > > To: linux-omap@vger.kernel.org
> > > > > Cc: Sanjeev Premi
> > > > > Subject: [RFC 3/3] am35xx: pm: Hook-up with TPS65023
> > > > >
> > > > > Add glue logic to hook-up AM35x processors
> > > > > with TPS65023.
> > > > It seems that you are not really using Voltage layer for any
> > interaction
> > > > with TPS65023 as you are not using VP and VC. Then what is the
> > > purpose of
> > > > registering this PMIC with Voltage layer. I fail to understand the
> > > purpose
> > > > of this patch series.
> > >
> > > [sp] Then, can you suggest how do I get the AM35x EVM to boot?
> Given
> > > the
> > >      current limitation of all voltage related data being
"extracted"
> > from
> > >      the voltage layer - which expects only TWLx0y0 PMICs.
> > Pls use regulator framework for setting the voltage for your PMIC.
>
> [sp] If you follow the current framework, voltage.c is ingrained with
> OMAP3 initialization and same holds good for opp[_3xxx_data].c.
>
> It would have been great if current implementation allowed pluggable
> interface to a PMIC. As it stands today, it isn't.
Pls suggest what kind of pluggable interfaces you are looking for.
I would expect basic PM IC initialization to be done as part of
corresponding PMIC code and voltage layer is not the place to do PMIC
initialization.

Vishwa
>
> Until implemented, workarounds have to be put in place to get
> platform(s)
> working. Though patch series is being done for AM35x with TPS65023.
> The
> similar workaround would be required for OMAP3 with TPS65023 (for
> example).
>
> ...and I expect workaround to be simple and unobtrusive.
>
> See:
> core_initcall(omap_voltage_early_init);
> device_initcall(omap3_opp_init);
> late_initcall(omap2_common_pm_late_init);
>
> ~sanjeev
>
> [snip]..[snip]
