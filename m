From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [RFC 3/3] am35xx: pm: Hook-up with TPS65023
Date: Mon, 7 Mar 2011 22:01:24 +0530
Message-ID: <c8691dfff1a8ded9676c2f63d8e896c0@mail.gmail.com>
References: <1298483913-20344-1-git-send-email-premi@ti.com>
 <1298483913-20344-4-git-send-email-premi@ti.com> <6356620acee7ee78af7da3906b0ea78a@mail.gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024C0E5D33@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:52446 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751184Ab1CGQb1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 11:31:27 -0500
Received: by mail-vw0-f44.google.com with SMTP id 6so4507110vws.31
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 08:31:26 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C0E5D33@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org

> -----Original Message-----
> From: Premi, Sanjeev [mailto:premi@ti.com]
> Sent: Monday, March 07, 2011 8:51 PM
> To: Sripathy, Vishwanath; linux-omap@vger.kernel.org
> Subject: RE: [RFC 3/3] am35xx: pm: Hook-up with TPS65023
>
> > -----Original Message-----
> > From: Sripathy, Vishwanath
> > Sent: Thursday, February 24, 2011 3:35 PM
> > To: Premi, Sanjeev; linux-omap@vger.kernel.org
> > Subject: RE: [RFC 3/3] am35xx: pm: Hook-up with TPS65023
> >
> > Sanjeev,
> >
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > owner@vger.kernel.org] On Behalf Of Sanjeev Premi
> > > Sent: Wednesday, February 23, 2011 11:29 PM
> > > To: linux-omap@vger.kernel.org
> > > Cc: Sanjeev Premi
> > > Subject: [RFC 3/3] am35xx: pm: Hook-up with TPS65023
> > >
> > > Add glue logic to hook-up AM35x processors
> > > with TPS65023.
> > It seems that you are not really using Voltage layer for any
interaction
> > with TPS65023 as you are not using VP and VC. Then what is the
> purpose of
> > registering this PMIC with Voltage layer. I fail to understand the
> purpose
> > of this patch series.
>
> [sp] Then, can you suggest how do I get the AM35x EVM to boot? Given
> the
>      current limitation of all voltage related data being "extracted"
from
>      the voltage layer - which expects only TWLx0y0 PMICs.
Pls use regulator framework for setting the voltage for your PMIC.

Vishwa

>
> >
> > Vishwa
> > >
> > > Signed-off-by: Sanjeev Premi <premi@ti.com>
