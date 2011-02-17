From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 5/6] ARM: pm: convert samsung platforms to generic
	suspend/resume support
Date: Fri, 18 Feb 2011 08:46:36 +0900
Message-ID: <01b401cbcefc$ed4f51b0$c7edf510$%kim@samsung.com>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk>
 <E1Pnvhv-0002yp-A0@rmk-PC.arm.linux.org.uk>
 <017901cbce9b$7b405ee0$71c11ca0$%kim@samsung.com>
 <20110217140621.GC24989@n2100.arm.linux.org.uk>
 <01b001cbcef7$3e7f5f90$bb7e1eb0$%kim@samsung.com>
 <20110217232947.GA4110@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:35302 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401Ab1BQXqo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 18:46:44 -0500
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LGS007HTCPU4690@mailout1.samsung.com> for
 linux-omap@vger.kernel.org; Fri, 18 Feb 2011 08:46:42 +0900 (KST)
Received: from DOKGENEKIM02 ([12.23.103.104])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LGS00L59CPUHG@mmp2.samsung.com> for
 linux-omap@vger.kernel.org; Fri, 18 Feb 2011 08:46:42 +0900 (KST)
In-reply-to: <20110217232947.GA4110@n2100.arm.linux.org.uk>
Content-language: ko
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>
Cc: 'Eric Miao' <eric.y.miao@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Russell King - ARM Linux wrote:
> 
> On Fri, Feb 18, 2011 at 08:05:57AM +0900, Kukjin Kim wrote:
> > Russell King - ARM Linux wrote:
> > >
> > > On Thu, Feb 17, 2011 at 09:09:02PM +0900, Kukjin Kim wrote:
> > > > Hi Russell,
> > > >
> > > > I tested on SMDKV210(S5PV210) and SMDKC110(S5PC110).
> > >
> > > Thanks for testing.  It looks like I'm missing a load for r3 in the
> > > s5pv210 code.  The replacement patch below should resolve this.
> > >
> >
> > Hooray, it works fine ;)
> >
> > Tested-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> Thanks.  I'm assuming that applies to:
> 
> "ARM: pm: add generic CPU suspend/resume support"
> 
> too as you can't test this without that patch.

Yeah, it's ok to me :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

