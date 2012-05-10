From: Sricharan R <r.sricharan@ti.com>
Subject: RE: [PATCH 2/4] ARM: OMAP2+: Move the stubbed prm and cm functions to
 prcm.c file and make them __weak.
Date: Thu, 10 May 2012 23:14:49 +0530
Message-ID: <342784e3cecaf14d95b4e1c648726da1@mail.gmail.com>
References: <1336669615-16454-1-git-send-email-r.sricharan@ti.com>
 <1336669615-16454-3-git-send-email-r.sricharan@ti.com> <alpine.DEB.2.00.1205101140230.32719@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:44591 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760659Ab2EJRoy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 13:44:54 -0400
Received: by lban1 with SMTP id n1so1245196lba.10
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 10:44:51 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1205101140230.32719@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, tony@atomide.com, Benoit Cousson <b-cousson@ti.com>, paul@pswan.com

Hi Paul,
>
> On Thu, 10 May 2012, R Sricharan wrote:
>
> > Some prm and cm registers read/write and status functions
> > are built only for some custom OMAP2+ builds and are stubbed
> > in header files for other builds under ifdef statements.
> > But this results in adding new CONFIG_ARCH_OMAPXXX
> > checks when SOCs are added in the future. So move them
> > to a common place for OMAP2+ and make them 'weak' implementations.
>
> Thanks for the patch.  These stubs aren't needed any longer, so we can
> just get rid of them; no need to mark them __weak.  I've got a patch to
> just drop them here to be posted soon as part of a larger PRCM cleanup.
>
  Thanks. I will pick up your series.

Thanks,
 Sricharan
