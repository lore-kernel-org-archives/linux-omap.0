From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/2] ARM: l2x0: Errata fix for flush by
 Wayoperationcancause data corruption
Date: Tue, 8 Mar 2011 11:30:59 +0530
Message-ID: <7e553a755c7d169b5a7848e0237eef75@mail.gmail.com>
References: <1298032525-21115-1-git-send-email-santosh.shilimkar@ti.com>
 <1298032525-21115-2-git-send-email-santosh.shilimkar@ti.com>
 <20110227120021.GA15314@n2100.arm.linux.org.uk> <20110228101351.GA30781@n2100.arm.linux.org.uk>
 <69dd173e3c7b4d02ef50ceaa19b2343a@mail.gmail.com> <000a01cbdcc0$3d0dfeb0$b729fc10$@deacon@arm.com>
 <491849bc08797fc8c4d0def52dd6308a@mail.gmail.com> <20110307191000.GC2400@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:45361 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751214Ab1CHGBB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 01:01:01 -0500
Received: by mail-qy0-f169.google.com with SMTP id 2so2698728qyk.7
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 22:01:00 -0800 (PST)
In-Reply-To: <20110307191000.GC2400@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>, tony@atomide.com, Catalin Marinas <Catalin.Marinas@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Tuesday, March 08, 2011 12:40 AM
> To: Santosh Shilimkar
> Cc: Will Deacon; tony@atomide.com; Catalin Marinas; linux-
> omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 1/2] ARM: l2x0: Errata fix for flush by
> Wayoperationcancause data corruption
>
> On Mon, Mar 07, 2011 at 05:55:22PM +0530, Santosh Shilimkar wrote:
> > Below is the updated version. Also attached.
> >
> > Russell,
> > Do you want me to push this to patch system or you can
> > apply this one?
>
> Patch system please.

Done.
patch 6795/1

Regards,
Santosh
