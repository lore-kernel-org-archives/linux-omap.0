From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
Date: Mon, 30 Aug 2010 15:53:13 -0700
Message-ID: <20100830225313.GB11597@atomide.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
 <000601cb42e4$85c7ed80$9157c880$@deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56033 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063Ab0H3WxV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Aug 2010 18:53:21 -0400
Content-Disposition: inline
In-Reply-To: <000601cb42e4$85c7ed80$9157c880$@deacon@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, bryan.wu@canonical.com

* Will Deacon <will.deacon@arm.com> [100823 09:51]:
> Hi Tony,
> 
> > Hi all,
> > 
> > Here are some experimental patches to allow booting ARMv7 SMP
> > kernel on UP to some extent. Posting these early in case it is
> > of any help as I know at least Bryan Wu is working on similar
> > issues.
> > 
> > The patches are very much work in progress, and does not quite
> > boot to init yet so there's all kinds of things to fix. But at
> > least these patches allow booting to the point where the fixing
> > issues might be a bit easier.. Currently it boots to the point
> > where there are tons of "WARNING: at mm/percpu-vm.c:320 pcpu_alloc"
> > prints.
> 
> I've got some similar hacks for the RealView boards which I've used
> to build a Kernel that can boot on the PB-A8 and PBX-A9. Whilst this
> is the wrong way of going about solving the problem [Russell's code
> patching is a lot neater and more scaleable] you might be interested
> in looking at the code anyway:
> 
> http://www.linux-arm.org/git?p=linux-2.6-wd.git;a=shortlog;h=refs/heads/smp-up-hacks
> 
> Only v7 cores are supported and TEX remapping is used to avoid having
> to worry about setting the shared attribute at runtime. Yuck!

Heh cool, I'll take a look at those :)

Tony
