From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH] ARM:VFPv3:enable {d16-d31} access
Date: Thu, 27 May 2010 15:01:01 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03230B1D5B@dbde02.ent.ti.com>
References: <tarun.kanti@ti.com>
 <1274818736-26597-1-git-send-email-tarun.kanti@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0322FA884E@dbde02.ent.ti.com>
 <20100525185741.GB16204@n2100.arm.linux.org.uk>
 <5A47E75E594F054BAF48C5E4FC4B92AB0322FA8E37@dbde02.ent.ti.com>
 <20100526201017.GE6232@n2100.arm.linux.org.uk>
 <5A47E75E594F054BAF48C5E4FC4B92AB03230B1B3E@dbde02.ent.ti.com>
 <20100527092933.GB28112@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41926 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933159Ab0E0JbN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 05:31:13 -0400
In-Reply-To: <20100527092933.GB28112@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Thursday, May 27, 2010 3:00 PM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH] ARM:VFPv3:enable {d16-d31} access
> 
> On Thu, May 27, 2010 at 10:07:40AM +0530, DebBarma, Tarun Kanti wrote:
> > > Note the different registers.  Change "r1, r2" to "r0, r1" and it
> > > should work.
> >
> > Yes, that's right. I figured that out yesterday and confirmed the test
> > results. Thanks!
> 
> I've now committed a fix to change those registers.  Are you ok with
> being credited with a Reported-by tag?

That's fine!
