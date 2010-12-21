From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [GIT] pull request: DMA hwmod changes
Date: Tue, 21 Dec 2010 10:19:38 +0530
Message-ID: <20101221044938.GA21531@manju-desktop>
References: <20101219035948.GC15568@GLPP-machine>
 <4D0F33C9.40402@ti.com>
 <20101221021152.GA18883@manju-desktop>
 <20101221034836.GE5829@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:53017 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933574Ab0LUEtv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 23:49:51 -0500
Received: by yxm34 with SMTP id 34so1601489yxm.8
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 20:49:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101221034836.GE5829@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Sawant, Anand" <sawant@ti.com>

On Mon, Dec 20, 2010 at 07:48:36PM -0800, Tony Lindgren wrote:
> Hi,
> 
> * G, Manjunath Kondaiah <manjugk@ti.com> [101220 18:11]:
> > Hi Tony,
> > Benoit comments are taken care and new pull request is generated as
> > below. The omap4 hwmod database for dma is rearranged as per Benoit's
> > convention + no idlest flag entry is removed + sysc_flags are barrowed
> > from latest omap4 hwmod data base.
> 
> OK great, I've applied them now.

Thanks.

>  
> > The following changes since commit 205e4d6e8d892176d791b77a974efe7f561ca4c3:
> > 
> >   Merge branch 'for-next' (2010-12-17 19:32:47 -0800)
> 
> I ended up cherry picking them. For next time, note that you should not
> do any git branches to pull against anything but mainline tags. Otherwise
> tons of non-mainline history would get merged..

ok. Since you mentioned in one of previous mail that, you will be
merging these changes to l-o master for testing hence I generated pull
request against l-o master.

> 
> If you cannot base your branch on some recent mainline tag because of
> conflicts, then you should use some branch that will stay around,
> like what we have queued into omap-for-linus.
ok. Will do this in future.

-Manjunath
