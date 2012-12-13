From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 01/10] ARM: OMAP3/4: cpuidle: fix sparse and checkpatch
 warnings
Date: Thu, 13 Dec 2012 09:18:18 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EBAF7FB@DBDE01.ent.ti.com>
References: <20121209011755.19716.25244.stgit@dusk.lan>
 <20121209012334.19716.44831.stgit@dusk.lan> <50C840C9.5000407@ti.com>
 <alpine.DEB.2.00.1212130541320.25415@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EBAF47B@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1212130726160.25415@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45865 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab2LMJS2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Dec 2012 04:18:28 -0500
In-Reply-To: <alpine.DEB.2.00.1212130726160.25415@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Dec 13, 2012 at 12:59:49, Paul Walmsley wrote:
> On Thu, 13 Dec 2012, Hiremath, Vaibhav wrote:
> 
> > On Thu, Dec 13, 2012 at 11:11:49, Paul Walmsley wrote:
> > > 
> > > The branch name to use is:
> > > 
> > > "TEST_pwrdm_post_fpwrst_devel_a_3.9"
> > 
> > If I am correct, it only includes one additional patch (merge commit), 
> > right???
> > 
> > commit d94831e0005fee743cefd28f4c20b7c435c71236
> > Merge: 3e885c6 80ab3b2
> > Author: Paul Walmsley <paul@pwsan.com>
> > Date:   Sun Dec 9 13:06:51 2012 -0700
> > 
> >     build fixes
> > 
> > 
> > 
> > Does this also fix sparse warnings? 
> 
> Just ran a quick sparse check on mach-omap2 at 3e885c6 and d94831e with 
> 'make -j4 C=2 arch/arm/mach-omap2', and no warnings showed up.  There were 
> some sparse issues that got fixed at an earlier point, though, so perhaps 
> you have an older copy of the branches somehow?
> 

Ignore my earlier comment on sparse warning, it was my wrong sparse tool 
which was culprit here. I am working on remote server, which has sparse 
present inside /usr/bin, and somehow my default config using that one 
instead of what I was building.

I fixed this by changing the PATH, and now I do not see any issues/warnings.

Thanks,
Vaibhav
