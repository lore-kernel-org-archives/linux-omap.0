From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] ARM: OMAP2+: CLEANUP: Remove ARCH_OMAPx ifdef from
 struct dpll_data
Date: Tue, 15 May 2012 05:41:34 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA25E11@DBDE01.ent.ti.com>
References: <1336716163-2960-1-git-send-email-hvaibhav@ti.com>
 <87zk9apfjo.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38517 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab2EOFlo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 May 2012 01:41:44 -0400
In-Reply-To: <87zk9apfjo.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "R, Sricharan" <r.sricharan@ti.com>

On Tue, May 15, 2012 at 03:54:11, Hilman, Kevin wrote:
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
> > From: Kevin Hilman <khilman@ti.com>
> >
> > There are certain fields inside 'struct dpll_data' which are
> > included under ARCH_OMAP3 and ARCH_OMAP4 option, which makes it
> > difficult to use it for new devices like, am33xx, ti81xx, etc...
> >
> > So remove the ifdef completely, this will add few fields to the struct
> > unused, but it improves readability and maintainability of the code.
> >
> > Signed-off-by: Kevin Hilman <khilman@ti.com>
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: R Sricharan <r.sricharan@ti.com>
> > ---
> > Since Kevin had provided this idea and code change,
> > making this patch under his authorship.
> 
> Be sure to give yourself credit for writing the changelog.  Normally, if
> you make changes/additions to patch, you can add a line just before your
> signoff.  Something like:
> 
> [hvaibhav@ti.com: wrote detailed changelog]
> 

Ok...

Paul,
Can you please add above statement, when you merge it into your repo?


Thanks,
Vaibhav
