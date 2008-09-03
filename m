From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Wed, 3 Sep 2008 22:07:19 +0100
Message-ID: <20080903210719.GK19980@flint.arm.linux.org.uk>
References: <20080827220821.GE7227@flint.arm.linux.org.uk> <a0580c510809030833w6cbc7e42ye0e8f4fc49b5b046@mail.gmail.com> <20080903184804.GA1788@flint.arm.linux.org.uk> <a0580c510809031233x452968f5g84311eb694cdde45@mail.gmail.com> <20080903194824.GE19980@flint.arm.linux.org.uk> <a0580c510809031304p1da1d0f7h4f7c97e377505bc5@mail.gmail.com> <20080903204524.GI19980@flint.arm.linux.org.uk> <20080903205004.GW23085@atomide.com> <20080903205618.GX23085@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60092 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbYICVHd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 17:07:33 -0400
Content-Disposition: inline
In-Reply-To: <20080903205618.GX23085@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-omap@vger.kernel.org

On Wed, Sep 03, 2008 at 01:56:18PM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [080903 13:50]:
> > There is a 3450 public TRM somewhere AFAIK, anybody got a link for that?
> > At least 5912 TRM is available somewhere.
> 
> Sorry I meant 3550 public TRM. Here's the link to the 5912 TRM,
> which covers 16xx.
> 
> http://focus.ti.com/dsp/docs/dspsupporttechdocsc.tsp?abstractName=spru742&sectionId=3&tabId=409

Hmm, claims to only be 106K, and xpdf 3 claims the file is unreadable.
