From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v5 00/14] OMAP: DMA: hwmod and DMA as platform device
Date: Thu, 2 Dec 2010 00:34:12 +0530
Message-ID: <20101201190412.GA8149@GLPP-machine>
References: <1290603110-14119-1-git-send-email-manjugk@ti.com>
 <20101125112811.GA27574@GLPP-machine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:57904 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755908Ab0LATDr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Dec 2010 14:03:47 -0500
Received: by mail-yw0-f47.google.com with SMTP id 2so3725302ywt.6
        for <linux-omap@vger.kernel.org>; Wed, 01 Dec 2010 11:03:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101125112811.GA27574@GLPP-machine>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>

Hi Tony/Kevin,

* G, Manjunath Kondaiah <manjugk@ti.com> [2010-11-25 16:58:11 +0530]:

> Kevin,
> 
> * G, Manjunath Kondaiah <manjugk@ti.com> [2010-11-24 18:21:36 +0530]:
> 
> > Patch series to convert DMA library into platform driver using platform
> > device model and adapting hwmod for omap2+.
> > 	
> [...]
> > 
> > Patch series applies on top of latest linux omap master branch:
> > *************************************************************************
> > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> > Branch: master
> > commit 25f7615faa843731af4eda7d05077f1c5132e1a9
> > Merge: 784bee8 8973a21
> > Author: Tony Lindgren <tony@atomide.com>
> > 
> >     Linux-omap rebuilt: Updated to -rc3
> > *************************************************************************
> 
> It also applies cleanly on top of:
> 
> *************************************************************************
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
> Branch: pm-core
> commit 8bcd9727ee126dc50093e84f19dd6c118842202f
> Merge: 632dd87 25f7a1d
> Author: Kevin Hilman <khilman@deeprootsystems.com>
> 
>     Merge branch 'pm-hacks' into pm-reset
>   
> *************************************************************************
Do you have any further comments for this series?

-Manjunath
[...]
