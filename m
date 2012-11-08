From: Mike Turquette <mturquette@ti.com>
Subject: Re: [PATCH v2 00/26] Move OMAP2+ over to common clk framework
Date: Wed, 7 Nov 2012 17:54:22 -0800
Message-ID: <20121108015422.17381.81921@nucleus>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com>
 <20121108013140.17381.66421@nucleus> <20121108014218.GY6801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38556 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab2KHByn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 20:54:43 -0500
In-Reply-To: <20121108014218.GY6801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: paul@pwsan.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Quoting Tony Lindgren (2012-11-07 17:42:18)
> Hi,
> 
> * Mike Turquette <mturquette@linaro.org> [121107 17:33]:
> > Doh, I got the LAKML address wrong...
> > 
> > Thankfully it's already up on some archives:
> > http://article.gmane.org/gmane.linux.ports.arm.omap/88824
> > 
> > For anyone interested in testing:
> > git://git.linaro.org/people/mturquette/linux.git clk-omap-3.8
> > 
> > Regards,
> > Mike
> > 
> > Quoting Mike Turquette (2012-11-07 17:12:35)
> > > From: Mike Turquette <mturquette@linaro.org>
> > > 
> > > Hi all,
> > > 
> > > This series is based on top of Paul's PRM/CM clean-up work.  It is a
> > > refresh of the patches Rajendra sent out a while back[1], with the
> > > addition of several fixes for PM regressions[2] across several
> > > platforms.
> > > 
> > > I have tested on OMAP4430 Panda including PRCM diffing against pre-CCF
> > > patches (delta is zero) and also suspend/resume.
> > > 
> > > I also tested on OMAP4460 Panda-ES.  Boot is fine and PRCM programming
> > > appears sane.  However Panda-ES never comes back from suspend/resume.
> > > This problem exists on the PRM/CM branch I based on and was not
> > > introduced by this series.  I am investigating that independently of
> > > this series.
> 
> Cool! Do we still have some omaps that have issues booting with
> these?
> 

We shouldn't (fingers crossed).  I've just now stolen a Beagle and a
Bone to test, but I'm going to have to get bootloaders and a userspace
all set up for them which will take some time.

I believe Paul is planning on putting this series through his automated
test rig.

Regards,
Mike

> Regards,
> 
> Tony
> 
> 
> > > Anyone wanting to pull the work can find it at:
> > > git://git.linaro.org/people/mturquette/linux.git clk-omap-3.8
> > > 
> > > [1] http://article.gmane.org/gmane.linux.ports.arm.omap/78771
> > > [2] http://article.gmane.org/gmane.linux.ports.arm.omap/84015
