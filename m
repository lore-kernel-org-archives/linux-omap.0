From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: hwmod changes for v3.13
Date: Fri, 11 Oct 2013 22:30:18 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310112229180.27397@utopia.booyaka.com>
References: <alpine.DEB.2.02.1310111659500.27397@utopia.booyaka.com> <20131011222634.GB29913@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:60919 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640Ab3JKWaT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 18:30:19 -0400
In-Reply-To: <20131011222634.GB29913@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 11 Oct 2013, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [131011 10:08]:
>
> > Basic test logs are available at:
> > 
> > http://www.pwsan.com/omap/testlogs/prcm_fixes_v3.13/20131009094936/
> > 
> > The summary reports that the 4460varsomom boots are failing, but this looks
> > incorrect - it's probably a bug in the validation scripts here.
> 
> OK I'll do a test on my panda es before sending out the branches
> and will apply that one hwmod patch Benoit had queued on top
> of this. So pulling into omap-for-v3.13/hwmod.

Thanks.  It boots fine on 4460varsomom, if you look at the boot log:

http://www.pwsan.com/omap/testlogs/prcm_fixes_v3.13/20131009094936/boot/4460varsomom/4460varsomom_log.txt

Otherwise I wouldn't have sent the pull request.


- Paul
